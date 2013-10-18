//
//  GBCMessageViewController.m
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCMessageViewController.h"
#import "GBCChatWindowViewController.h"

@interface GBCMessageViewController ()
@end


@implementation GBCMessageViewController

{
    NSArray *recipes;
    NSArray *searchResults;
}

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// =============================================================================
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [searchResults count];
    }else
    {
        return [recipes count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RecipeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    UILabel *label;
    
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else
    {
        label = (UILabel *)[cell viewWithTag:1];
        label.text = [recipes objectAtIndex:indexPath.row];
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = [recipes objectAtIndex:indexPath.row];
        
        label = (UILabel *)[cell viewWithTag:3];
        label.text = [recipes objectAtIndex:indexPath.row];
        //cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


// =============================================================================
#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 70.0;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self performSegueWithIdentifier: @"showChatWindow" sender: self ];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
        
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showChatWindow"])
    {
        GBCChatWindowViewController *destViewController = segue.destinationViewController;
        NSIndexPath *indexPath = nil;
        if ([self.searchDisplayController isActive])
        {
            indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            destViewController.recipeName = [searchResults objectAtIndex:indexPath.row];
        } else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
        }
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",searchText];
    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

@end
