//
//  OptionViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/25/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MJSecondPopupDelegate;

@interface OptionViewController : UIViewController
@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;
@property (nonatomic) BOOL Thai;
@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(OptionViewController*)secondDetailViewController;
- (void)changeLanguege:(BOOL)Thai;
@end