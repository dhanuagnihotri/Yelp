//
//  YelpClient.h
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BDBOAuth1RequestOperationManager.h"

@interface YelpClient : BDBOAuth1RequestOperationManager

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret;

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term offset:(NSNumber *)offset params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
