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
    IBOutlet UIPickerView *amountPicker;
    IBOutlet UIPickerView *amountRepPicker;
    NSMutableArray *pickerRep;
    NSMutableArray *pickerHr;
    NSMutableArray *pickerMin;
    NSMutableArray *pickerSec;
    NSInteger RepPicker_index;
    NSInteger HrPicker_index;
    NSInteger MinPicker_index;
    NSInteger SecPicker_index;
    IBOutlet UIButton *btnDone;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *txtProgramType;
@property (weak, nonatomic) IBOutlet SimplePickerInputTableViewCell2 *txtProgramName;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtExerciseName;
@property (weak, nonatomic) IBOutlet UITableViewCell *txtExerciseType;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell2 *txtExerciseAmount;
@property (weak, nonatomic) IBOutlet StringInputTableViewCell2 *txtNewProgram;
@property (nonatomic, retain) UIView *inputAccView;

@end

@implementation addExerxiseViewController
@synthesize exerciseInfo,ProgramType,receivedData,delegate,inputAccView;
    
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
        [_txtExerciseAmount setUserInteractionEnabled:YES];
        _txtExerciseAmount.textField.inputView = amountPicker;
        ProgramType = @"By Time";
        _txtExerciseAmount.textField.text = @"";
        //self.txtExerciseAmount.detailTextLabel.text = @"0 Second";
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
        [_txtExerciseAmount setUserInteractionEnabled:YES];
        _txtExerciseAmount.textField.inputView = amountRepPicker;
        ProgramType = @"By Rep";
        _txtExerciseAmount.textField.text =@"";
        //self.txtExerciseAmount.detailTextLabel.text = @"0 Rep";
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
    
    [_txtExerciseAmount setUserInteractionEnabled:NO];
    [self createInputAccessoryView];
    
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
    
    amountPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    amountPicker.delegate = self;
    amountPicker.dataSource = self;
    [amountPicker setShowsSelectionIndicator:YES];
    [amountPicker setUserInteractionEnabled:YES];
    
    amountRepPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    amountRepPicker.delegate = self;
    amountRepPicker.dataSource = self;
    [amountRepPicker setShowsSelectionIndicator:YES];
    [amountRepPicker setUserInteractionEnabled:YES];
    
    [_txtExerciseAmount.textField setInputAccessoryView:inputAccView];
    
    pickerHr = [[NSMutableArray alloc]init];
    pickerMin = [[NSMutableArray alloc]init];
    pickerSec = [[NSMutableArray alloc]init];
    pickerRep = [[NSMutableArray alloc]init];
    
    HrPicker_index=0;
    MinPicker_index=0;
    SecPicker_index=0;
    RepPicker_index=0;
    for (int i = 0; i<30; i++) [pickerRep addObject:[[NSString alloc] initWithFormat:@"%d",i]];
    for (int i = 0; i<60; i++) {
        
        [pickerHr addObject:[[NSString alloc] initWithFormat:@"%d",i]];
        [pickerMin addObject:[[NSString alloc] initWithFormat:@"%02d",i]];
        [pickerSec addObject:[[NSString alloc] initWithFormat:@"%02d",i]];
    }
    /*UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.barStyle = UIBarStyleBlackOpaque;
    
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneBtnPressToGetValue)];
    
    [toolBar setItems:[NSArray arrayWithObject:btn]];
    [amountPicker addSubview:toolBar];*/
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if(pickerView == amountPicker){
    if(component == 0) {
        HrPicker_index = row;
    }
    else if(component == 1) {
        MinPicker_index = row;
    }
    else {
        SecPicker_index = row;
    }
    
    _txtExerciseAmount.textField.text = [[NSString alloc] initWithFormat:@"%@:%@:%@",[pickerHr objectAtIndex:HrPicker_index],[pickerMin objectAtIndex:MinPicker_index],[pickerSec objectAtIndex:SecPicker_index]];
    }else{
        RepPicker_index = row;
        _txtExerciseAmount.textField.text = [[NSString alloc] initWithFormat:@"%@ Rep",[pickerRep objectAtIndex:RepPicker_index]];
    }
    //[self.view endEditing:YES];
}
-(void)createInputAccessoryView{
    // Create the view that will play the part of the input accessory view.
    // Note that the frame width (third value in the CGRectMake method)
    // should change accordingly in landscape orientation. But we don’t care
    // about that now.
    inputAccView = [[UIView alloc] initWithFrame:CGRectMake(10.0, 0.0, 310.0, 40.0)];
    
    // Set the view’s background color. We’ ll set it here to gray. Use any color you want.
   [inputAccView setBackgroundColor:[UIColor darkGrayColor]];
    
    btnDone = [UIButton buttonWithType:UIButtonTypeSystem];
    [btnDone setFrame:CGRectMake(240.0, 0.0f, 80.0f, 40.0f)];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    [btnDone addTarget:self action:@selector(doneTyping) forControlEvents:UIControlEventTouchUpInside];
    
    // Now that our buttons are ready we just have to add them to our view.
    [inputAccView addSubview:btnDone];
}
- (void)doneTyping
{
    [self.view endEditing:YES];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if(pickerView == amountPicker){
        return 3;
    }else return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(pickerView == amountPicker){
    if(component == 0)
        return pickerHr.count;
    else if(component == 1)
        return pickerMin.count;
    else
        return pickerSec.count;
    }else{
        return pickerRep.count;
    }
    
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(pickerView == amountPicker){
    if(component == 0)
        return [pickerHr objectAtIndex:row];
    else if(component == 1)
        return [pickerMin objectAtIndex:row];
    else
        return [pickerSec objectAtIndex:row];
    }else{
        return [pickerRep objectAtIndex:row];
    }
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
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.tableView endEditing:YES];// this will do the trick
}

- (IBAction)addExercise:(id)sender {
    
    NSString *userid = [MemberInfo valueForKey:@"id"];
    NSString *name = self.txtNewProgram.textField.text;
    NSString *type = ProgramType;
    NSString *exid = [exerciseInfo valueForKey:@"ExerciseID"];
    NSString *exAmount =self.txtExerciseAmount.textField.text;
    
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
