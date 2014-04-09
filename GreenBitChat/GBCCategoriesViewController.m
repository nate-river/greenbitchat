//
//  GBCCategoriesViewController.m
//  GreenBitChat
//
//  Created by L on 4/2/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "GBCCategoriesViewController.h"
#import "GBCHomeViewController.h"
@interface GBCCategoriesViewController ()

@end

@implementation GBCCategoriesViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"home"])
    {
        GBCHomeViewController *destViewController = segue.destinationViewController;
        destViewController.cellType = @"home";
    }
    else if ([segue.identifier isEqualToString:@"bid"])
    {
        GBCHomeViewController *destViewController = segue.destinationViewController;
        destViewController.cellType = @"bid";
    }
    else if ([segue.identifier isEqualToString:@"group"])
    {
        GBCHomeViewController *destViewController = segue.destinationViewController;
        destViewController.cellType = @"group";
    }
    else if ([segue.identifier isEqualToString:@"trade"])
    {
        GBCHomeViewController *destViewController = segue.destinationViewController;
        destViewController.cellType = @"trade";
    }
    else if ([segue.identifier isEqualToString:@"question"])
    {
        GBCHomeViewController *destViewController = segue.destinationViewController;
        destViewController.cellType = @"question";
    }
}


@end
