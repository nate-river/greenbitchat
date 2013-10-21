//
//  GBCChatWindowViewController.h
//  GreenBitChat
//
//  Created by L on 10/18/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSMessagesViewController.h"

@interface GBCChatWindowViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource>
@property (nonatomic, strong) IBOutlet UILabel *recipeLabel;
@property (nonatomic, strong) NSString *recipeName;

@property (strong, nonatomic) NSMutableArray *messages;
@property (strong, nonatomic) NSMutableArray *timestamps;

@end
