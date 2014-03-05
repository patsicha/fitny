//
//  CardioViewControllerII.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/8/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardioViewControllerII : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
