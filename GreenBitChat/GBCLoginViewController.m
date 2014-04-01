//
//  GBCLoginViewController.m
//  GreenBitChat
//
//  Created by L on 3/25/14.
//  Copyright (c) 2014 L. All rights reserved.
//

#import "GBCLoginViewController.h"
#import "GBCRegistViewController.h"

@interface GBCLoginViewController ()

@end

@implementation GBCLoginViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden=YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showRegist"])
    {
        GBCRegistViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

// It is important for you to hide kwyboard

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _accoutTextField) {
        [textField resignFirstResponder];
        [_passwordTextField becomeFirstResponder];
    }else if ( textField == _passwordTextField){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UITabBarController *obj=[storyboard instantiateViewControllerWithIdentifier:@"tab"];
        self.navigationController.navigationBarHidden=YES;
        [self.navigationController pushViewController:obj animated:YES];
    }
   
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}

@end
