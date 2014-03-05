//
//  TimerViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/19/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "TimerViewController.h"
#import "CircularTimerView.h"

@interface TimerViewController ()
{
    UIAlertView *loading;
    NSMutableArray *dataProgramDetail;
    NSMutableArray *ExData;
    NSMutableArray *Done;
    NSTimer *timer;
    NSString *strTimer;
    int currMinute;
    int currSeconds;
    int currExNum;
    BOOL Rest;
    NSMutableArray *Minutes;
    NSMutableArray *Seconds;
    IBOutlet UIButton *btnTimer;
    IBOutlet UIView *subview;
    int currExNum_ed;
    BOOL Rest_ed;
    int prepare;
    IBOutlet UILabel *lblCurEx;
}
@property (nonatomic, strong) CircularTimerView *circularTimer;
@property (nonatomic, assign) NSTimeInterval countdownSeconds;
@end

@implementation TimerViewController

@synthesize receivedData,pid,pname,ptype;

- (NSString *)timeIntervalToString:(NSTimeInterval) interval
{
    long work = (long)interval; // convert to long, NSTimeInterval is *some* numeric type
    
    long seconds = work % 60;   // remainder is seconds
    work /= 60;                 // total number of mins
    long minutes = work % 60;   // remainder is minutes
    
    // now format and return - %ld is long decimal, %02ld is zero-padded two digit long decimal
    return [NSString stringWithFormat:@"%02ld:%02ld", minutes, seconds+1];
}
- (void)createCircle:(int)countdown
{
    int r = 100;
    self.circularTimer = [[CircularTimerView alloc] initWithPosition:CGPointMake(subview.center.x-r, subview.center.y-r)
                                                              radius:r
                                                      internalRadius:r-8];
    self.circularTimer.autostart = NO;
    self.circularTimer.backgroundColor = [UIColor clearColor];
    self.circularTimer.backgroundFadeColor = [UIColor clearColor];
    self.circularTimer.foregroundColor = [UIColor orangeColor];
    self.circularTimer.foregroundFadeColor = [UIColor orangeColor];
    self.circularTimer.direction = CircularTimerViewDirectionClockwise;
    self.circularTimer.font = [UIFont systemFontOfSize:25];
    
    self.circularTimer.frameBlock = ^(CircularTimerView *circularTimerView){
        circularTimerView.text = [NSString stringWithFormat:@"%@", [self timeIntervalToString : [circularTimerView intervalLength] - [circularTimerView runningElapsedTime]]];
    };
    
    [self.circularTimer setupCountdown:countdown];
    
    __weak typeof(self) weakSelf = self;
    self.circularTimer.startBlock = ^(CircularTimerView *circularTimerView){
        //weakSelf.statusLabel.text = @"Running!";
        btnTimer.hidden = YES;
    };
    self.circularTimer.endBlock = ^(CircularTimerView *circularTimerView){
        //weakSelf.statusLabel.text = @"Not running anymore!";
        circularTimerView.text = @"Pause";
        if(currExNum >= [dataProgramDetail count]) btnTimer.hidden = NO;
    };
    //self.statusLabel.text = ([self.circularTimer willRun]) ? @"Circle will run" : @"Circle won't run";
    
    [subview addSubview:self.circularTimer];
}
- (IBAction)startTimer:(id)sender {
    [self timerFired];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [btnTimer setHidden:NO];
    [_btnPause setHidden:YES];
    [_btnSkip setHidden:YES];
    [_btnPlay setHidden:YES];
    [_btnRe setHidden:YES];
    self.navigationController.navigationBar.translucent = NO;
    [self loadExData];
    self.tableView.delegate = self;
    currExNum_ed=-1;
    Rest_ed = NO;
    prepare = 5;
    //NSLog(@"%@",pid);
    self.title = pname;
    dataProgramDetail = [[NSMutableArray alloc]init];
    Minutes = [[NSMutableArray alloc]init];
    Seconds = [[NSMutableArray alloc]init];
    Done = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for(NSDictionary *x in [prefs objectForKey:@"ProgramDetail"])
    {
        if([[x valueForKey:@"id"] isEqualToString:pid]) [dataProgramDetail addObject:x];
    }
    //[self getData];
    
    if ([ptype isEqualToString:@"By Time"]) {
        
        for(NSString *x in [dataProgramDetail valueForKey:@"amount"])
        {
            //NSLog(@"%@",x);
            NSArray *arrX = [x componentsSeparatedByString:@" "];
            if([arrX[1] isEqualToString:@"Seconds"] || [arrX[1] isEqualToString:@"Second"] )
            {
                [Seconds addObject:arrX[0]];
                [Minutes addObject:@"0"];
            }
            if([arrX[1] isEqualToString:@"Minutes"] || [arrX[1] isEqualToString:@"Minute"] )
            {
                [Seconds addObject:@"0"];
                [Minutes addObject:arrX[0]];
            }
            
        }
        Rest = NO;
        currExNum = -1;
        //currMinute=[Minutes[currExNum] intValue];
        //currSeconds=[Seconds[currExNum] intValue];
    }
    [self.tableView reloadData];
}
- (IBAction)skip:(id)sender {
    [sender setHidden:YES];
    [self pause:_btnPause];
    [self play:_btnPlay];
    
    [self.circularTimer setupCountdown:0];
    currMinute = 0;
    currSeconds = 0;
    Rest = !Rest;
}
- (IBAction)pause:(id)sender {
    [sender setHidden:YES];
    [_btnPlay setHidden:NO];
    [self.circularTimer stop];
    [timer invalidate];
    
    
}
- (IBAction)play:(id)sender {
    [sender setHidden:YES];
    [_btnPause setHidden:NO];
    [self.circularTimer finalDate:currMinute*60 + currSeconds];
    [self.circularTimer start];
    [self timerFired];
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
}

