//
//  WorkoutViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/9/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "WorkoutViewController.h"
#import "TimerViewController.h"

@interface WorkoutViewController ()
{
    NSMutableArray *Calendar;
    NSMutableArray *Program;
    NSMutableArray *TodayProgram;
    NSMutableArray *Done;
    NSString *Date;
}
@end

@implementation WorkoutViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    NSDate *Today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    Date=[formatter stringFromDate:Today];
    self.title = [dateFormatter stringFromDate:Today];
    
    
    
}
- (NSDate *) toLocal:(NSDate*)sourceDate
{
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] ;
    
    return destinationDate;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [TodayProgram count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSManagedObject *programInfo = [TodayProgram objectAtIndex:indexPath.row];
    
    NSUInteger idx;
    idx = [[Program valueForKey:@"id"] indexOfObject:[programInfo valueForKey:@"programID"]];
    NSLog(@"%@",Done);
    NSString *pname = [[Program valueForKey:@"name"] objectAtIndex:idx];
	cell.textLabel.text = pname;
    cell.detailTextLabel.text = [[Program valueForKey:@"type"] objectAtIndex:idx];
    
    
    idx = [[Done valueForKey:@"pid"] indexOfObject:[programInfo valueForKey:@"programID"]];
    NSLog(@"%lu",(unsigned long)idx);

    if(idx < [Program count] && [[[Done objectAtIndex:idx] valueForKey:@"date"] isEqualToString:Date])
    {
        cell.backgroundColor = [UIColor greenColor];
    }else cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    TodayProgram = [[NSMutableArray alloc]init];
    
    self.navigationController.navigationBarHidden = FALSE;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    Calendar = [prefs objectForKey:@"Calendar"];
    Program = [prefs objectForKey:@"Program"];
    Done = [[NSMutableArray alloc]init];
    Done = [prefs objectForKey:@"ProgramDone"];
    if(Done == NULL) Done = [[NSMutableArray alloc]init];
    
    NSLog(@"%@",Done);
    NSMutableIndexSet *iset =[NSMutableIndexSet indexSet];
    NSUInteger i = 0;
    for(NSDictionary *a in Done)
    {
        NSLog(@"%@",a);
        
        if(!([[a valueForKey:@"date"] isEqualToString:Date]))
        {
            [iset addIndex:i];
        }
        i++;
        
    }
    [Done removeObjectsAtIndexes:iset];
    NSLog(@"%@",Done);
    
    
    
    
    for(NSDictionary *x in Calendar)
    {
        if([[x valueForKey:@"date"]isEqualToString:Date]) [TodayProgram addObject:x];
    }
    
    [self.tableView reloadData];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = TRUE;
    self.tabBarController.tabBar.hidden = NO;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *programInfo;
    programInfo = [TodayProgram objectAtIndex:indexPath.row];
    NSUInteger idx;
    idx = [[Program valueForKey:@"id"] indexOfObject:[programInfo valueForKey:@"programID"]];
    TimerViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"WorkoutDetail"];
    programInfo = [Program objectAtIndex:idx];
    svc.pid = [programInfo valueForKey:@"id"];
    svc.pname = [programInfo valueForKey:@"name"];
    svc.ptype = [programInfo valueForKey:@"type"];
    [self.navigationController pushViewController:svc animated:YES];
}


@end
