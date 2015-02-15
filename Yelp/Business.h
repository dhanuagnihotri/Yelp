//
//  Business.h
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Business : NSObject

@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *ratingImageURL;
@property (nonatomic, assign) NSInteger numReviews;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *categories;
@property (nonatomic, assign) CGFloat distance;
@property (nonatomic, strong) NSString *longitude;
@property (nonatomic, strong) NSString *latitude;
@property (nonatomic, strong) NSString *displayAddress;
@property (nonatomic, strong) NSString *phone;

+(NSArray*)BusinessWithDictionary:(NSArray*)dictionaries;

@end
