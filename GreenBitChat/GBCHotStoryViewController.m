//
//  GBCHotStoryViewController.m
//  GreenBitChat
//
//  Created by L on 4/3/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "GBCHotStoryViewController.h"

@interface GBCHotStoryViewController ()

@end

@implementation GBCHotStoryViewController

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
    // Do any additional setup after loading the view from its nib.
    [_hotStoryScrollView setContentSize:CGSizeMake(self.view.bounds.size.width, 600)];
    
    [_hotStoryScrollView addSubview:({
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 20,200,600)];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"TwitterCover is a parallax top view with real time blur effect to any UIScrollView, inspired by Twitter for iOS.\n\nCompletely created using UIKit framework.\n\nEasy to drop into your project.\n\nYou can add this feature to your own project, TwitterCover is easy-to-use.";
        label;
    })];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
