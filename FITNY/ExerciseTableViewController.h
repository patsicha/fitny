//
//  ExerciseTableViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/26/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) NSString *muscle;
@end
