//
//  GBCChatWindowViewController.h
//  GreenBitChat
//
//  Created by L on 10/18/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"
#import "XMPPMessage.h"
#import "XMPPUserCoreDataStorageObject.h"
@interface GBCChatWindowViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource>

@property (nonatomic, strong) XMPPUserCoreDataStorageObject *user;

@property (nonatomic, strong) NSString *bareJidStr;
@property (nonatomic, strong) NSString *displayName;


@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *timestamps;

- (void)handleMessageIncome:(XMPPMessage *)aMessage;


@end
