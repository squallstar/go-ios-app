//
//  LoginController.m
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "LoginController.h"
#import "API.h"
#import "libs/AFNetworking/AFJSONRequestOperation.h"
#import "GoAppDelegate.h"
#import "Categories.h"
#import "components/JSNotifier.h"

@interface LoginController ()

@end

@implementation LoginController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
   [super viewWillAppear:animated];
   
   NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
   if ([def objectForKey:@"username"]) {
      
      //Auto login
      _usernameText.text = [def objectForKey:@"username"];
      _passwordText.text = [def objectForKey:@"password"];
      
      for (UIView *v in self.view.subviews) {
         [v setHidden:YES];
      }
      
      [self tapLogin:nil];
   } else {
      if ([_usernameText.text isEqualToString:@""]) [_usernameText becomeFirstResponder];
      
      for (UIView *v in self.view.subviews) {
         [v setHidden:NO];
      }
   }
}

-(IBAction)tapLogin:(id)sender {
    
    if ([_usernameText.text isEqualToString:@""] || [_passwordText.text isEqualToString:@""]) {
        return;
    }
    
    _usernameText.enabled = NO;
    _passwordText.enabled = NO;
    [_usernameText resignFirstResponder];
    [_passwordText resignFirstResponder];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    
    JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"Login in corso..."];
    notify.accessoryView = activityIndicator;
    [notify show];
    
    NSURLRequest *r = [[API sharedAPI].client requestWithMethod:@"GET" path:@"login" parameters:[NSDictionary dictionaryWithObjectsAndKeys:self.usernameText.text, @"uid", self.passwordText.text, @"password", nil]];
    
    [[AFJSONRequestOperation JSONRequestOperationWithRequest:r success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        _usernameText.enabled = YES;
        _passwordText.enabled = YES;
        
        //DLog(@"%@", JSON);
        
        if ([[JSON objectForKey:@"code"] intValue] == 200) {
            
            [[NSUserDefaults standardUserDefaults] setObject:_usernameText.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:_passwordText.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
           
            notify.title = @"Caricamento categorie...";
            
            [[Categories sharedCategories] updateCategories:^(NSArray *newCategories) {
               [notify hide];
               
               _usernameText.text = @"";
               _passwordText.text = @"";
               
               [(GoAppDelegate*)[UIApplication sharedApplication].delegate showDashboard];
            }];
            
        } else {
           
           for (UIView *v in self.view.subviews) {
              [v setHidden:NO];
           }
           
           [notify hide];
           
            JSNotifier *notify2 = [[JSNotifier alloc]initWithTitle:@"Username o password errati."];
            notify2.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]];
            [notify2 showFor:2.0];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
        _usernameText.enabled = NO;
        _passwordText.enabled = NO;
        [notify hide];
        
        JSNotifier *notify = [[JSNotifier alloc]initWithTitle:error.localizedDescription];
        notify.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"NotifyX.png"]];
        [notify showFor:2.0];
       
       for (UIView *v in self.view.subviews) {
          [v setHidden:NO];
       }
        
    }] start];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
   
   if (textField == _usernameText) {
      [_passwordText becomeFirstResponder];
      return NO;
   }
   
   [self tapLogin:nil];
   return YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
   
    self.usernameText = nil;
    self.passwordText = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end