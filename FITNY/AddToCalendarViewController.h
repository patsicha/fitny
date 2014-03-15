//
//  AddToCalendarViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/9/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePickerInputTableViewCell2.h"

@interface AddToCalendarViewController : UITableViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet SimplePickerInputTableViewCell2 *txtProgramName;
@property(nonatomic,retain) NSMutableData *receivedData;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtDate;
@property(nonatomic,strong) NSDate *date;
@end
