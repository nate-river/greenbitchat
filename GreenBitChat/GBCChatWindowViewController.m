//
//  GBCChatWindowViewController.m
//  GreenBitChat
//
//  Created by L on 10/18/13.
//  Copyright (c) 2013 L. All rights reserved.
//

#import "GBCChatWindowViewController.h"
#import "GBCXMPPManager.h"
#import "XMPPRosterCoreDataStorage.h"



@interface GBCChatWindowViewController ()

@end

@implementation GBCChatWindowViewController



- (UIButton *)sendButton
{
    // Override to use a custom send button
    // The button's frame is set automatically for you
    return [UIButton defaultSendButton];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //添加观察者
    [nc addObserver:self
           selector:@selector(handleMessageIncome:)
               name:@"GBCsendMessage"
             object:nil];
    NSLog(@"Registered with notification center");
    
    self.delegate = self;
    self.dataSource = self;
    self.title = [self displayName];

    
//    self.messages = [[NSMutableArray alloc] initWithObjects:
//                     @"you_我已经添加你为好友，我们聊天吧",
//                     nil];
//    self.messages = self.messages;
//    
//    self.timestamps = [[NSMutableArray alloc] initWithObjects:
//                       [NSDate date],
//                       nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonPressed:(UIButton*)sender
{
    // Testing pushing/popping messages view
    GBCChatWindowViewController *vc = [[GBCChatWindowViewController alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

#pragma mark - Messages view delegate
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    [self.messages addObject: [@"me_" stringByAppendingString:text]];
    
    [self.timestamps addObject:[NSDate date]];
    
    
    NSString *message = text;
    
    
    if (message.length > 0) {
        
        NSString *jid = [[[self bareJidStr] componentsSeparatedByString:@"@"] objectAtIndex:0];
        NSString *domain = [[[self bareJidStr] componentsSeparatedByString:@"@"] objectAtIndex:1];
        //生成消息对象
        XMPPMessage *mes=[XMPPMessage messageWithType:@"chat" to:[XMPPJID jidWithUser:jid domain:domain  resource:@"ios"]];
        [mes addChild:[DDXMLNode elementWithName:@"body" stringValue:message]];
        
        //发送消息
        [[[GBCXMPPManager sharedManager] xmppStream] sendElement:mes];
    }
    
    [JSMessageSoundEffect playMessageSentSound];
    
    [self finishSend];
}

- (void) handleMessageIncome:(NSNotification *)message
{
    NSLog(@"Received notification: %@", [[message userInfo] objectForKey:@"user"]);
    //XMPPUserCoreDataStorageObject *user = [[message userInfo] objectForKey:@"user"];
    NSString *text = [[message userInfo] objectForKey:@"message"];
    
    [self.messages addObject:[@"you_" stringByAppendingString:text]];
    [self.timestamps addObject:[NSDate date]];
    [JSMessageSoundEffect playMessageReceivedSound];
    [self finishSend];
}

- (JSBubbleMessageType)messageTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *message = [self.messages objectAtIndex:indexPath.row];
    NSString *idifiter = [[message componentsSeparatedByString:@"_"] objectAtIndex:0];
    if ([idifiter isEqualToString:@"me"]) {
        return JSBubbleMessageTypeOutgoing;
    }else{
        return JSBubbleMessageTypeIncoming;
    }
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JSBubbleMessageStyleFlat;
}

- (JSMessagesViewTimestampPolicy)timestampPolicy
{
    return JSMessagesViewTimestampPolicyEveryThree;
}

- (JSMessagesViewAvatarPolicy)avatarPolicy
{
    return JSMessagesViewAvatarPolicyBoth;
}

- (JSAvatarStyle)avatarStyle
{
    return JSAvatarStyleCircle;
}

- (JSInputBarStyle)inputBarStyle
{
    return JSInputBarStyleFlat;
}

//  Optional delegate method
//  Required if using `JSMessagesViewTimestampPolicyCustom`
//
//  - (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
//

#pragma mark - Messages view data source
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[[self.messages objectAtIndex:indexPath.row] componentsSeparatedByString:@"_"] objectAtIndex:1];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.timestamps objectAtIndex:indexPath.row];
}

- (UIImage *)avatarImageForIncomingMessage
{
    return [UIImage imageNamed:@"demo-avatar-woz"];
}

- (UIImage *)avatarImageForOutgoingMessage
{
    return [UIImage imageNamed:@"demo-avatar-jobs"];
}





@end
