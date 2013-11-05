//
//  GBCMessageViewController.m
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCMessageViewController.h"
#import "GBCChatWindowViewController.h"

#import "GBCXMPPManager.h"
#import "XMPPFramework.h"
#import "DDLog.h"


#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif

@interface GBCMessageViewController ()
@end


@implementation GBCMessageViewController

{
    NSArray *recipes;
    NSArray *searchResults;
    NSArray *contacs;
}

@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    contacs = [self fetchRecentContacts];
//    recipes = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//- (NSArray *) fetchRecentContacts
//{
//    GBCXMPPManager *xmpp = [GBCXMPPManager sharedManager];
//    
//    NSManagedObjectContext *moc = [xmpp managedObjectContext_messageArchiving];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject"
//                                              inManagedObjectContext:moc];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    [request setEntity:entity];
//    NSError *error;
//    NSArray *list = [moc executeFetchRequest:request error:&error];
//    return list;
//}
//
//- (NSArray *) fetchMessages:(NSString *) bareJidStr
//{
//    GBCXMPPManager *xmpp = [GBCXMPPManager sharedManager];
//    
//    NSManagedObjectContext *moc = [xmpp managedObjectContext_messageArchiving];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Message_CoreDataObject"
//                                              inManagedObjectContext:moc];
//    
//    NSFetchRequest *request = [[NSFetchRequest alloc]init];
//    [request setEntity:entity];
//    NSError *error;
//    NSArray *list = [moc executeFetchRequest:request error:&error];
//    return list;
//}

#pragma mark - coredata
- (NSFetchedResultsController *)fetchedResultsController
{
	if (fetchedResultsController == nil)
	{
        GBCXMPPManager *xmpp = [GBCXMPPManager sharedManager];
        
		NSManagedObjectContext *moc = [xmpp managedObjectContext_messageArchiving];
		
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPMessageArchiving_Contact_CoreDataObject"
		                                          inManagedObjectContext:moc];
		
		NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"mostRecentMessageTimestamp" ascending:NO];
		NSArray *sortDescriptors = [NSArray arrayWithObjects:sd1, nil];
		
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:entity];
		[fetchRequest setSortDescriptors:sortDescriptors];
		//[fetchRequest setFetchBatchSize:10];
		
		fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
		                                                               managedObjectContext:moc
		                                                                 sectionNameKeyPath:@"mostRecentMessageTimestamp"
		                                                                          cacheName:nil];
		[fetchedResultsController setDelegate:self];
		
		
		NSError *error = nil;
		if (![fetchedResultsController performFetch:&error])
		{
			DDLogError(@"Error performing fetch: %@", error);
		}
        
	}
	
	return fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	[[self tableView] reloadData];
}



// =============================================================================
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        return [searchResults count];
//    }else
//    {
//        return [recipes count];
//    }
    //return [contacs count];
    NSArray *sections = [[self fetchedResultsController] sections];
	
	if (sectionIndex < [sections count])
	{
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:sectionIndex];
		return sectionInfo.numberOfObjects;
	}
	
	return 0;
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
        XMPPMessageArchiving_Contact_CoreDataObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
        label = (UILabel *)[cell viewWithTag:1];
        label.text = user.bareJidStr;
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = user.mostRecentMessageBody;
        //label.lineBreakMode = UILineBreakModeWordWrap;
        label.numberOfLines = 2;
        
        label = (UILabel *)[cell viewWithTag:3];
        //label.text = user.mostRecentMessageTimestamp;
        //cell.textLabel.text = [recipes objectAtIndex:indexPath.row];
    }
    return cell;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
	return [[[self fetchedResultsController] sections] count];

}


// =============================================================================
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70.0;
}

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
            //destViewController.name = [searchResults objectAtIndex:indexPath.row];
        } else
        {
            indexPath = [self.tableView indexPathForSelectedRow];
            XMPPMessageArchiving_Contact_CoreDataObject *contact = [ [self fetchedResultsController] objectAtIndexPath:indexPath];

            destViewController.bareJidStr = contact.bareJidStr;
            destViewController.displayName = contact.bareJidStr;
        }
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    if ([segue.identifier isEqualToString:@"showContactList"])
    {
        GBCChatWindowViewController *destViewController = segue.destinationViewController;
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
