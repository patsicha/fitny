//
//  StringInputTableViewCell2.h
//  ShootStudio
//
//  Created by Tom Fewster on 19/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StringInputTableViewCell2;

@protocol StringInputTableViewCell2Delegate <NSObject>
@optional
- (void)tableViewCell:(StringInputTableViewCell2 *)cell didEndEditingWithString:(NSString *)value;
@end


@interface StringInputTableViewCell2 : UITableViewCell <UITextFieldDelegate> {
	UITextField *textField;
}

@property (nonatomic, strong) NSString *stringValue;
@property (nonatomic, strong) UITextField *textField;
@property (weak) IBOutlet id<StringInputTableViewCell2Delegate> delegate;

@end
