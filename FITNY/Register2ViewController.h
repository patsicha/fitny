//
//  Register2ViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/6/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DateInputTableViewCell.h"
#import "StringInputTableViewCell.h"
#import "IntegerInputTableViewCell.h"
#import "SimplePickerInputTableViewCell.h"

@interface Register2ViewController : UITableViewController <DateInputTableViewCellDelegate, StringInputTableViewCellDelegate, IntegerInputTableViewCellDelegate, SimplePickerInputTableViewCellDelegate>

@end
