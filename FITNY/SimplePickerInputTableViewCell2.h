//
//  SimplePickerInputTableViewCell2.h
//  PickerCellDemo
//
//  Created by Tom Fewster on 10/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "PickerInputTableViewCell.h"

@class SimplePickerInputTableViewCell2;

@protocol SimplePickerInputTableViewCell2Delegate <NSObject>
@optional
- (void)tableViewCell:(SimplePickerInputTableViewCell2 *)cell didEndEditingWithValue:(NSString *)value;
@end

@interface SimplePickerInputTableViewCell2 : PickerInputTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate> {
	NSString *value;
}

@property (nonatomic, strong) NSString *value;
@property (nonatomic, strong) NSArray *values;
@property (weak) IBOutlet id <SimplePickerInputTableViewCell2Delegate> delegate;

@end
