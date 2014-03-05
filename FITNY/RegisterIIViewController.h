//
//  RegisterIIViewController.h
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

@interface RegisterIIViewController : UITableViewController <UIAlertViewDelegate,DateInputTableViewCellDelegate, StringInputTableViewCellDelegate, IntegerInputTableViewCellDelegate, SimplePickerInputTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtUsername;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtPassword;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtName;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtEmail;
@property (weak, nonatomic) IBOutlet SimplePickerInputTableViewCell *txtGender;
@property (weak, nonatomic) IBOutlet DateInputTableViewCell *txtBirthday;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtWeight;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell *txtHeight;
@property(nonatomic,retain) NSMutableData *receivedData;
@end
