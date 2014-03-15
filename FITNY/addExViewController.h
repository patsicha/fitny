//
//  addExViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 3/4/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimplePickerInputTableViewCell2.h"

@protocol AddExDelegate;

@interface addExViewController : UIViewController<SimplePickerInputTableViewCell2Delegate,UITableViewDelegate,UITableViewDataSource> {
    IBOutlet UIButton * btnTime;
    IBOutlet UIButton * btnRep;
}
@property (assign, nonatomic) id <AddExDelegate>delegate;
@property (strong,nonatomic) NSManagedObject* exerciseInfo;
@property(nonatomic,retain) NSMutableData *receivedData;
@end


@protocol AddExDelegate<NSObject>
@optional
- (void)addSuccess:(addExViewController*)sv;;
@end