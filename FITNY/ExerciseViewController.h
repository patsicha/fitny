//
//  ExerciseViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/27/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (strong,nonatomic) NSManagedObject* exerciseInfo;
@property (nonatomic) BOOL btnAdd;
@end
