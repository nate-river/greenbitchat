//
//  GBCSettingViewController.h
//  GreenBitChat
//
//  Created by L on 10/20/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"

@interface GBCSettingViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    UIImageView *_avatarImageView;
    UILabel *_nameLabel;
    UILabel *_twitterUsernameLabel;
    UILabel *_twitterUserIDLabel;
}

@property (nonatomic, retain) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) IBOutlet UILabel *twitterUsernameLabel;
@property (nonatomic, retain) IBOutlet UILabel *twitterUserIDLabel;

@end
