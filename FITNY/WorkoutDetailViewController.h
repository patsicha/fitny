//
//  WorkoutDetailViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/8/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutDetailViewController : UITableViewController
@property(nonatomic,retain) NSMutableData *receivedData;
@property(nonatomic,strong) NSString *pid;
@property(nonatomic,strong) NSString *pname;
@property(nonatomic,strong) NSString *ptype;
@end
