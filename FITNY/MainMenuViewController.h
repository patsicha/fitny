//
//  MainMenuViewController.h
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/17/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuViewController : UIViewController
{
    IBOutlet UIButton *logoutButton;
    IBOutlet UIButton *timelineButton;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *heightLabel;
   
}
@property (nonatomic) BOOL Thai;
@end
