//
//  GBCChatWindowViewController.m
//  GreenBitChat
//
//  Created by L on 10/18/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCChatWindowViewController.h"

@interface GBCChatWindowViewController ()

@end

@implementation GBCChatWindowViewController

@synthesize recipeLabel;
@synthesize recipeName;

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
    recipeLabel.text = recipeName;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
