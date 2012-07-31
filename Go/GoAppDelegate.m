//
//  GoAppDelegate.m
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "GoAppDelegate.h"
#import "LoginController.h"
#import "LinksController.h"

@implementation GoAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [self showLogin];
    
    [self.window makeKeyAndVisible];
    return YES;
}

-(void)showLogin {
    if (self.loginController == nil) {
        self.loginController = [[LoginController alloc] initWithNibName:@"LoginController" bundle:nil];
    }
    
    self.window.rootViewController = self.loginController;
}

-(void)showDashboard {
    if (self.linksController == nil) {
        self.linksController = [[LinksController alloc] initWithNibName:@"LinksController" bundle:nil];
    }
    
    self.window.rootViewController = self.linksController;
}

@end