//
//  LoginController.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController <UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField *usernameText;
@property (nonatomic, retain) IBOutlet UITextField *passwordText;

-(IBAction)tapLogin:(id)sender;

@end
