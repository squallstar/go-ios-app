//
//  LinkCell.m
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "LinkCell.h"
#import "../Categories.h"

@implementation LinkCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (selected) {
        self.alpha = 0.7f;
    } else {
        self.alpha = 1.0f;
    }
}

-(void)setLinkObject:(NSDictionary*)item {
    _titleLbl.text = [item objectForKey:@"title"];
    _urlLbl.text = [item objectForKey:@"url"];
    
    NSDictionary *category = nil;
    
    if (![[item objectForKey:@"label"] isKindOfClass:[NSNull class]]) {
        category = [[Categories sharedCategories] categoryForKey:[[item objectForKey:@"label"] intValue]];
    }
    
    if (category) {
        _categoryLbl.text = [category objectForKey:@"name"];
        
        NSScanner *scanner2 = [NSScanner scannerWithString:[category objectForKey:@"color"]];
        unsigned int baseColor1;
        [scanner2 scanHexInt:&baseColor1];
        
        CGFloat red   = ((baseColor1 & 0xFF0000) >> 16) / 255.0f;
        CGFloat green = ((baseColor1 & 0x00FF00) >>  8) / 255.0f;
        CGFloat blue  =  (baseColor1 & 0x0000FF) / 255.0f;
        
        _categorySideView.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
        
    } else {
        _categoryLbl.text = @"Nessuna categoria";
        _categorySideView.backgroundColor = [UIColor whiteColor];
    }
    
    _categoryLbl.textColor = _categorySideView.backgroundColor;
}

@end
