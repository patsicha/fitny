//
//  StringInputTableViewCell.m
//  ShootStudio
//
//  Created by Tom Fewster on 19/10/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "StringInputTableViewCell.h"

@implementation StringInputTableViewCell

@synthesize delegate;
@synthesize stringValue;
@synthesize textField;

- (void)initalizeInputView {
	// Initialization code
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
	self.textField.autocorrectionType = UITextAutocorrectionTypeDefault;
	self.textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
	self.textField.textAlignment = UITextAlignmentRight;
	self.textField.textColor = [UIColor blueColor];
	self.textField.font = [UIFont systemFontOfSize:17.0f];
	self.textField.clearButtonMode = UITextFieldViewModeNever;
	self.textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[self addSubview:self.textField];
	
	self.accessoryType = UITableViewCellAccessoryNone;
	
	self.textField.delegate = self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		[self initalizeInputView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
		[self initalizeInputView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
	[super setSelected:selected];
	if (selected) {
		[self.textField becomeFirstResponder];
	}
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	[super setSelected:selected animated:animated];
	if (selected) {
		[self.textField becomeFirstResponder];
	}
}

- (void)setStringValue:(NSString *)value {
	self.textField.text = value;
}


- (NSString *)stringValue {
	return self.textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[self.textField resignFirstResponder];
	return YES;
}
- (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
-(void)textFieldDidChange :(UITextField *)theTextField{
    NSLog( @"text changed: %@", theTextField.text);
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
	if (delegate && [delegate respondsToSelector:@selector(tableViewCell:didEndEditingWithString:)]) {
		[delegate tableViewCell:self didEndEditingWithString:self.stringValue];
	}
    if([self stringContainsEmoji:self.stringValue])
        
    {
        NSLog(@"Emoji");
        [EEHUDView growlWithMessage:@"can't use Emoji!"
                          showStyle:EEHUDViewShowStyleShake
                          hideStyle:EEHUDViewHideStyleFadeOut
                    resultViewStyle:EEHUDResultViewStyleNG
                           showTime:1.0];
        textField.text = @"";
    }
	//UITableView *tableView = (UITableView *)self.superview;
	//[tableView deselectRowAtIndexPath:[tableView indexPathForCell:self] animated:YES];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	CGRect editFrame = CGRectInset(self.contentView.frame, 38, 10);
	
	if (self.textLabel.text && [self.textLabel.text length] != 0) {
		CGSize textSize = [self.textLabel sizeThatFits:CGSizeZero];
		editFrame.origin.x += textSize.width + 10;
		editFrame.size.width -= textSize.width + 10;
		self.textField.textAlignment = UITextAlignmentLeft;
	} else {
		self.textField.textAlignment = UITextAlignmentLeft;
	}
	
	self.textField.frame = editFrame;
}

@end
