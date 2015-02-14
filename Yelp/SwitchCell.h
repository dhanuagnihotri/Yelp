//
//  SwitchCell.h
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/13/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SwitchCell;

@protocol SwitchCellDelegate <NSObject>

-(void)switchCell:(SwitchCell *)cell didUpdateValue:(BOOL)value;

@end

@interface SwitchCell : UITableViewCell

@property (nonatomic,weak) id<SwitchCellDelegate> delegate;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,assign) BOOL on;

-(void)setOn:(BOOL)on animated:(BOOL)animated;

@end
