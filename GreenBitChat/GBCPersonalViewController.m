//
//  GBCSettingViewController.m
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCPersonalViewController.h"

@interface GBCPersonalViewController ()

@end

@implementation GBCPersonalViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // 从 URL 中载入一个 html 页面
    NSURL *url = [NSURL URLWithString:@"http://localhost/Iphone/index"];
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
	// Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
