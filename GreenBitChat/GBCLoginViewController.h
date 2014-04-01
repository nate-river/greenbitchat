//
//  GBCLoginViewController.h
//  GreenBitChat
//
//  Created by L on 3/25/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBCLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accoutTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end
 