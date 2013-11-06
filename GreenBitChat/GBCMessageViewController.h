//
//  GBCMessageViewController.h
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface GBCMessageViewController : UIViewController <UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate>{
    NSFetchedResultsController *fetchedResultsController;
}
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
