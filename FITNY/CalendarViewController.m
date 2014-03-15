//
//  CalendarViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/6/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "CalendarViewController.h"
#import "AddToCalendarViewController.h"
#import "ProgramDetailViewController.h"

@interface CalendarViewController ()
{
    TKCalendarMonthView *calendar1;
    NSDate *date;
    UIAlertView *loading;
    NSMutableArray *MemberInfo;
    NSMutableArray *dayProgram;
    NSMutableArray *dayProgramDetail;
    NSMutableArray *program;
}
@end

@implementation CalendarViewController
@synthesize receivedData;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
	// Do any additional setup after loading the view.
    calendar1.alpha = 0;
    
    

}


-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    
    [UIView animateWithDuration:3.0 animations:^{
        calendar1.alpha = 1;
        
    }];

    program = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    dayProgramDetail = [prefs objectForKey:@"Calendar"];
    program = [prefs objectForKey:@"Program"];
    
    dayProgram = [[NSMutableArray alloc]init];
    dayProgram = [dayProgramDetail valueForKey:@"date"];
    
    calendar1=[[TKCalendarMonthView alloc] initWithSundayAsFirst:YES timeZone:[NSTimeZone systemTimeZone]];
    calendar1.delegate = self;
    calendar1.dataSource = self;
    
    [calendar1 selectDate:[NSDate date]];
    NSLog(@"%f",self.tableView.frame.origin.y);
    [self.view addSubview:calendar1];
    [calendar1 reloadData];
    
    //[self getData];
}
-(void)getData
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [loading show];
    
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    MemberInfo = [prefs objectForKey:@"MemberInfo"];
    
    NSString *post =[NSString stringWithFormat:@"userid=%@",[MemberInfo valueForKey:@"id"]];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
    NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/listCalendar.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
	[request setHTTPBody:postData];
    
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (theConnection) {
        self.receivedData = [NSMutableData data];
    } else {
		UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"Failed in viewDidLoad"  delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[connectFailMessage show];
        
    }
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
- (void)calendarMonthView:(TKCalendarMonthView *)monthView didSelectDate:(NSDate *)d {
    
	NSLog(@"%@",[self toLocal:d]);
    date = [self toLocal:d];
    [self.tableView reloadData];
}

- (void)calendarMonthView:(TKCalendarMonthView *)monthView monthDidChange:(NSDate *)d {
	NSLog(@"calendarMonthView monthDidChange");
}
- (NSArray*) calendarMonthView:(TKCalendarMonthView*)monthView marksFromDate:(NSDate*)startDate toDate:(NSDate*)lastDate{
   
    [self generateRandomDataForStartDate:startDate endDate:lastDate];
    //NSLog(@"%@",self.dataArray);
    //NSLog(@"%@",self.dataDictionary);
    //NSLog(@"%@ %@",startDate,lastDate);
    [self.tableView reloadData];
	return self.dataArray;
}

