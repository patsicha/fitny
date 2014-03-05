//
//  TimerViewController.h
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/19/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimerViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain) NSMutableData *receivedData;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSString *pid;
@property(nonatomic,strong) NSString *pname;
@property (weak, nonatomic) IBOutlet UIButton *btnPause;
@property (weak, nonatomic) IBOutlet UIButton *btnPlay;
@property (weak, nonatomic) IBOutlet UIButton *btnSkip;
@property (weak, nonatomic) IBOutlet UIButton *btnRe;
@property(nonatomic,strong) NSString *ptype;
@end
