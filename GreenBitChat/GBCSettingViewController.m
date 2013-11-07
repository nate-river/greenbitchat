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
#pragma mark - tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 5;
    } else if (section == 2){
        return 1;
    }else {
        NSAssert(section > 1, @"Unexpected number of sections!");
        return -1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.section == 0)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mainInfo"];
    
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:2];
        nameLabel.text = @"乔布斯";
        UILabel *gameLabel = (UILabel *)[cell viewWithTag:3];
        gameLabel.text = @"@jobs";
    
        UIImageView * ratingImageView = [(UIImageView *) [cell viewWithTag:1] initWithFrame:CGRectMake(10.0, 10.0, 64.0, 64.0)];
        CALayer *lay  = ratingImageView.layer;
        [lay setMasksToBounds:YES];
        [lay setCornerRadius:30.0];
        ratingImageView.image = [UIImage imageNamed:@"demo-avatar-jobs"];
        return cell;
    }
    if ( indexPath.section == 1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"otherInfo"];
        cell.textLabel.text = @"company";
        cell.detailTextLabel.text= @"apple inc";
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mineFunction"];
    cell.textLabel.text = @"我的收藏";
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90.0;
    }
    return 50;
}



@end
