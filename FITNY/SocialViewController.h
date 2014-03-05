//
//  SocialViewController.h
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/18/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TPKeyboardAvoidingScrollViewSocial;

@interface SocialViewController : UIViewController <UITextViewDelegate>
{
    IBOutlet UITextField *input;
    IBOutlet UITextView *timeline;
}

@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollViewSocial *scrollView;


@end
