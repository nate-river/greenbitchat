//
//  GBCContactsViewController.m
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCContactsViewController.h"
#import "GBCXMPPManager.h"

#import "XMPPFramework.h"
#import "GBCChatWindowViewController.h"
#import "DDLog.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif

@interface GBCContactsViewController ()
{
    
}

@property(nonatomic, strong) UISearchDisplayController *strongSearchDisplayController;
@end

@implementation GBCContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.placeholder = @"Search";
    [self.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = self.searchBar;
    // The search bar is hidden when the view becomes visible the first time
    self.tableView.contentOffset = CGPointMake(0, CGRectGetHeight(self.searchBar.bounds));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

# pragma mark CoreData

- (NSFetchedResultsController *)fetchedResultsController
{
	if (fetchedResultsController == nil)
	{
        GBCXMPPManager *xmpp = [GBCXMPPManager sharedManager];
        
		NSManagedObjectContext *moc = [xmpp managedObjectContext_roster];
		
		NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject"
		                                          inManagedObjectContext:moc];
		
		NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"sectionNum" ascending:YES];
		NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
		
		NSArray *sortDescriptors = [NSArray arrayWithObjects:sd1, sd2, nil];
		
		NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
		[fetchRequest setEntity:entity];
		[fetchRequest setSortDescriptors:sortDescriptors];
		[fetchRequest setFetchBatchSize:10];
		
		fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
		                                                               managedObjectContext:moc
		                                                                 sectionNameKeyPath:@"sectionNum"
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

#pragma mark UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[[self fetchedResultsController] sections] count];
}

- (NSString *)tableView:(UITableView *)sender titleForHeaderInSection:(NSInteger)sectionIndex
{
	NSArray *sections = [[self fetchedResultsController] sections];
	
	if (sectionIndex < [sections count])
	{
		id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:sectionIndex];
        
		int section = [sectionInfo.name intValue];
		switch (section)
		{
			case 0  : return @"Available";
			case 1  : return @"Away";
			default : return @"Offline";
		}
	}
	
	return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
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
	static NSString *CellIdentifier = @"contactCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
	}
	
	XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath:indexPath];
	
	cell.textLabel.text = user.displayName;
    
    //GBCXMPPManager *xmpp = [GBCXMPPManager sharedManager];
    //XMPPvCardCoreDataStorage *v  = [[ xmpp xmppvCardAvatarModule] init];
    //[v vCardTempForJID:user.jidStr];
    
    //if (photoData != nil)
    //   cell.imageView.image = [UIImage imageWithData:photoData];
    //else
    //NSData *photoData = [[[self appDelegate] xmppvCardAvatarModule] photoDataForJID:user.jid];
    
    //cell.imageView.image = [UIImage imageNamed:@"demo-avatar-jobs"]；
    
	//[self configurePhotoForCell:cell user:user];
	
	return cell;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == self.tableView) {
        return [[NSArray arrayWithObject:UITableViewIndexSearch] arrayByAddingObjectsFromArray:[[UILocalizedIndexedCollation currentCollation] sectionIndexTitles]];
    }else{
        return nil;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    if (tableView == self.searchDisplayController.searchResultsTableView)
//    {
//        [self performSegueWithIdentifier: @"showChatWindow" sender: self ];
//    }
//    [self performSegueWithIdentifier: @"chat" sender: self ];

}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"chat"])
    {
        GBCChatWindowViewController *destViewController = segue.destinationViewController;
        
        NSIndexPath *indexPath = nil;
        indexPath = [ [self tableView] indexPathForSelectedRow];
        
        XMPPUserCoreDataStorageObject *user = [[self fetchedResultsController] objectAtIndexPath: indexPath];
        
        destViewController.bareJidStr = user.jidStr;
        destViewController.displayName = user.displayName;
        
        NSMutableArray  *messages = [[GBCXMPPManager sharedManager] fetchMessages];
        NSMutableArray *tmp = [[NSMutableArray alloc] init];
        NSMutableArray *tmp2 = [[NSMutableArray alloc] init];
        for ( XMPPMessageArchiving_Message_CoreDataObject *message in messages){
            
            if ([message.bareJidStr isEqualToString:user.jidStr]) {
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
        
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    
}

//#pragma mark - Search Delegate
//
//- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller
//{
//    self.filteredPersons = self.famousPersons;
//}
//
//- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
//{
//    self.filteredPersons = nil;
//}
//
//- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
//{
//    self.filteredPersons = [self.filteredPersons filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchString]];
//
//    return YES;
//}
@end



