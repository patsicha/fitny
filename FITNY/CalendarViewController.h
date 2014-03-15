//
//  CalendarViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/6/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "TapkuLibrary/TapkuLibrary.h"
#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <TKCalendarMonthViewDelegate,TKCalendarMonthViewDataSource,UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
@property(nonatomic,retain) NSMutableData *receivedData;
@end
