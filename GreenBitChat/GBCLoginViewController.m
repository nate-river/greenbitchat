//
//  GBCLoginViewController.m
//  GreenBitChat
//
//  Created by L on 3/25/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "GBCLoginViewController.h"

@interface GBCLoginViewController ()

@end

@implementation GBCLoginViewController


- (IBAction)loginBtnClicked:(id)sender {
    //点击登陆按钮后切换到storyboard界面
    //UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //    self.view.window.rootViewController = [storyboard instantiateInitialViewController];
    //[self presentModalViewController:[storyboard instantiateInitialViewController] animated:YES];
}

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

@end
