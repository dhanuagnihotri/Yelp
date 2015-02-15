//
//  BusinessCell.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "BusinessCell.h"
#import "UIImageView+AFNetworking.h"

@interface BusinessCell ()

@end

@implementation BusinessCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLabel.preferredMaxLayoutWidth =self.nameLabel.frame.size.width;
    self.thumbImageView.layer.cornerRadius = 3;
    self.thumbImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBusiness:(Business *)business
{
    _business = business;
    [self.thumbImageView setImageWithURL:[NSURL URLWithString:self.business.imageURL]];
    self.nameLabel.text = self.business.name;
    [self.ratingsImageView setImageWithURL:[NSURL URLWithString:self.business.ratingImageURL]];
    self.reviewsLabel.text = [NSString stringWithFormat:@"%ld Reviews",(long)self.business.numReviews];
    self.locationLabel.text = self.business.address;
    self.distanceLabel.text = [NSString stringWithFormat:@"%0.2f mi",self.business.distance];
    self.categoryLabel.text = self.business.categories;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    self.nameLabel.preferredMaxLayoutWidth =self.nameLabel.frame.size.width;
}
@end
