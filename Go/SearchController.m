//
//  SearchController.m
//  Go
//
//  Created by Nicholas on 31/07/12.
//  Copyright (c) 2012 Nicholas Valbusa. All rights reserved.
//

#import "SearchController.h"
#import "components/LinkCell.h"
#import "API.h"
#import "components/JSNotifier.h"
#import "GoAppDelegate.h"

#define BOTTOMBAR_COLLAPSEDELTA 67.0f

@interface SearchController ()

@end

@implementation SearchController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _links = [[NSMutableArray alloc] initWithCapacity:1];
    [_nameTxt becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.table = nil;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self collapseMetroBarAnimated:NO];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_links count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"LinkCell";
    
    LinkCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"LinkCell" owner:self options:nil];
        cell = (LinkCell *)[nib objectAtIndex:0];
    }
    
    [cell setLinkObject:[_links objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *item = [_links objectAtIndex:indexPath.row];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[item objectForKey:@"url"]]];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self collapseMetroBarAnimated:YES];
}

#pragma mark - Metro bar

-(void)collapseMetroBarAnimated:(BOOL)animated {
    
    if (_bottomBar.frame.origin.y == (self.view.frame.size.height - _bottomBar.frame.size.height + BOTTOMBAR_COLLAPSEDELTA)) {
        return;
    }
    
    if (animated) {
        [UIView beginAnimations:@"animate_metrobar" context:nil];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    }
    
    CGRect fr = _bottomBar.frame;
    fr.origin.y = self.view.frame.size.height - _bottomBar.frame.size.height + BOTTOMBAR_COLLAPSEDELTA;
    _bottomBar.frame = fr;
    
    [[_bottomBar viewWithTag:1] setAlpha:0];
    [[_bottomBar viewWithTag:2] setAlpha:0];
    
    if (animated) [UIView commitAnimations];
}

-(IBAction)switchBar:(id)sender {
    
    if (_bottomBar.frame.origin.y == (self.view.frame.size.height - _bottomBar.frame.size.height)) {
        //The bar is open. Now collapsing
        [self collapseMetroBarAnimated:YES];
        
    } else {
        //The bar is collapsed. Now opening
        [UIView beginAnimations:@"animate_metrobar" context:nil];
        [UIView setAnimationDuration:0.3];
        
        CGRect fr = _bottomBar.frame;
        fr.origin.y = self.view.frame.size.height - _bottomBar.frame.size.height;
        _bottomBar.frame = fr;
        
        [[_bottomBar viewWithTag:1] setAlpha:1];
        [[_bottomBar viewWithTag:2] setAlpha:1];
        
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView commitAnimations];
    }
}

-(IBAction)tapRefresh:(id)sender {
    
    [_nameTxt resignFirstResponder];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [activityIndicator startAnimating];
    
    JSNotifier *notify = [[JSNotifier alloc]initWithTitle:@"Ricerca in corso.."];
    notify.accessoryView = activityIndicator;
    if (!sender) [notify show];
    
    [[API sharedAPI] getLinksByName:_nameTxt.text andCategoryId:0 success:^(NSArray *links) {
        
        if (!sender) [notify hide];
        
        [self collapseMetroBarAnimated:sender ? YES : NO];
        
        if (links) {
            [self.links removeAllObjects];
            [self.links addObjectsFromArray:links];
            [self.table reloadData];
        }
        
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self tapRefresh:nil];
    return YES;
}

-(IBAction)tapBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
