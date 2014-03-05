//
//  RegisterViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/13/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateInputTableViewCell.h"
#import "StringInputTableViewCell.h"
#import "IntegerInputTableViewCell.h"
#import "SimplePickerInputTableViewCell.h"

@interface RegisterViewController : UITableViewController<UITextFieldDelegate,UIAlertViewDelegate,DateInputTableViewCellDelegate, StringInputTableViewCellDelegate, IntegerInputTableViewCellDelegate, SimplePickerInputTableViewCellDelegate>
@property(nonatomic,retain) NSMutableData *receivedData;
@end
