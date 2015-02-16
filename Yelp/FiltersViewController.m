//
//  FiltersViewController.m
//  
//
//  Created by Dhanu Agnihotri on 2/12/15.
//
//

#import "FiltersViewController.h"
#import "SwitchCell.h"

@interface FiltersViewController () <UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate>

@property (nonatomic,readonly) NSDictionary* filters;

@property (strong, nonatomic) NSMutableArray *filtersTable;
@property (strong, nonatomic) IBOutlet UITableView *filtersTableView;

@property (nonatomic, strong) NSArray *popularCategories;
@property (nonatomic,strong) NSMutableSet *selectedPopularMode;

@property (nonatomic, strong) NSArray *sortModeCategories;
@property (nonatomic,strong) NSMutableSet *selectedSortMode;

@property (nonatomic, strong) NSArray *distanceCategories;
@property (nonatomic,strong) NSMutableSet *selectedDistance;

@property (strong, nonatomic) NSArray* categories;
@property (nonatomic,strong) NSMutableSet *selectedCategories;

-(void)initCategories;

@end

@implementation FiltersViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        //Build the array for table view section headers
        self.filtersTable = [[NSMutableArray alloc] initWithArray:@[
                                                                    @{@"title": @"Most Popular", },
                                                                    @{@"title": @"Distance", },
                                                                    @{@"title": @"Sort by", },
                                                                    ]];
        
        self.popularCategories = @[@{@"name": @"Offering a Deal", @"code":@TRUE },];
        self.selectedPopularMode = [NSMutableSet set];
        
        self.sortModeCategories = @[
                              @{@"name": @"Best Match", @"code":@"0" },
                              @{@"name": @"Distance",   @"code" : @"1"},
                              @{@"name": @"Rating", @"code" : @"2" },
                              ];
        self.selectedSortMode = [NSMutableSet set];
        
        int milesTometers = 1609.34;
        self.distanceCategories = @[
                                    @{@"name": @"Best Match", @"code":@0 },
                                    @{@"name": @"0.3 miles",   @"code":[NSNumber numberWithDouble:(0.3*milesTometers)]},
                                    @{@"name": @"1 mile", @"code" : [NSNumber numberWithDouble:(1*milesTometers)]},
                                    @{@"name": @"5 miles", @"code" :[NSNumber numberWithDouble:(5*milesTometers)]},
                                    @{@"name": @"20 miles", @"code" : [NSNumber numberWithDouble:(20*milesTometers)] },
                                    ];
        self.selectedDistance = [NSMutableSet set];

        self.selectedCategories = [NSMutableSet set];
        [self initCategories];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancelButton)];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStylePlain target:self action:@selector(onSearchButton)];
    
    self.navigationController.navigationBar.barTintColor=  [UIColor colorWithRed:0.816 green:0.094 blue:0.024 alpha:1]; 
    
    self.filtersTableView.dataSource = self;
    self.filtersTableView.delegate = self;
    
    [self.filtersTableView registerNib:[UINib nibWithNibName:@"SwitchCell" bundle:nil] forCellReuseIdentifier:@"SwitchCell"];
    
    [self.filtersTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    [[UILabel appearanceWhenContainedIn:[UITableViewHeaderFooterView class], nil] setFont:[UIFont boldSystemFontOfSize:12]];
    
    if([self.searchString isEqualToString:@"Restaurants"])
        [self.filtersTable addObject:@{@"title": @"Categories", }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview methods
#pragma mark - Movie Tableview methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.filtersTable count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows =0;
    switch (section) {
        case 0:
            rows = self.popularCategories.count;
            break;
        case 1:
            rows = self.distanceCategories.count;
            break;
        case 2:
            rows = self.sortModeCategories.count;
            break;
        case 3:
            rows = self.categories.count;
        default:
            break;
    }
    return rows;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SwitchCell"];
    
    cell.delegate = self;
//    cell.titleLabel.text= self.filtersTable[indexPath.section][@"rows"][indexPath.row];
    
    [cell.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    [cell.contentView.layer setBorderWidth:1.0f];
    cell.clipsToBounds = YES;
    cell.contentView.layer.borderWidth = 1.0;
    cell.contentView.layer.cornerRadius = 5;

    cell.on = NO;
    switch (indexPath.section) {
        case 0:
            cell.titleLabel.text = self.popularCategories[indexPath.row][@"name"];
            cell.on = [self.selectedPopularMode containsObject:self.popularCategories[indexPath.row]];
            break;
        case 1:
            cell.titleLabel.text = self.distanceCategories[indexPath.row][@"name"];
            cell.on = [self.selectedDistance containsObject:self.distanceCategories[indexPath.row]];
            break;
        case 2:
            cell.titleLabel.text = self.sortModeCategories[indexPath.row][@"name"];
            cell.on = [self.selectedSortMode containsObject:self.sortModeCategories[indexPath.row]];
            break;
        case 3:
            cell.titleLabel.text = self.categories[indexPath.row][@"name"];
            cell.on = [self.selectedCategories containsObject:self.categories[indexPath.row]];
        default:
            break;
    }


    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return self.filtersTable[section][@"title"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if([view isKindOfClass:[UITableViewHeaderFooterView class]]){
        UITableViewHeaderFooterView *tableViewHeaderFooterView = (UITableViewHeaderFooterView *) view;
        tableViewHeaderFooterView.textLabel.text = [tableViewHeaderFooterView.textLabel.text capitalizedString];
    }
}

-(void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value
{
    NSIndexPath *indexPath = [self.filtersTableView indexPathForCell:cell];
    
    if(indexPath.section==0)
    {
        [self.selectedPopularMode removeAllObjects];
        [self.selectedPopularMode addObject:self.popularCategories[indexPath.row]];
    }
    else if (indexPath.section==1)
    {
        [self.selectedDistance removeAllObjects];
        [self.selectedDistance addObject:self.distanceCategories[indexPath.row]];
        
    }
    else if (indexPath.section==2)
    {
        [self.selectedSortMode removeAllObjects];
        [self.selectedSortMode addObject:self.sortModeCategories[indexPath.row]];
    }
    else if (indexPath.section==3)
    {
        if(value)
        {
            [self.selectedCategories addObject:self.categories[indexPath.row]];
        }
        else
        {
            [self.selectedCategories removeObject:self.categories[indexPath.row]];
        }
    }

    [self.filtersTableView reloadData];
}

#pragma mark - Private methods
-(NSDictionary *)filters
{
    NSMutableDictionary *filters = [NSMutableDictionary dictionary];
    if(self.selectedSortMode.count >0) //user has selected a sort mode
    {
        //This set will always have just one value
        for(NSDictionary *category in self.selectedSortMode)
        {
            [filters setObject:category[@"code"] forKey:@"sort"];
        }
    }
    if(self.selectedDistance.count >0) //user has selected a sort mode
    {
        //This set will always have just one value
        for(NSDictionary *category in self.selectedDistance)
        {
            [filters setObject:category[@"code"] forKey:@"radius_filter"];
        }
    }
    if(self.selectedPopularMode.count >0)
    {
        for(NSDictionary *category in self.selectedPopularMode)
        {
            if([category[@"name"] isEqualToString:@"Offering a Deal"])
            {
                [filters setObject:category[@"code"] forKey:@"deals_filter"];
            }
        }
    }
    
    //This only applies for restaurants
    if(self.selectedCategories.count >0)
    {
        NSMutableArray *names = [NSMutableArray array];
        for(NSDictionary *category in self.selectedCategories)
        {
            [names addObject:category[@"code"]];
        }
        NSString *categoryFilter = [names componentsJoinedByString:@","];
        [filters setObject:categoryFilter forKey:@"category_filter"];
    }
    return filters;
}

-(void)onCancelButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onSearchButton
{
    [self.delegate filtersViewController:self didChangeFilters:self.filters];
    [self dismissViewControllerAnimated:YES completion:nil];    
}

-(void)initCategories
{
    self.categories = @[@{@"name" : @"Afghan", @"code": @"afghani" },
                            @{@"name" : @"African", @"code": @"african" },
                            @{@"name" : @"Senegalese", @"code": @"senegalese" },
                            @{@"name" : @"South African", @"code": @"southafrican" },
                            @{@"name" : @"American, New", @"code": @"newamerican" },
                            @{@"name" : @"American, Traditional", @"code": @"tradamerican" },
                            @{@"name" : @"Arabian", @"code": @"arabian" },
                            @{@"name" : @"Argentine", @"code": @"argentine" },
                            @{@"name" : @"Armenian", @"code": @"armenian" },
                            @{@"name" : @"Asian Fusion", @"code": @"asianfusion" },
                            @{@"name" : @"Australian", @"code": @"australian" },
                            @{@"name" : @"Austrian", @"code": @"austrian" },
                            @{@"name" : @"Bangladeshi", @"code": @"bangladeshi" },
                            @{@"name" : @"Barbeque", @"code": @"bbq" },
                            @{@"name" : @"Basque", @"code": @"basque" },
                            @{@"name" : @"Belgian", @"code": @"belgian" },
                            @{@"name" : @"Brasseries", @"code": @"brasseries" },
                            @{@"name" : @"Brazilian", @"code": @"brazilian" },
                            @{@"name" : @"Breakfast & Brunch", @"code": @"breakfast_brunch" },
                            @{@"name" : @"British", @"code": @"british" },
                            @{@"name" : @"Buffets", @"code": @"buffets" },
                            @{@"name" : @"Burgers", @"code": @"burgers" },
                            @{@"name" : @"Burmese", @"code": @"burmese" },
                            @{@"name" : @"Cafes", @"code": @"cafes" },
                            @{@"name" : @"Cafeteria", @"code": @"cafeteria" },
                            @{@"name" : @"Cajun/Creole", @"code": @"cajun" },
                            @{@"name" : @"Cambodian", @"code": @"cambodian" },
                            @{@"name" : @"Caribbean", @"code": @"caribbean" },
                            @{@"name" : @"Dominican", @"code": @"dominican" },
                            @{@"name" : @"Haitian", @"code": @"haitian" },
                            @{@"name" : @"Puerto Rican", @"code": @"puertorican" },
                            @{@"name" : @"Trinidadian", @"code": @"trinidadian" },
                            @{@"name" : @"Catalan", @"code": @"catalan" },
                            @{@"name" : @"Cheesesteaks", @"code": @"cheesesteaks" },
                            @{@"name" : @"Chicken Shop", @"code": @"chickenshop" },
                            @{@"name" : @"Chicken Wings", @"code": @"chicken_wings" },
                            @{@"name" : @"Chinese", @"code": @"chinese" },
                            @{@"name" : @"Cantonese", @"code": @"cantonese" },
                            @{@"name" : @"Dim Sum", @"code": @"dimsum" },
                            @{@"name" : @"Shanghainese", @"code": @"shanghainese" },
                            @{@"name" : @"Szechuan", @"code": @"szechuan" },
                            @{@"name" : @"Comfort Food", @"code": @"comfortfood" },
                            @{@"name" : @"Corsican", @"code": @"corsican" },
                            @{@"name" : @"Creperies", @"code": @"creperies" },
                            @{@"name" : @"Cuban", @"code": @"cuban" },
                            @{@"name" : @"Czech", @"code": @"czech" },
                            @{@"name" : @"Delis", @"code": @"delis" },
                            @{@"name" : @"Diners", @"code": @"diners" },
                            @{@"name" : @"Fast Food", @"code": @"hotdogs" },
                            @{@"name" : @"Filipino", @"code": @"filipino" },
                            @{@"name" : @"Fish & Chips", @"code": @"fishnchips" },
                            @{@"name" : @"Fondue", @"code": @"fondue" },
                            @{@"name" : @"Food Court", @"code": @"food_court" },
                            @{@"name" : @"Food Stands", @"code": @"foodstands" },
                            @{@"name" : @"French", @"code": @"french" },
                            @{@"name" : @"Gastropubs", @"code": @"gastropubs" },
                            @{@"name" : @"German", @"code": @"german" },
                            @{@"name" : @"Gluten-Free", @"code": @"gluten_free" },
                            @{@"name" : @"Greek", @"code": @"greek" },
                            @{@"name" : @"Halal", @"code": @"halal" },
                            @{@"name" : @"Hawaiian", @"code": @"hawaiian" },
                            @{@"name" : @"Himalayan/Nepalese", @"code": @"himalayan" },
                            @{@"name" : @"Hong Kong Style Cafe", @"code": @"hkcafe" },
                            @{@"name" : @"Hot Dogs", @"code": @"hotdog" },
                            @{@"name" : @"Hot Pot", @"code": @"hotpot" },
                            @{@"name" : @"Hungarian", @"code": @"hungarian" },
                            @{@"name" : @"Iberian", @"code": @"iberian" },
                            @{@"name" : @"Indian", @"code": @"indpak" },
                            @{@"name" : @"Indonesian", @"code": @"indonesian" },
                            @{@"name" : @"Irish", @"code": @"irish" },
                            @{@"name" : @"Italian", @"code": @"italian" },
                            @{@"name" : @"Japanese", @"code": @"japanese" },
                            @{@"name" : @"Ramen", @"code": @"ramen" },
                            @{@"name" : @"Teppanyaki", @"code": @"teppanyaki" },
                            @{@"name" : @"Korean", @"code": @"korean" },
                            @{@"name" : @"Kosher", @"code": @"kosher" },
                            @{@"name" : @"Laotian", @"code": @"laotian" },
                            @{@"name" : @"Latin American", @"code": @"latin" },
                            @{@"name" : @"Colombian", @"code": @"colombian" },
                            @{@"name" : @"Salvadorean", @"code": @"salvadorean" },
                            @{@"name" : @"Venezuelan", @"code": @"venezuelan" },
                            @{@"name" : @"Live/Raw Food", @"code": @"raw_food" },
                            @{@"name" : @"Malaysian", @"code": @"malaysian" },
                            @{@"name" : @"Mediterranean", @"code": @"mediterranean" },
                            @{@"name" : @"Falafel", @"code": @"falafel" },
                            @{@"name" : @"Mexican", @"code": @"mexican" },
                            @{@"name" : @"Middle Eastern", @"code": @"mideastern" },
                            @{@"name" : @"Egyptian", @"code": @"egyptian" },
                            @{@"name" : @"Lebanese", @"code": @"lebanese" },
                            @{@"name" : @"Modern European", @"code": @"modern_european" },
                            @{@"name" : @"Mongolian", @"code": @"mongolian" },
                            @{@"name" : @"Moroccan", @"code": @"moroccan" },
                            @{@"name" : @"Pakistani", @"code": @"pakistani" },
                            @{@"name" : @"Persian/Iranian", @"code": @"persian" },
                            @{@"name" : @"Peruvian", @"code": @"peruvian" },
                            @{@"name" : @"Pizza", @"code": @"pizza" },
                            @{@"name" : @"Polish", @"code": @"polish" },
                            @{@"name" : @"Portuguese", @"code": @"portuguese" },
                            @{@"name" : @"Poutineries", @"code": @"poutineries" },
                            @{@"name" : @"Russian", @"code": @"russian" },
                            @{@"name" : @"Salad", @"code": @"salad" },
                            @{@"name" : @"Sandwiches", @"code": @"sandwiches" },
                            @{@"name" : @"Scandinavian", @"code": @"scandinavian" },
                            @{@"name" : @"Scottish", @"code": @"scottish" },
                            @{@"name" : @"Seafood", @"code": @"seafood" },
                            @{@"name" : @"Singaporean", @"code": @"singaporean" },
                            @{@"name" : @"Slovakian", @"code": @"slovakian" },
                            @{@"name" : @"Soul Food", @"code": @"soulfood" },
                            @{@"name" : @"Soup", @"code": @"soup" },
                            @{@"name" : @"Southern", @"code": @"southern" },
                            @{@"name" : @"Spanish", @"code": @"spanish" },
                            @{@"name" : @"Sri Lankan", @"code": @"srilankan" },
                            @{@"name" : @"Steakhouses", @"code": @"steak" },
                            @{@"name" : @"Sushi Bars", @"code": @"sushi" },
                            @{@"name" : @"Taiwanese", @"code": @"taiwanese" },
                            @{@"name" : @"Tapas Bars", @"code": @"tapas" },
                            @{@"name" : @"Tapas/Small Plates", @"code": @"tapasmallplates" },
                            @{@"name" : @"Tex-Mex", @"code": @"tex-mex" },
                            @{@"name" : @"Thai", @"code": @"thai" },
                            @{@"name" : @"Turkish", @"code": @"turkish" },
                            @{@"name" : @"Ukrainian", @"code": @"ukrainian" },
                            @{@"name" : @"Uzbek", @"code": @"uzbek" },
                            @{@"name" : @"Vegan", @"code": @"vegan" },
                            @{@"name" : @"Vegetarian", @"code": @"vegetarian" },
                            @{@"name" : @"Vietnamese", @"code": @"vietnamese" }];
 }

@end
