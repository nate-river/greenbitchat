//
//  GBCDynamicViewController.m
//  GreenBitChat
//
//  Created by L on 11/7/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCDynamicViewController.h"

@interface GBCDynamicViewController ()

@end

@implementation GBCDynamicViewController

@synthesize MyWebview;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // 从 URL 中载入一个 html 页面
    NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
    [self.MyWebview loadRequest:[NSURLRequest requestWithURL:url]];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
