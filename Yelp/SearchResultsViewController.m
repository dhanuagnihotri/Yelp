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

NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface SearchResultsViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *filterButton;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (strong, nonatomic) NSArray* businesses;
@property (strong, nonatomic) IBOutlet UITableView *searchResults;

@property (strong, nonatomic)  UISearchBar *searchBar;
- (IBAction)filterButtonPressed:(UIButton *)sender;

@property (nonatomic, strong) YelpClient *client;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor=  [UIColor colorWithRed:0.816 green:0.094 blue:0.024 alpha:1]; /*#d01806*/
    self.filterButton.layer.borderColor = [UIColor colorWithRed:0.741 green:0.082 blue:0.035 alpha:1].CGColor ;/*#bd1509*/
    self.filterButton.layer.borderWidth = 1.0;
    self.filterButton.layer.cornerRadius = 5;

    self.mapButton.layer.borderColor = [UIColor colorWithRed:0.741 green:0.082 blue:0.035 alpha:1].CGColor ;/*#bd1509*/
    self.mapButton.layer.borderWidth = 1.0;
    self.mapButton.layer.cornerRadius = 5;

    self.searchBar = [UISearchBar new];
    self.searchBar.delegate = self;
//    self.searchBar.
    self.navigationItem.titleView = self.searchBar;
    
    // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
//        NSLog(@"response: %@", response);
        NSArray *businessDictionary = response[@"businesses"];
        self.businesses = [Business BusinessWithDictionary:businessDictionary];
        [self.searchResults reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error: %@", [error description]);
    }];
    
    [self.searchResults registerNib:[UINib nibWithNibName:@"BusinessCell" bundle:nil] forCellReuseIdentifier:@"BusinessCell"];
    
    self.searchResults.delegate = self;
    self.searchResults.dataSource = self;
    
    self.searchResults.rowHeight = UITableViewAutomaticDimension;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Tableview delegates

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.businesses.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusinessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BusinessCell"];
    cell.business = self.businesses[indexPath.row];
    

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
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    
//    MovieDetailViewController *vc = [[MovieDetailViewController alloc]init];
//    vc.movie = self.filteredMovies[indexPath.row];
//    
//    vc.hidesBottomBarWhenPushed = YES;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void) tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor orangeColor];
//    cell.backgroundColor = [UIColor orangeColor];
    
}

- (IBAction)filterButtonPressed:(UIButton *)sender {
}
@end
