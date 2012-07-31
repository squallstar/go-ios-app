//
//  Categories.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "libs/SynthesizeSingleton.h"

@interface Categories : NSObject

@property (nonatomic, retain) NSMutableDictionary *itemsByKey;
@property (nonatomic, retain) NSArray *items;

+(Categories*)sharedCategories;
+(NSArray*)allCategories;

-(NSDictionary *)categoryForKey:(int)categoryId;

-(void)addCategories:(NSArray*)newCategories;
-(void)updateCategories:(void (^)(NSArray *newCategories))onComplete;

@end
