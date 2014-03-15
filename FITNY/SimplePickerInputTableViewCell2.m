//
//  SimplePickerInputTableViewCell2.m
//  PickerCellDemo
//
//  Created by Tom Fewster on 10/11/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SimplePickerInputTableViewCell2.h"

@implementation SimplePickerInputTableViewCell2

@synthesize delegate;
@synthesize value,values;

+ (void)initialize {
	//values = [NSArray arrayWithObjects:@" - ",@" Male", @" Female", nil];
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
		self.picker.delegate = self;
		self.picker.dataSource = self;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
		self.picker.delegate = self;
		self.picker.dataSource = self;
        
    }
    return self;
}

- (void)setValue:(NSString *)v {
	value = v;
    
	self.detailTextLabel.text = value;
    //self.textLabel.textColor = [UIColor blackColor];
	[self.picker selectRow:[values indexOfObject:value] inComponent:0 animated:YES];
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [values count];
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [values objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
	return 44.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
	return 300.0f; //pickerView.bounds.size.width - 20.0f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	self.value = [values objectAtIndex:row];
    
    
	if (delegate && [delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithValue:)]) {
		[delegate tableViewCell:self didEndEditingWithValue:self.value];
	}
}

@end
