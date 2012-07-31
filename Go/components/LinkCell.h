//
//  LinkCell.h
//  Go
//
//  Created by Nicholas Valbusa on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *titleLbl;
@property (nonatomic, retain) IBOutlet UILabel *urlLbl;
@property (nonatomic, retain) IBOutlet UILabel *categoryLbl;
@property (nonatomic, retain) IBOutlet UIView *categorySideView;

-(void)setLinkObject:(NSDictionary*)item;

@end
