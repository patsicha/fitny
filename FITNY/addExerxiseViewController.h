//
//  addExerxiseViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/7/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePickerInputTableViewCell2.h"
#import "StringInputTableViewCell2.h"

@protocol AddExDelegate;

@interface addExerxiseViewController : UITableViewController<SimplePickerInputTableViewCell2Delegate,UIAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (assign, nonatomic) id <AddExDelegate>delegate;
@property (strong,nonatomic) NSManagedObject* exerciseInfo;
@property (strong,nonatomic) NSString* ProgramType;
@property(nonatomic,retain) NSMutableData *receivedData;
- (IBAction)selectType:(id)sender;
@end

@protocol AddExDelegate<NSObject>
@optional
- (void)addSuccess:(addExerxiseViewController*)sv;;
@end