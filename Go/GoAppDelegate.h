//
//  GoAppDelegate.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginController;
@class LinksController;

@interface GoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginController *loginController;
@property (strong, nonatomic) LinksController *linksController;

-(void)showLogin;
-(void)showDashboard;

@end
