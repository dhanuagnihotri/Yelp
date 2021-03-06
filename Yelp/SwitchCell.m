//
//  SwitchCell.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/13/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "SwitchCell.h"

@interface SwitchCell ()
@property (strong, nonatomic) IBOutlet UISwitch *toggleSwitch;
- (IBAction)switchValueChanged:(id)sender;


@end
@implementation SwitchCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.toggleSwitch.backgroundColor = [UIColor colorWithRed:0.769 green:0.769 blue:0.769 alpha:1] /*#c4c4c4*/;
    self.toggleSwitch.layer.cornerRadius = 16.0;
    self.toggleSwitch.transform = CGAffineTransformMakeScale(1.2, 1);
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 10;
    frame.size.width -= 2 * 10;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOn:(BOOL)on
{
    [self setOn:on animated:NO];
}

-(void)setOn:(BOOL)on animated:(BOOL)animated
{
    _on= on;
    [self.toggleSwitch setOn:on animated:animated];
}

- (IBAction)switchValueChanged:(id)sender {
    [self.delegate switchCell:self didUpdateValue:self.toggleSwitch.on];
}
@end
