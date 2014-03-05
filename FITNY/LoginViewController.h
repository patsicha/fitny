//
//  LoginViewController.h
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/17/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEHUDView/EEHUDView.h"

@class TPKeyboardAvoidingScrollView;

@interface LoginViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UIButton *LoginButton;
    IBOutlet UIButton *RegisterButton;
    IBOutlet UITextField *usernameField;
    IBOutlet UITextField *passwordField;
}

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property(nonatomic,retain) NSMutableData *receivedData;
@end
