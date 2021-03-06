//
//  Business.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "Business.h"

@implementation Business

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    
    if(self)
    {
        NSArray *categories = dictionary[@"categories"];
        NSMutableArray *categoryNames = [NSMutableArray array];
        [categories enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [categoryNames addObject:obj[0]];
        } ];
        self.categories = [categoryNames componentsJoinedByString:@", "];
        
        self.name = dictionary[@"name"];
        self.imageURL = dictionary [@"image_url"];
        NSArray *location = [dictionary valueForKeyPath:@"location.address"];
        
        if(location.count > 0)
        {
            NSString *street = [dictionary valueForKeyPath:@"location.address"][0];
            NSString *neighborhood = [dictionary valueForKeyPath:@"location.neighborhoods"][0];
            self.address = [NSString stringWithFormat:@"%@, %@",street,neighborhood];
        
            NSArray *address = [dictionary valueForKeyPath:@"location.display_address"];
            self.displayAddress = [address componentsJoinedByString:@", "];
            
            self.latitude = [dictionary valueForKeyPath:@"location.coordinate.latitude"] ;
            self.longitude = [dictionary valueForKeyPath:@"location.coordinate.longitude"] ;
            
        }
        else
        {
            self.address = @"";
        }
        self.numReviews = [dictionary[@"review_count"] integerValue];
        self.ratingImageURL = dictionary[@"rating_img_url"];
        
        float milesPerMeter = 0.000621371;
        self.distance = [dictionary[@"distance"] integerValue] * milesPerMeter;
        self.phone = dictionary[@"phone"];
     
    }
    return self;
}

+(NSArray*)BusinessWithDictionary:(NSArray*)dictionaries
{
    NSMutableArray *businesses = [[NSMutableArray alloc] init];
    for(NSDictionary *dict in dictionaries)
    {
        Business *business = [[Business alloc] initWithDictionary:dict];
        [businesses addObject:business];
    }
    return businesses;
}

@end
