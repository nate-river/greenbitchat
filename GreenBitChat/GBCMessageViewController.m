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
    NSArray *searchResults;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


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
        //label.text = @"王芳";
        
        label = (UILabel *)[cell viewWithTag:2];
        label.text = user.mostRecentMessageBody;
        //label.text = @"测试长度很长的信息在这里是怎么展示的,测试长度很长的信息在这里是怎么展示的,测试长度很长的信息在这里是怎么展示的";
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
    return 75.0;
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
            
            NSMutableArray  *messages = [[GBCXMPPManager sharedManager] fetchMessages];
            NSMutableArray *tmp = [[NSMutableArray alloc] init];
            NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
            for ( XMPPMessageArchiving_Message_CoreDataObject *message in messages){

                if ([message.bareJidStr isEqualToString:contact.bareJidStr]) {
                    NSString *flag = [[[message.messageStr componentsSeparatedByString:@" "] objectAtIndex:2] substringToIndex:4];

                    if ( [flag isEqualToString:@"from"] ) {
                        [tmp addObject:[@"you_" stringByAppendingString:message.body]];
                    }else{
                        [tmp addObject:[@"me_" stringByAppendingString:message.body]];
                    }
                    [tmp2 addObject:message.timestamp];
                }
            }
            destViewController.messages = tmp;
            destViewController.timestamps = tmp2;
        }
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    if ([segue.identifier isEqualToString:@"showContactList"])
    {
        GBCChatWindowViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }

}

//- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
//{
//    NSPredicate *resultPredicate = [NSPredicate
//                                    predicateWithFormat:@"SELF contains[cd] %@",searchText];
//    searchResults = [recipes filteredArrayUsingPredicate:resultPredicate];
//}

//-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    [self filterContentForSearchText:searchString scope:[[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
//    return YES;
//}

@end
