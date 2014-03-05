//
//  AddToCalendarViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/9/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "AddToCalendarViewController.h"

@interface AddToCalendarViewController ()
{
    UIAlertView *loading;
    NSMutableArray *MemberInfo;
    NSMutableArray *dataProgram;
    NSMutableArray *dataProgramID;
    NSString *Date;
    NSMutableURLRequest *request;
}
@end

@implementation AddToCalendarViewController
@synthesize date,txtDate,txtProgramName,receivedData;
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
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    Date=[formatter stringFromDate:date];
    txtDate.detailTextLabel.text = Date;

    dataProgram = [[NSMutableArray alloc]init];
    dataProgramID = [[NSMutableArray alloc]init];
    
    [dataProgram addObject:@"-"];
    [dataProgramID addObject:@""];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for(NSDictionary *x in [prefs objectForKey:@"Program"])
    {
        [dataProgram addObject:[x valueForKey:@"name"]];
        [dataProgramID addObject:[x valueForKey:@"id"]];
        
    }
    self.txtProgramName.values = dataProgram;
    [self.tableView reloadData];
    
}

-(void)getData{
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:[jsonObjects objectForKey:@"Program"]  forKey:@"Program"];
        [prefs setObject:[jsonObjects objectForKey:@"Calendar"]  forKey:@"Calendar"];
        [prefs setObject:[jsonObjects objectForKey:@"ProgramDetail"]  forKey:@"ProgramDetail"];
        
        // Completed
        if( [strStatus isEqualToString:@"1"] ){
            
            for(NSDictionary *x in [jsonObjects objectForKey:@"program"])
            {
                [dataProgram addObject:[x valueForKey:@"name"]];
                [dataProgramID addObject:[x valueForKey:@"id"]];
                
            }
            self.txtProgramName.values = dataProgram;
            [self.tableView reloadData];
        }
        else if( [strStatus isEqualToString:@"11"] ){
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
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)add:(id)sender {
    NSUInteger idx;
    idx = [dataProgram indexOfObject:txtProgramName.detailTextLabel.text];
    NSString *pid = [dataProgramID objectAtIndex:idx];
    
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
    
    NSString *post =[NSString stringWithFormat:@"userid=%@&pid=%@&date=%@",[MemberInfo valueForKey:@"id"],pid,Date];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
    NSURL *url = [NSURL URLWithString:@"http://www.fitny.co.nf/php/addToCalendar.php"];
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

@end
