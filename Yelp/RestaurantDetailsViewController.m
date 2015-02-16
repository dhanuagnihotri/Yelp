//
//  RestaurantDetailsViewController.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/15/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "RestaurantDetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import <MapKit/MapKit.h>

@interface RestaurantDetailsViewController ()
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingsImageView;
@property (strong, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong, nonatomic) IBOutlet MKMapView *locationMapView;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;
@property (strong, nonatomic) IBOutlet UILabel *phoneLabel;

@end

@implementation RestaurantDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBar.barTintColor=  [UIColor colorWithRed:0.816 green:0.094 blue:0.024 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];

    
    self.nameLabel.text = self.business.name;
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi",self.business.distance];    
    [self.ratingsImageView setImageWithURL:[NSURL URLWithString:self.business.ratingImageURL]];
    self.reviewsLabel.text = [NSString stringWithFormat:@"%ld Reviews",(long)self.business.numReviews];
    self.categoryLabel.text = self.business.categories;
    self.addressLabel.text = self.business.displayAddress;
    self.phoneLabel.text = self.business.phone;

    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([self.business.latitude floatValue],[self.business.longitude floatValue]);

    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 500, 500);
    [self.locationMapView setRegion:[self.locationMapView regionThatFits:region] animated:YES];
    [self.locationMapView addAnnotation:point];
    
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

@end
