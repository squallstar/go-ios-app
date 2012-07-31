//
//  LinksController.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinksController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *table;
@property (nonatomic, retain) NSMutableArray *links;

@property (nonatomic, retain) IBOutlet UIView *bottomBar;

-(IBAction)switchBar:(id)sender;
-(IBAction)tapRefresh:(id)sender;
-(IBAction)tapSearch:(id)sender;
-(IBAction)tapLogout:(id)sender;

@end
