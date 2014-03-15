//
//  MyAlertView.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/25/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAlertView : UIView {
    CGPoint lastTouchLocation;
    CGRect originalFrame;
    BOOL isShown;
}

@property (nonatomic) BOOL isShown;

- (void)show;
- (void)hide;

@end