//
//  GBCSettingViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCSettingViewController.h"

@interface GBCSettingViewController ()

@end

@implementation GBCSettingViewController


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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UILabel *label;
    
    if (indexPath.row == 0) {
       
        //image = (UIImage *)[cell viewWithTag:0];
        //image.imageView.image = [UIImage imageNamed:@"defaultPerson"];

        label = (UILabel *)[cell viewWithTag:1];
        label.text = @"徐渭";
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = @"google company";
        
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"精品问答";
        cell.detailTextLabel.text = @"cc";

    } else if (indexPath.row == 2) {
        cell.detailTextLabel.text = @"cc";
        cell.textLabel.text = @"精选资料";
    } else if (indexPath.row == 3){
        cell.textLabel.text = @"最新活动";
    } else if (indexPath.row == 4){
        cell.textLabel.text = @"5";
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"6";
    }
    
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
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
