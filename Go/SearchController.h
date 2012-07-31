//
//  SearchController.h
//  Go
//
//  Created by Nicholas on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *links;

@property (nonatomic, retain) IBOutlet UIView *bottomBar;
@property (nonatomic, readonly) IBOutlet UITextField *nameTxt;

-(IBAction)switchBar:(id)sender;
-(IBAction)tapBack:(id)sender;

@end
