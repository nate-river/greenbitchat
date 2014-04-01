//
//  GBCLoginViewController.m
//  GreenBitChat
//
//  Created by L on 3/25/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "GBCLoginViewController.h"
#import "GBCRegistViewController.h"

@interface GBCLoginViewController ()

@end

@implementation GBCLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController *obj=[storyboard instantiateViewControllerWithIdentifier:@"tab"];
    self.navigationController.navigationBarHidden=YES;
    [self.navigationController pushViewController:obj animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRegist"])
    {
        GBCRegistViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

@end