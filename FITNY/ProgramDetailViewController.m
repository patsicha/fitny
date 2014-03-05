//
//  ProgramDetailViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/8/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "ProgramDetailViewController.h"
#import "ExerciseTabBarController.h"
@interface ProgramDetailViewController ()
{
    UIAlertView *loading;
    NSMutableArray *dataProgramDetail;
    NSMutableArray *ExData;
    
}
@end

@implementation ProgramDetailViewController
@synthesize receivedData,pid,pname;
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
    [self loadExData];
    
    NSLog(@"%@",pid);
    self.title = pname;
    dataProgramDetail = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    for(NSDictionary *x in [prefs objectForKey:@"ProgramDetail"])
    {
        if([[x valueForKey:@"id"] isEqualToString:pid]) [dataProgramDetail addObject:x];
    }
    
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
    
    dataProgramDetail = [[NSMutableArray alloc]init];
    
    NSString *post =[NSString stringWithFormat:@"pid=%@",pid];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataProgramDetail count];
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
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:222];
    UILabel *idLabel = (UILabel *)[cell viewWithTag:999];
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:333];
    NSLog(@"%ld < %lu",(long)indexPath.row,(unsigned long)[dataProgramDetail count]);

    NSManagedObject *programInfo;
    programInfo = [dataProgramDetail objectAtIndex:indexPath.row];
    
    NSUInteger idx = [[ExData valueForKey:@"ExerciseID"] indexOfObject:[programInfo valueForKey:@"exerciseID"]];
    NSLog(@"%lu",(unsigned long)idx );
    NSManagedObject *exInfo = [ExData objectAtIndex:idx];
    
    imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[exInfo valueForKey:@"ExerciseName"]]];
    
    nameLabel.text = [exInfo valueForKey:@"ExerciseName"];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    idLabel.text = [exInfo valueForKey:@"ExerciseID"];
    
    
    typeLabel.text = [programInfo valueForKey:@"amount"];
    
    //cell.textLabel.text = [exInfo valueForKey:@"ExerciseName"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *programInfo;
    programInfo = [dataProgramDetail objectAtIndex:indexPath.row];
    
    NSUInteger idx = [[ExData valueForKey:@"ExerciseID"] indexOfObject:[programInfo valueForKey:@"exerciseID"]];
    NSLog(@"%lu",(unsigned long)idx );
    NSManagedObject *exInfo = [ExData objectAtIndex:idx];
    
    ExerciseTabBarController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"exercise"];
    svc.exerciseInfo = exInfo;
    svc.btnAdd = YES;
    [self.navigationController pushViewController:svc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;

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
    self.navigationController.navigationBar.translucent = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = TRUE;
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    
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
            [dataProgramDetail removeObjectAtIndex:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
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
