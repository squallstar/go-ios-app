//
//  API.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libs/SynthesizeSingleton.h"
#import "libs/AFNetworking/AFHTTPClient.h"

@interface API : NSObject

+ (API *)sharedAPI;


-(void)getLinksByName:(NSString*)nameOrNil andCategoryId:(int)categoryOrZero success:(void (^)(NSArray *links))onComplete;

@property (nonatomic, retain) AFHTTPClient *client;

@end
