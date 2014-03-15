//
//  addExerxiseViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/7/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "addExerxiseViewController.h"

@interface addExerxiseViewController ()
{
    NSMutableArray *dataProgram;
    NSMutableArray *dataProgramID;
    UIAlertView *loading;
    NSMutableArray *MemberInfo;
    NSMutableURLRequest *request;
    IBOutlet UIButton *btnTime;
    IBOutlet UIButton *btnRep;
    IBOutlet UISlider *amount;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *txtProgramType;
@property (weak, nonatomic) IBOutlet SimplePickerInputTableViewCell2 *txtProgramName;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtExerciseName;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtExerciseType;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtExerciseAmount;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell2 *txtNewProgram;


@end

@implementation addExerxiseViewController
@synthesize exerciseInfo,ProgramType,receivedData,delegate;
- (IBAction)amount:(id)sender {
    if ([ProgramType isEqualToString:@"By Rep"]) {
        amount.maximumValue = 50;
        self.txtExerciseAmount.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d Reps",(int)amount.value ];
        // self.txtExerciseAmount.values = [NSArray arrayWithObjects:@"-",@"1 Rep",@"2 Reps", @"3 Reps", @"4 Reps", @"5 Reps", @"6 Reps", @"7 Reps", @"8 Reps", @"9 Reps", @"10 Reps", @"11 Reps", @"12 Reps", @"13 Reps", @"14 Reps", @"15 Reps", @"16 Reps", @"17 Reps", @"18 Reps", @"19 Reps", @"20 Reps", nil];
    }else if ([ProgramType isEqualToString:@"By Time"]){
        amount.maximumValue = 125;
        if(amount.value >= 0 && amount.value <= 60)
        {
            self.txtExerciseAmount.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d Seconds",(int)amount.value ];
        }
        if(amount.value >= 61 && amount.value <= 120)
        {
            self.txtExerciseAmount.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d Minutes",(int)amount.value-60 ];
        }
        if(amount.value >= 121 && amount.value <= 125)
        {
            self.txtExerciseAmount.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d Hours",(int)amount.value-120 ];
        }
        // self.txtExerciseAmount.detailTextLabel.text = @"Choose";
        // self.txtExerciseAmount.values = [NSArray arrayWithObjects:@"-",@"10 Seconds",@"20 Seconds",@"30 Seconds",@"40 Seconds",@"60 Seconds",@"2 Minutes",@"3 Minutes",@"5 Minutes",@"10 Minutes", @"20 Minutes", @"30 Minutes", @"45 Minutes", @"1 Hours",@"2 Hours", nil];
        
    }
    
    
}

- (IBAction)selectType:(id)sender {
    
    btnRep.highlighted = YES;
    btnTime.highlighted = YES;
    self.txtNewProgram.textField.text = @"";
    
    dataProgram = [[NSMutableArray alloc]init];
    dataProgramID = [[NSMutableArray alloc]init];
    
    [dataProgram addObject:@"-"];
    [dataProgramID addObject:@""];
    [dataProgram addObject:@"New"];
    [dataProgramID addObject:@""];
    
    if(sender == btnTime)
    {
        ProgramType = @"By Time";
        self.txtExerciseAmount.detailTextLabel.text = @"0 Second";
        amount.value = 0;
        [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnTime.highlighted = NO; }];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        for(NSDictionary *x in [prefs objectForKey:@"Program"])
        {
            if([[x valueForKey:@"type"] isEqualToString:@"By Time"])
            {
                [dataProgram addObject:[x valueForKey:@"name"]];
                [dataProgramID addObject:[x valueForKey:@"id"]];
            }
            
        }
        
        
        self.txtProgramName.values = dataProgram;
        [self.tableView reloadData];
    }else{
        ProgramType = @"By Rep";
        self.txtExerciseAmount.detailTextLabel.text = @"0 Rep";
        amount.value = 0;
        [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnRep.highlighted = NO; }];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        for(NSDictionary *x in [prefs objectForKey:@"Program"])
        {
            if([[x valueForKey:@"type"] isEqualToString:@"By Rep"])
            {
                [dataProgram addObject:[x valueForKey:@"name"]];
                [dataProgramID addObject:[x valueForKey:@"id"]];
            }
            
        }
        
        
        self.txtProgramName.values = dataProgram;
        [self.tableView reloadData];
    }
    self.txtProgramName.detailTextLabel.text = @"Choose";
    [self.txtProgramName setUserInteractionEnabled:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
     [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnRep.highlighted = YES; }];
     [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnTime.highlighted = YES; }];
    dataProgram = [[NSMutableArray alloc]init];
    dataProgramID = [[NSMutableArray alloc]init];
    
    [self.txtProgramName setUserInteractionEnabled:NO];
    self.txtProgramName.values = dataProgram;
    [self.tableView reloadData];
    
    

    
    self.txtProgramType.detailTextLabel.text = ProgramType;
    self.txtProgramName.detailTextLabel.text = @"Select Type";
    
    self.txtNewProgram.textField.placeholder = @"Enter Name";
    self.txtExerciseName.detailTextLabel.text = [exerciseInfo valueForKey:@"ExerciseName"];
    self.txtExerciseName.detailTextLabel.adjustsFontSizeToFitWidth = YES;
    self.txtExerciseType.detailTextLabel.text = [exerciseInfo valueForKey:@"ExerciseType"];
    self.txtProgramName.delegate =self;
    //self.txtExerciseAmount.textField.keyboardType = UIKeyboardTypeDecimalPad;
    if ([ProgramType isEqualToString:@"By Rep"]) {
        //self.txtExerciseAmount.detailTextLabel.text = @"Choose";
       // self.txtExerciseAmount.values = [NSArray arrayWithObjects:@"-",@"1 Rep",@"2 Reps", @"3 Reps", @"4 Reps", @"5 Reps", @"6 Reps", @"7 Reps", @"8 Reps", @"9 Reps", @"10 Reps", @"11 Reps", @"12 Reps", @"13 Reps", @"14 Reps", @"15 Reps", @"16 Reps", @"17 Reps", @"18 Reps", @"19 Reps", @"20 Reps", nil];
    }else{
       // self.txtExerciseAmount.detailTextLabel.text = @"Choose";
       // self.txtExerciseAmount.values = [NSArray arrayWithObjects:@"-",@"10 Seconds",@"20 Seconds",@"30 Seconds",@"40 Seconds",@"60 Seconds",@"2 Minutes",@"3 Minutes",@"5 Minutes",@"10 Minutes", @"20 Minutes", @"30 Minutes", @"45 Minutes", @"1 Hours",@"2 Hours", nil];
        
    }
    self.txtNewProgram.textField.text = @"";
    self.txtNewProgram.alpha = 0.2;
    self.txtNewProgram.userInteractionEnabled = NO;
    
    
    
    

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
    NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/listProgram.php"];
    request = [NSMutableURLRequest requestWithURL:url
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
-(void)tableViewCell:(SimplePickerInputTableViewCell2 *)cell didEndEditingWithValue:(NSString *)value
{
    if(![value isEqualToString:@"New"])
    {
        self.txtNewProgram.textField.text = value;
        self.txtNewProgram.alpha = 0.2;
        self.txtNewProgram.userInteractionEnabled = NO;
    }else {
        self.txtNewProgram.textField.text = @"";
        self.txtNewProgram.alpha = 1;
        self.txtNewProgram.userInteractionEnabled = YES;
    }
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    /*UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: nil cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
	*/
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if (theConnection) {
        self.receivedData = [NSMutableData data];
    } else {
		UIAlertView *connectFailMessage = [[UIAlertView alloc] initWithTitle:@"NSURLConnection " message:@"Failed in viewDidLoad"  delegate: self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
		[connectFailMessage show];
        
    }
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
        
        // Completed
        if( [strStatus isEqualToString:@"1"] ){

            
        }
        else if( [strStatus isEqualToString:@"11"] ){
            
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[jsonObjects objectForKey:@"Program"]  forKey:@"Program"];
            [prefs setObject:[jsonObjects objectForKey:@"Calendar"]  forKey:@"Calendar"];
            [prefs setObject:[jsonObjects objectForKey:@"ProgramDetail"]  forKey:@"ProgramDetail"];
            
            UIAlertView *alert =[[UIAlertView alloc]
                                 initWithTitle:@"Added"
                                 message:@"" delegate:self
                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
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
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"OK"])
    {
        //[self.navigationController popViewControllerAnimated:YES];
        //[self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationSlideBottomTop];
        if (self.delegate && [self.delegate respondsToSelector:@selector(addSuccess:)]) {
            [self.delegate addSuccess:self];
        }
    }
}

- (IBAction)addExercise:(id)sender {
    
    NSString *userid = [MemberInfo valueForKey:@"id"];
    NSString *name = self.txtNewProgram.textField.text;
    NSString *type = ProgramType;
    NSString *exid = [exerciseInfo valueForKey:@"ExerciseID"];
    NSString *exAmount =self.txtExerciseAmount.detailTextLabel.text;
    
    if (exAmount == NULL) return;
    
    if([self.txtProgramName.value isEqualToString:@"New"])
    {
        NSLog(@"INSERT INTO `program`(`userid`, `name`, `type`) VALUES (%@,%@,%@)",userid,name,type);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        loading = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loading addSubview:progress];
        [progress startAnimating];
        [loading show];
        
        dataProgram = [[NSMutableArray alloc]init];
        dataProgramID = [[NSMutableArray alloc]init];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        MemberInfo = [prefs objectForKey:@"MemberInfo"];
        
        NSString *post =[NSString stringWithFormat:@"userid=%@&name=%@&type=%@&exid=%@&exAmount=%@",[MemberInfo valueForKey:@"id"],name,type,exid,exAmount];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",asciiString);
        NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/addExNew.php"];
       request = [NSMutableURLRequest requestWithURL:url
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

    }else{
        NSUInteger idx;
        idx = [dataProgram indexOfObject:self.txtNewProgram.textField.text];
        NSString *pid = [dataProgramID objectAtIndex:idx];
       
        
        NSLog(@"INSERT INTO `program_detail`(`id`, `exerciseID`, `amount`) VALUES (%@,%@,%@)",pid,exid,exAmount);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        loading = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loading addSubview:progress];
        [progress startAnimating];
        [loading show];
        
        dataProgram = [[NSMutableArray alloc]init];
        dataProgramID = [[NSMutableArray alloc]init];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        MemberInfo = [prefs objectForKey:@"MemberInfo"];
        
        NSString *post =[NSString stringWithFormat:@"pid=%@&exid=%@&exAmount=%@&userid=%@",pid,exid,exAmount,[MemberInfo valueForKey:@"id"]];
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",asciiString);
        NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/addEx.php"];
        request = [NSMutableURLRequest requestWithURL:url
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
}

@end
