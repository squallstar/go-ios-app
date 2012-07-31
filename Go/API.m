//
//  API.m
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "API.h"
#import "libs/AFNetworking/AFJSONRequestOperation.h"

@implementation API

SYNTHESIZE_SINGLETON_FOR_CLASS(API);

-(id)init {
    if (self = [super init]) {
        self.client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:API_URL]];
    }
    return self;
}

-(void)getLinksByName:(NSString*)nameOrNil andCategoryId:(int)categoryOrZero success:(void (^)(NSArray *newCategories))onComplete {
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithCapacity:2];
    
    if (nameOrNil != nil) {
        if (![nameOrNil isEqualToString:@""]) {
            [parameters setObject:nameOrNil forKey:@"search"];
        }
    }
    
    if (categoryOrZero > 0) {
        [parameters setObject:[NSString stringWithFormat:@"%i", categoryOrZero] forKey:@"label"];
    }
    
    NSMutableURLRequest *r = [self.client requestWithMethod:@"GET" path:@"links" parameters:parameters];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:r success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        //DLog(@"%@", JSON);
        
        if ([[JSON objectForKey:@"code"] intValue] == 200) {
            
            if (onComplete) onComplete([JSON objectForKey:@"data"]);
            
        } else {
            
            if (onComplete) onComplete(nil);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        DLog(@"%@", error.localizedDescription);
        
        if (onComplete) onComplete(nil);
    }] start];
}

@end
