//
//  GBCDiscoverViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCHomeViewController.h"
//#import "GBCDongTaiViewController.h"
//#import "GBCFindPeopleViewController.h"

@interface GBCHomeViewController ()

@end

@implementation GBCHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // 从 URL 中载入一个 html 页面
    NSURL *url = [NSURL URLWithString:@"http://localhost/Iphone/index"];
    //just try........
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
