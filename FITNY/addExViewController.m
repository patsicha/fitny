//
//  addExViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 3/4/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "addExViewController.h"

@interface addExViewController ()
{
    NSString *strType;
    NSMutableArray *dataProgram;
    NSMutableArray *dataProgramID;
    UIAlertView *loading;
    NSMutableArray *MemberInfo;
    NSMutableURLRequest *request;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet SimplePickerInputTableViewCell2 *txtProgramName;
@end

@implementation addExViewController
@synthesize receivedData;

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    dataProgram = [[NSMutableArray alloc]init];
    dataProgramID = [[NSMutableArray alloc]init];
    
    [dataProgram addObject:@"-"];
    [dataProgramID addObject:@""];
    [dataProgram addObject:@"New"];
    [dataProgramID addObject:@""];
    
    [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnRep.highlighted = YES; }];
    [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnTime.highlighted = YES; }];
    
    //self.txtProgramName.delegate =self;
    //self.txtProgramName.values = dataProgram;
    //[self.tableView reloadData];
}
- (IBAction)selectType:(id)sender {
    
    btnRep.highlighted = NO;
    btnTime.highlighted = NO;
    
    if(sender == btnRep)[NSOperationQueue.mainQueue addOperationWithBlock:^{strType = @"By Rep"; btnTime.highlighted = YES; }];
    else [NSOperationQueue.mainQueue addOperationWithBlock:^{strType = @"By Time"; btnRep.highlighted = YES; }];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for(NSDictionary *x in [prefs objectForKey:@"Program"])
    {
        NSLog(@"%@",x);
        if([[x valueForKey:@"type"] isEqualToString:strType])
        {
            [dataProgram addObject:[x valueForKey:@"name"]];
            [dataProgramID addObject:[x valueForKey:@"id"]];
        }
        
    }
    
    self.txtProgramName.values = dataProgram;
    [self.tableView reloadData];
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

@end
