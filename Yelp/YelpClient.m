//
//  YelpClient.m
//  Yelp
//
//  Created by Dhanu Agnihotri on 2/11/15.
//  Copyright (c) 2015 ___SocietyTech___. All rights reserved.
//

#import "YelpClient.h"

@implementation YelpClient

- (id)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret accessToken:(NSString *)accessToken accessSecret:(NSString *)accessSecret {
    NSURL *baseURL = [NSURL URLWithString:@"http://api.yelp.com/v2/"];
    self = [super initWithBaseURL:baseURL consumerKey:consumerKey consumerSecret:consumerSecret];
    if (self) {
        BDBOAuth1Credential *token = [BDBOAuth1Credential credentialWithToken:accessToken secret:accessSecret expiration:nil];
        [self.requestSerializer saveAccessToken:token];
    }
    return self;
}

- (AFHTTPRequestOperation *)searchWithTerm:(NSString *)term offset:(NSNumber *)offset params:(NSDictionary*)params success:(void (^)(AFHTTPRequestOperation *operation, id response))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    NSNumber *limit = [NSNumber numberWithInteger:20]; //get 20 results at a time, use offset to get additional results
    // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
    NSDictionary *defaults = @{@"term": term, @"limit": limit, @"offset":offset, @"ll" : @"37.774866,-122.394556"};
    
    NSMutableDictionary *allParameters = [defaults mutableCopy];
    if(params)
    {
        [allParameters addEntriesFromDictionary:params];
    }
    
    return [self GET:@"search" parameters:allParameters success:success failure:failure];
}

@end
