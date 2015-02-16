//
//  MapViewController.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/14/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "MapViewController.h"
#import "Business.h"
#import <MapKit/MapKit.h>

@interface MapViewController () <MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 430, 71, 30);
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];
    [button addTarget:self action:@selector(onListButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"List" forState:UIControlStateNormal];
    UIBarButtonItem *useItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    button.layer.borderColor = [UIColor colorWithRed:0.741 green:0.082 blue:0.035 alpha:1].CGColor ;/*#bd1509*/
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 5;
    [self.navigationItem setRightBarButtonItems:@[useItem]];
    
    self.mapView.delegate = self;
    
  
    self.navigationController.navigationBar.barTintColor=  [UIColor colorWithRed:0.816 green:0.094 blue:0.024 alpha:1];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(37.774866,-122.394556), 3000, 3000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation for our hardcoded location
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(37.774866,-122.394556);
    [self.mapView addAnnotation:point];
    
    for(Business *business in self.businessLocations)
    {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = CLLocationCoordinate2DMake([business.latitude floatValue],[business.longitude floatValue]);
        [self.mapView addAnnotation:point];
    }
    
    
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView
//           viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    static NSString *reuseId = @"reuseid";
//    MKAnnotationView *av = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
//    if (av == nil)
//    {
//        av = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
//        
//        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
//        lbl.backgroundColor = [UIColor redColor];
//        lbl.textColor = [UIColor whiteColor];
//        lbl.alpha = 0.5;
//        lbl.tag = 42;
//        [av addSubview:lbl];
//    }
//    else
//    {
//        av.annotation = annotation;
//    }
//    
//    UILabel *lbl = (UILabel *)[av viewWithTag:42];
//    lbl.text = annotation.title;
//    
//    return av;
//}
-(void)onListButton
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