- (void) calendarMonthView:(TKCalendarMonthView*)mv monthDidChange:(NSDate*)d animated:(BOOL)animated{
     //[self viewDidAppear:YES];
	[self.tableView reloadData];
    if(calendar1.bounds.size.height < 300)
        _tableView.frame = CGRectMake(_tableView.frame.origin.x,calendar1.bounds.size.height+10, _tableView.frame.size.width, 146);
    else
        _tableView.frame = CGRectMake(_tableView.frame.origin.x,calendar1.bounds.size.height+10, _tableView.frame.size.width, 146-44);
}
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSArray *ar = self.dataDictionary[[calendar1 dateSelected]];
	if(ar == nil) return 0;
	return [ar count];
}
- (UITableViewCell *) tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
	
    
	NSArray *ar = self.dataDictionary[[calendar1 dateSelected]];
    NSUInteger idx;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    program = [prefs objectForKey:@"Program"];
    idx = [[program valueForKey:@"id"] indexOfObject:ar[indexPath.row]];
    NSLog(@"%@",program);
    NSString *pname = [[program valueForKey:@"name"] objectAtIndex:idx];
	cell.textLabel.text = pname;
    cell.detailTextLabel.text = [[program valueForKey:@"type"] objectAtIndex:idx];
	
    return cell;
	
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        //[dataProgramDetail deleteObject:[food_Core objectAtIndex:indexPath.row]];
        
        
        // Remove device from table view
        [self.dataDictionary[[calendar1 dateSelected]] removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (NSDate *) setDateFromDay:(NSString *)strDate
{
    NSArray *arrDate = [strDate componentsSeparatedByString:@"-"];
    NSInteger day = [arrDate[2] intValue];
    NSInteger month = [arrDate[1] intValue];
    NSInteger year = [arrDate[0] intValue];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date2 = [cal dateFromComponents:comps];
    return date2;
}
- (void) generateRandomDataForStartDate:(NSDate*)start endDate:(NSDate*)end{
	// this function sets up dataArray & dataDictionary
	// dataArray: has boolean markers for each day to pass to the calendar view (via the delegate function)
	// dataDictionary: has items that are associated with date keys (for tableview)
	
   
    
	self.dataArray = [NSMutableArray array];
	self.dataDictionary = [NSMutableDictionary dictionary];
	
	NSDate *d = start;
	while(YES){
        BOOL found = NO;
        for(NSString *x in dayProgram)
        {
            if([d isEqualToDate:[self setDateFromDay:x]] && ([(self.dataDictionary)[d] count] == 0 )){
                NSLog(@"%@",[dayProgramDetail valueForKey:@"date"]);
                 NSMutableArray *arr = [[NSMutableArray alloc]init];
                for(NSDictionary *y in dayProgramDetail)
                {
                    NSLog(@"%@",[y valueForKey:@"date"]);
                    if([[y valueForKey:@"date"]isEqualToString:x])
                        [arr addObject:[y valueForKey:@"programID"]];
                }
                (self.dataDictionary)[d] = arr;
                NSLog(@"%@",(self.dataDictionary));
                [self.dataArray addObject:@YES];
                found = YES;
            }
        }
        if(!found) [self.dataArray addObject:@NO];
        
		
		
		NSDateComponents *info = [d dateComponentsWithTimeZone:calendar1.timeZone];
		info.day++;
		d = [NSDate dateWithDateComponents:info];
		if([d compare:end]==NSOrderedDescending) break;
	}
	
}
- (IBAction)add:(id)sender {
    AddToCalendarViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addToCalendar"];
    svc.date = date;
    [self.navigationController pushViewController:svc animated:YES];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    sleep(0);
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    // inform the user
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
	
    //inform the user
    NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
    
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Hide Progress
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    // Return Status E.g : { "Status":"1", "Message":"Insert Data Successfully" }
    // 0 = Error
    // 1 = Completed
    
    if(receivedData)
    {
        // NSLog(@"%@",receivedData);
        
        // NSString *dataString = [[NSString alloc] initWithData:receivedData encoding:NSASCIIStringEncoding];
        // NSLog(@"%@",dataString);
        
        id jsonObjects = [NSJSONSerialization JSONObjectWithData:receivedData options:NSJSONReadingMutableContainers error:nil];
        
        // value in key name
        NSString *strStatus = [jsonObjects objectForKey:@"Status"];
        dayProgramDetail =  [[NSMutableArray alloc]init];
        program = [[NSMutableArray alloc]init];
        dayProgramDetail = [jsonObjects objectForKey:@"Calendar"];
        program = [jsonObjects objectForKey:@"Program"];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:[jsonObjects objectForKey:@"Program"]  forKey:@"Program"];
        [prefs setObject:[jsonObjects objectForKey:@"Calendar"]  forKey:@"Calendar"];
        // Completed
        if( [strStatus isEqualToString:@"1"] ){
            dayProgram =  [[NSMutableArray alloc]init];
            for(NSDictionary *x in [jsonObjects objectForKey:@"Calendar"])
            {
                [dayProgram addObject:[x valueForKey:@"date"]];
                
            }
            NSLog(@"%@",dayProgramDetail);
            NSLog(@"%@",dayProgram);
            
            [calendar1 reloadData];
        }
        
        else // Error
        {
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@": ( Error!"
                                 message:@"" delegate:nil
                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
        }
        
    }
    
    // release the connection, and the data object
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *programInfo;
    NSArray *ar = self.dataDictionary[[calendar1 dateSelected]];
    NSUInteger idx;
    idx = [[program valueForKey:@"id"] indexOfObject:ar[indexPath.row]];
    ProgramDetailViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgramDetail"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    program = [prefs objectForKey:@"Program"];
    programInfo = [program objectAtIndex:idx];
    svc.pid = [programInfo valueForKey:@"id"];
    svc.pname = [programInfo valueForKey:@"name"];
    [self.navigationController pushViewController:svc animated:YES];
}
-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [self viewDidAppear:YES];
}

@end
