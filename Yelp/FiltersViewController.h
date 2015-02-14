//
//  FiltersViewController.h
//  
//
//  Created by Dhanu Agnihotri on 2/12/15.
//
//

#import <UIKit/UIKit.h>

@class FiltersViewController;

@protocol FiltersViewControllerDelegate <NSObject>

-(void)filtersViewController:(FiltersViewController *)filterViewController didChangeFilters:(NSDictionary *)filters;

@end

@interface FiltersViewController : UIViewController

@property (nonatomic,weak) id <FiltersViewControllerDelegate> delegate;

@end