-(void)timerFired
{
    
    
    if(prepare==5) {
        lblCurEx.text =@"Ready";
        currMinute = 0;
        currSeconds = 5;
        [self createCircle:currMinute*60 + currSeconds];
    }
    if(prepare<=0){
        if(prepare==0) {
            [_btnPause setHidden:NO];
            [_btnSkip setHidden:NO];
            currExNum++;
            currMinute=[Minutes[currExNum] intValue];
            currSeconds=[Seconds[currExNum] intValue];
            prepare--;
            NSManagedObject *programInfo;
            programInfo = [dataProgramDetail objectAtIndex:currExNum];
            NSUInteger idx = [[ExData valueForKey:@"ExerciseID"] indexOfObject:[programInfo valueForKey:@"exerciseID"]];
            //NSLog(@"%lu",(unsigned long)idx );
            NSManagedObject *exInfo = [ExData objectAtIndex:idx];
            lblCurEx.text = [exInfo valueForKey:@"ExerciseName"];
        }
    NSLog(@"%d:%d",currMinute,currSeconds);
    if(currExNum_ed != currExNum || Rest_ed != Rest) {
        currExNum_ed = currExNum;
        Rest_ed = Rest;
        [self createCircle:currMinute*60 + currSeconds];
        
    }
    
    if((currMinute>0 && currSeconds>=0) )
    {
        if(currSeconds==0)
        {
            currMinute-=1;
            currSeconds=59;
        }
        else if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
        {
            [self.tableView reloadData];
            
        }
    }
    else if(currMinute == 0 && currSeconds != 0)
    {
        if(currSeconds>0)
        {
            currSeconds-=1;
        }
        if(currMinute>-1)
        {
            [self.tableView reloadData];
            
        }
        
    }
    else
    {
        if(!Rest && (currExNum < [dataProgramDetail count] - 1))
        {
            currMinute = 0;
            currSeconds = 5;
            Rest = !Rest;
            lblCurEx.text =@"Rest";
        }else
        {
            currExNum++;
            
            
            
            if(currExNum < [dataProgramDetail count])
            {
                [_btnSkip setHidden:NO];
                NSManagedObject *programInfo;
                programInfo = [dataProgramDetail objectAtIndex:currExNum];
                NSUInteger idx = [[ExData valueForKey:@"ExerciseID"] indexOfObject:[programInfo valueForKey:@"exerciseID"]];
                //NSLog(@"%lu",(unsigned long)idx );
                NSManagedObject *exInfo = [ExData objectAtIndex:idx];
                lblCurEx.text = [exInfo valueForKey:@"ExerciseName"];
                
                
                NSIndexPath *myIP = [NSIndexPath indexPathForRow:currExNum inSection:0] ;
                [self.tableView scrollToRowAtIndexPath:myIP atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                
                currMinute=[Minutes[currExNum] intValue];
                currSeconds=[Seconds[currExNum] intValue];
                Rest = !Rest;
                
            }else {
                [_btnPause setHidden:YES];
                [_btnSkip setHidden:YES];
                [_btnPlay setHidden:YES];
                [btnTimer setHidden:YES];
                [_btnRe setHidden:NO];
                [timer invalidate];
                [self.tableView reloadData];
                
            }
            
        }
    }
    }else{
        
        prepare--;
    }
    
}
- (IBAction)re:(id)sender {
    [btnTimer setHidden:NO];
    [_btnPause setHidden:YES];
    [_btnSkip setHidden:YES];
    [_btnPlay setHidden:YES];
    [_btnRe setHidden:YES];
    Rest_ed = NO;
    prepare = 5;
    currExNum_ed = currExNum= -1;
    [self.tableView reloadData];
    NSIndexPath *myIP = [NSIndexPath indexPathForRow:0 inSection:0] ;
    [self.tableView scrollToRowAtIndexPath:myIP atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self startTimer:btnTimer];
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
    
    dataProgramDetail = [[NSMutableArray alloc]init];
    
    NSString *post =[NSString stringWithFormat:@"pid=%@",pid];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    //NSLog(@"%@",asciiString);
    NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/loadDetailProgram.php"];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //if (![ptype isEqualToString:@"By Time"])
    return 1;
    //else return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) return [dataProgramDetail count];
    else return 3;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:111];
    UIImageView *now = (UIImageView *)[cell viewWithTag:1234];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:222];
    UILabel *idLabel = (UILabel *)[cell viewWithTag:999];
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:333];
    if(indexPath.section == 0) {
        imageView.hidden = NO;
        nameLabel.hidden = NO;
        idLabel.hidden = NO;
        typeLabel.hidden = NO;
        //NSLog(@"%ld < %lu",(long)indexPath.row,(unsigned long)[dataProgramDetail count]);
        
        
        NSManagedObject *programInfo;
        programInfo = [dataProgramDetail objectAtIndex:indexPath.row];
        
        NSUInteger idx = [[ExData valueForKey:@"ExerciseID"] indexOfObject:[programInfo valueForKey:@"exerciseID"]];
        //NSLog(@"%lu",(unsigned long)idx );
        NSManagedObject *exInfo = [ExData objectAtIndex:idx];
        if(currExNum == indexPath.row) {
            UIColor * color = [UIColor colorWithRed:250/255.0f green:149/255.0f blue:22/255.0f alpha:0.5f];
            //cell.backgroundColor = color;
            now.hidden = NO;
        }else
        {
            now.hidden = YES;
            //cell.backgroundColor = [UIColor whiteColor];
        }
        imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[exInfo valueForKey:@"ExerciseName"]]];
        
        nameLabel.text = [exInfo valueForKey:@"ExerciseName"];
        nameLabel.adjustsFontSizeToFitWidth = YES;
        idLabel.text = [exInfo valueForKey:@"ExerciseID"];
        
        typeLabel.text = [programInfo valueForKey:@"amount"];
        
            if(currExNum > indexPath.row)
            {
                cell.accessoryType =UITableViewCellAccessoryCheckmark;
            }else
                cell.accessoryType =UITableViewCellAccessoryNone;
    }
    
    //cell.textLabel.text = [exInfo valueForKey:@"ExerciseName"];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) return 78;
    else{
        if(indexPath.row == 1) return 50;
        else return 30;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0) {
        NSManagedObject *programInfo;
        programInfo = [dataProgramDetail objectAtIndex:indexPath.row];
        [Done addObject:programInfo];
        if([Done count] == [dataProgramDetail count]){
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            Done = [[prefs objectForKey:@"ProgramDone"] mutableCopy];
            if(Done == NULL) Done = [[NSMutableArray alloc]init];
            NSDate *Today = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterFullStyle];
            NSDictionary *temp = [[NSDictionary alloc]initWithObjectsAndKeys:[formatter stringFromDate:Today],@"date",pid,@"pid", nil];
            [Done addObject:temp];
            [prefs setObject:Done forKey:@"ProgramDone"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }else{
        if(indexPath.row==0) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.userInteractionEnabled = NO;
        }
        if(indexPath.row == 2 && !(currExNum < [dataProgramDetail count]))
        {
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            Done = [prefs objectForKey:@"ProgramDone"];
            if(Done == NULL) Done = [[NSMutableArray alloc]init];
            NSDate *Today = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateStyle:NSDateFormatterFullStyle];
            NSDictionary *temp = [[NSDictionary alloc]initWithObjectsAndKeys:[formatter stringFromDate:Today],@"date",pid,@"pid", nil];
            NSUInteger idx = [Done indexOfObject:temp];
            //NSLog(@"%lu",(unsigned long)idx );
            if(idx > [Done count])[Done addObject:temp];
            // NSLog(@"%@",Done);
            [prefs setObject:Done forKey:@"ProgramDone"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    [self.tableView reloadData];
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
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
	
    //inform the user
    //NSLog(@"Connection failed! Error - %@", [error localizedDescription]);
    
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
        
        // Completed
        if( [strStatus isEqualToString:@"1"] ){
            dataProgramDetail = [jsonObjects objectForKey:@"program"];
            [self.tableView reloadData];
        }
        else // Error
        {
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@": ( Error!"
                                 message:@"" delegate:self
                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
        }
        
    }
    
    // release the connection, and the data object
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = FALSE;
    
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = TRUE;
    self.tabBarController.tabBar.hidden = NO;
    [timer invalidate];
    
}
-(void)loadExData
{
    NSArray *muscles = [[NSArray alloc] initWithObjects:@"Abdominals",@"Biceps",@"Chest",@"Forearems",@"Lats",@"Lower Back",@"Legs",@"Middle Back",@"Shoulders",@"Traps",@"Triceps",@"Cardio", nil];
    ExData = [[NSMutableArray alloc] init];
    for(NSString *muscle in muscles) {
        NSString *path = [[NSBundle mainBundle] pathForResource:muscle ofType:@"plist"];
        // Load the file content and read the data into arrays
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        int i = 0;
        for (NSString *dataDict in [dict objectForKey:@"ExerciseID"]) {
            NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [[dict objectForKey:@"ExerciseID"] objectAtIndex:i], @"ExerciseID",
                                  [[dict objectForKey:@"ExerciseName"] objectAtIndex:i], @"ExerciseName",
                                  [[dict objectForKey:@"ExerciseType"] objectAtIndex:i ], @"ExerciseType",
                                  nil];
            [ExData addObject:temp];
            
            i++;
        }
    }
    
}

@end