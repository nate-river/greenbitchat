//
//  GBCDiscoverViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCDiscoverViewController.h"

@interface GBCDiscoverViewController ()

@end

@implementation GBCDiscoverViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 4;
    } else {
        NSAssert(section > 1, @"Unexpected number of sections!");
        return -1;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
     return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"first"];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = @"动态中心";
        return cell;
        
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"人脉扩展";
            //cell.detailTextLabel.text = @"";
        } else if (indexPath.row == 1) {
            cell.textLabel.text = @"精品问答";
            //cell.detailTextLabel.text = @"Notes, GameCenter";
        } else if (indexPath.row == 2) {
            cell.textLabel.text = @"精选资料";
            //cell.detailTextLabel.text = @"Contacts";
        } else if (indexPath.row == 3){
            cell.textLabel.text = @"最新活动";
        } else {
            NSAssert(indexPath.row > 2, @"Unexpected number of rows in second section!");
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    } else {
        NSAssert(indexPath.section > 1, @"Unexpected number of sections!");
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        [self performSegueWithIdentifier: @"showChatWindow" sender: self ];
//    }
}

@end