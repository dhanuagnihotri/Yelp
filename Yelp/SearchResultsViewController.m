//
//  SearchResultsViewController.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/10/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "YelpClient.h"
#import "Business.h"
#import "BusinessCell.h"
#import "FiltersViewController.h"
#import "MapViewController.h"
#import "SVPullToRefresh.h"
#import "RestaurantDetailsViewController.h"

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface SearchResultsViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, FiltersViewControllerDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIButton *filterButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) NSArray* businessesResults;
@property (strong, nonatomic) NSMutableArray *businesses;
@property (strong, nonatomic) IBOutlet UITableView *searchResults;

@property (strong, nonatomic)  UISearchBar *searchBar;
@property (strong,nonatomic) NSString *searchString;
- (IBAction)filterButtonPressed:(UIButton *)sender;
- (IBAction)mapButtonPressed:(id)sender;

@property (nonatomic, strong) YelpClient *client;

-(void)fetchBusinessWithQuery:(NSString *)query offset:(NSNumber *)offset params:(NSDictionary *)params;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.businesses =[[NSMutableArray alloc]init];
    
    self.navigationController.navigationBar.barTintColor=  [UIColor colorWithRed:0.816 green:0.094 blue:0.024 alpha:1]; /*#d01806*/
    self.filterButton.layer.borderColor = [UIColor colorWithRed:0.741 green:0.082 blue:0.035 alpha:1].CGColor ;/*#bd1509*/
    self.filterButton.layer.borderWidth = 1.0;
    self.filterButton.layer.cornerRadius = 5;

    self.mapButton.layer.borderColor = [UIColor colorWithRed:0.741 green:0.082 blue:0.035 alpha:1].CGColor ;/*#bd1509*/
    self.mapButton.layer.borderWidth = 1.0;
    self.mapButton.layer.cornerRadius = 5;

    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{
                                                                                                 NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:12],
                                                                                                 }];
    self.searchString = @"Restaurants"; // To start off we will search for restraurants
    self.searchBar.text = self.searchString;
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self fetchBusinessWithQuery:self.searchString offset:@0 params:nil]; //search for restaurants to start off, no offset or filters
    
    [self.searchResults registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.searchResults.delegate = self;
    self.searchResults.dataSource = self;
    
    self.searchResults.rowHeight = UITableViewAutomaticDimension;
    
    // setup infinite scrolling
     __weak SearchResultsViewController *weakSelf = self;
    [self.searchResults addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertRowAtBottom {
    __weak SearchResultsViewController *weakSelf = self;
    
    int64_t delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
    [self.client searchWithTerm:self.searchString offset:@20 params:nil success:^(AFHTTPRequestOperation *operation, id response) {
            //        NSLog(@"response: %@", response);
            NSArray *businessDictionary = response[@"businesses"];
            self.businessesResults = [Business BusinessWithDictionary:businessDictionary];
            if(self.businessesResults.count>0)
            {
                [self.businesses addObjectsFromArray:self.businessesResults];
                [weakSelf.searchResults.infiniteScrollingView stopAnimating];
                
            }
            [self.searchResults reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    });
}

#pragma mark - Searchbar delegates 

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    self.searchString = self.searchBar.text;
    [self.businesses removeAllObjects];
    [self fetchBusinessWithQuery:self.searchString offset:@0 params:nil];
    [searchBar resignFirstResponder];
    [self.searchResults reloadData];
}


#pragma mark - Tableview delegates

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    cell.nameLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,cell.business.name];
    
    if([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)] )
        cell.preservesSuperviewLayoutMargins = false;
    if([cell respondsToSelector:@selector(setSeparatorInset:)] )
        cell.separatorInset = UIEdgeInsetsMake(0, 4, 0, 0);
    if([cell respondsToSelector:@selector(setLayoutMargins:)] )
        cell.layoutMargins = UIEdgeInsetsZero;
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    RestaurantDetailsViewController *vc = [[RestaurantDetailsViewController alloc]init];
    vc.business = self.businesses[indexPath.row];

    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1;
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
    FiltersViewController *vc = [[FiltersViewController alloc]init];
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    
    vc.delegate = self;
    [self presentViewController:nvc animated:YES completion:nil];
}

- (IBAction)mapButtonPressed:(id)sender {
    MapViewController *vc = [[MapViewController alloc]init];
    vc.businessLocations = self.businesses;
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
    nvc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    [self presentViewController:nvc animated:YES completion:nil];
}

-(void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSDictionary *)filters;
{
    //fire a new network event
    //NSLog(@"I got this event:%@", filters);
    //clean out the existing data in tableview
    [self.businesses removeAllObjects];
    [self fetchBusinessWithQuery:self.searchString offset:@0 params:filters];

}

-(void)fetchBusinessWithQuery:(NSString *)query offset:(NSNumber *)offset params:(NSDictionary *)params
{
    [self.client searchWithTerm:query offset:offset params:params success:^(AFHTTPRequestOperation *operation, id response) {
        
//        NSLog(@"response: %@", response);
        NSArray *businessDictionary = response[@"businesses"];
        self.businessesResults = [Business BusinessWithDictionary:businessDictionary];
        if(self.businessesResults.count>0)
        {
            [self.businesses addObjectsFromArray:self.businessesResults];
        }
        [self.searchResults reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
}
@end
