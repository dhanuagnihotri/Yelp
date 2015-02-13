//
//  BusinessCell.h
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Business.h"

@interface BusinessCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *thumbImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceLabel;
@property (strong, nonatomic) IBOutlet UILabel *reviewsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *ratingsImageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;
@property (strong,nonatomic) Business *business;

@end
