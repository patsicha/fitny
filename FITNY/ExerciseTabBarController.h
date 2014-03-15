//
//  ExerciseTabBarController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/20/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseTabBarController : UITabBarController
@property (strong,nonatomic) NSManagedObject* exerciseInfo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rbtnAdd;
@property (nonatomic) BOOL btnAdd;
@end
