//
//  DateInputTableViewCell2.h
//  ShootStudio
//
//  Created by Tom Fewster on 18/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DateInputTableViewCell2;

@protocol DateInputTableViewCell2Delegate <NSObject>
@optional
- (void)tableViewCell:(DateInputTableViewCell2 *)cell didEndEditingWithDate:(NSDate *)value;
- (void)tableViewCell:(DateInputTableViewCell2 *)cell didEndEditingWithDuration:(NSTimeInterval)value;
@end

@interface DateInputTableViewCell2 : UITableViewCell <UIPopoverControllerDelegate> {
	UIPopoverController *popoverController;
	UIToolbar *inputAccessoryView;
}

@property (nonatomic, strong) NSDate *dateValue;
@property (nonatomic, assign) NSTimeInterval timerValue;
@property (nonatomic, assign) UIDatePickerMode datePickerMode;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (weak) IBOutlet id<DateInputTableViewCell2Delegate> delegate;

- (void)setMaxDate:(NSDate *)max;
- (void)setMinDate:(NSDate *)min;
- (void)setMinuteInterval:(NSUInteger)value;
- (NSString *)timerStringValue;

@end
