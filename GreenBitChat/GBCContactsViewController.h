//
//  GBCContactsViewController.h
//  GreenBitChat
//
//  Created by L on 10/16/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBCContactsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate>
@property(nonatomic, strong, readonly) UITableView *tableView;
@property(nonatomic, strong, readonly) UISearchBar *searchBar;
@end
