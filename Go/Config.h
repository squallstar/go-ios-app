//
//  Config.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#define API_URL @"http://go.squallstar.it/api/2.0/"


#ifdef DEBUG
#    define DLog(...) NSLog(@"%s %@", __PRETTY_FUNCTION__, [NSString stringWithFormat:__VA_ARGS__])
#else
#    define DLog(...) /* */
#endif

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
