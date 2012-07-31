//
//  Categories.m
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "Categories.h"
#import "API.h"
#import "libs/AFNetworking/AFJSONRequestOperation.h"

@implementation Categories

SYNTHESIZE_SINGLETON_FOR_CLASS(Categories);

-(id)init {
    if (self = [super init]) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"categories"]) {
            self.items = [[NSUserDefaults standardUserDefaults] objectForKey:@"categories"];
            [self rebuildCategoriesByKey];
        }
    }
    return self;
}

+(NSArray*)allCategories {
    return [[Categories sharedCategories] items];
}

-(void)addCategories:(NSArray*)newCategories {
    if (self.items) {
        [self.items release];
        self.items = nil;
    }
    self.items = [newCategories retain];
    [[NSUserDefaults standardUserDefaults] setObject:self.items forKey:@"categories"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self rebuildCategoriesByKey];
}

-(void)updateCategories:(void (^)(NSArray *newCategories))onComplete {
    NSMutableURLRequest *r = [[API sharedAPI].client requestWithMethod:@"GET" path:@"labels" parameters:nil];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:r success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
       
        //DLog(@"%@", JSON);
        
        if ([[JSON objectForKey:@"code"] intValue] == 200) {
            
            [self addCategories:[JSON objectForKey:@"data"]];
            if (onComplete) onComplete([JSON objectForKey:@"data"]);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        DLog(@"%@", error.localizedDescription);
    }] start];
}

-(void)rebuildCategoriesByKey {
    if (!self.itemsByKey) {
        self.itemsByKey = [[NSMutableDictionary alloc] initWithCapacity:self.items.count];
    } else {
        [self.itemsByKey removeAllObjects];
    }
    
    for (NSDictionary *category in self.items) {
        [self.itemsByKey setObject:category forKey:[category objectForKey:@"id"]];
    }
}

-(NSDictionary *)categoryForKey:(int)categoryId {
    NSNumber *catId = [NSNumber numberWithInt:categoryId];
    return [self.itemsByKey objectForKey:catId] ? [self.itemsByKey objectForKey:catId] : nil;
}

@end
