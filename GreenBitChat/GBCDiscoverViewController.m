//
//  GBCDiscoverViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCDiscoverViewController.h"
//#import "GBCDynamicViewController.h";
#import "GBCDongTaiViewController.h"

@interface GBCDiscoverViewController ()

@end

@implementation GBCDiscoverViewController


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showWebContent"])
    {
        GBCDongTaiViewController  *destViewController = segue.destinationViewController;
        //GBCDynamicViewController *destViewController = segue.destinationViewController;
        
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    
}


@end
