//
//  RegisterViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/13/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UITextField *txtUsername;
    UITextField *txtPassword;
    UITextField *txtName;
    UITextField *txtEmail;
    UITextField *txtGender;
    UITextField *txtBirthday;
    UITextField *txtWeight;
    UITextField *txtHeight;
    UIAlertView *loading;
    UIDatePicker *picker;
    BOOL transform;
}

@end

@implementation RegisterViewController
@synthesize receivedData;

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
    
    txtUsername.delegate =self;
    txtPassword.delegate =self;
    txtName.delegate =self;
    txtEmail.delegate =self;
    txtGender.delegate =self;
    txtBirthday.delegate =self;
    txtWeight.delegate =self;
    txtHeight.delegate =self;
    transform =NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 500, 0, 250)];
    
    picker.datePickerMode = UIDatePickerModeDate;
    picker.date = [NSDate date];
    [picker addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
    picker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:picker];
}
- (void)changeDateInLabel:(id)sender{
    
    //Use NSDateFormatter to write out the date in a friendly format
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init]; df.dateStyle = NSDateFormatterMediumStyle;
    
    txtBirthday.text = [NSString stringWithFormat:@"%@", [df stringFromDate:picker.date]];

    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    if(section == 0) return 2;
    else return 6;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:@"Cell"] ;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if ([indexPath section] == 0) {
            
            if ([indexPath row] == 0) {
                txtUsername = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtUsername.adjustsFontSizeToFitWidth = YES;
                txtUsername.textColor = [UIColor blackColor];
                txtUsername.placeholder = @"Username";
                txtUsername.keyboardType = UIKeyboardTypeDefault;
                txtUsername.returnKeyType = UIReturnKeyNext;
                txtUsername.backgroundColor = [UIColor whiteColor];
                txtUsername.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                txtUsername.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
                txtUsername.tag = 0;
                txtUsername.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
                [txtUsername setEnabled: YES];
                [cell.contentView addSubview:txtUsername];
                cell.imageView.image = [UIImage imageNamed:@"111-user.png"];
                cell.imageView.alpha = 0.3;
            }
            else {
                txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtPassword.adjustsFontSizeToFitWidth = YES;
                txtPassword.textColor = [UIColor blackColor];
                txtPassword.placeholder = @"Password";
                txtPassword.keyboardType = UIKeyboardTypeDefault;
                txtPassword.returnKeyType = UIReturnKeyDone;
                txtPassword.secureTextEntry = YES;
                txtPassword.backgroundColor = [UIColor whiteColor];
                txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
                txtPassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtPassword.tag = 0;
                txtPassword.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtPassword setEnabled: YES];
                [cell.contentView addSubview:txtPassword];
                cell.imageView.image = [UIImage imageNamed:@"54-lock.png"];
                cell.imageView.alpha = 0.3;
            }
        }
        if ([indexPath section] == 1) {
            
            if ([indexPath row] == 0) {
                txtName = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtName.adjustsFontSizeToFitWidth = YES;
                txtName.textColor = [UIColor blackColor];
                txtName.placeholder = @"Name";
                txtName.keyboardType = UIKeyboardTypeDefault;
                txtName.returnKeyType = UIReturnKeyNext;
                txtName.backgroundColor = [UIColor whiteColor];
                txtName.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
                txtName.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
                txtName.tag = 0;
                txtName.clearButtonMode = UITextFieldViewModeWhileEditing; // no clear 'x' button to the right
                [txtName setEnabled: YES];
                [cell.contentView addSubview:txtName];
                cell.imageView.image = [UIImage imageNamed:@"123-id-card.png"];
                cell.imageView.alpha = 0.3;
            }
            else if ([indexPath row] == 1) {
                txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtEmail.adjustsFontSizeToFitWidth = YES;
                txtEmail.textColor = [UIColor blackColor];
                txtEmail.placeholder = @"Email";
                txtEmail.keyboardType = UIKeyboardTypeEmailAddress;
                txtEmail.returnKeyType = UIReturnKeyDone;
                txtEmail.backgroundColor = [UIColor whiteColor];
                txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
                txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtEmail.tag = 0;
                txtEmail.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtEmail setEnabled: YES];
                [cell.contentView addSubview:txtEmail];
                cell.imageView.image = [UIImage imageNamed:@"18-envelope.png"];
                cell.imageView.alpha = 0.3;
                
            }
            else if ([indexPath row] == 2) {
                txtGender = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtGender.adjustsFontSizeToFitWidth = YES;
                txtGender.textColor = [UIColor blackColor];
                txtGender.placeholder = @"Gender (Male/Female)";
                txtGender.keyboardType = UIKeyboardTypeDefault;
                txtGender.returnKeyType = UIReturnKeyDone;
                txtGender.backgroundColor = [UIColor whiteColor];
                txtGender.autocorrectionType = UITextAutocorrectionTypeNo;
                txtGender.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtGender.tag = 0;
                txtGender.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtGender setEnabled: YES];
                [cell.contentView addSubview:txtGender];
                cell.imageView.image = [UIImage imageNamed:@"76-baby.png"];
                cell.imageView.alpha = 0.3;
                
            }
            else if ([indexPath row] == 3) {
                txtBirthday = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtBirthday.adjustsFontSizeToFitWidth = YES;
                txtBirthday.textColor = [UIColor blackColor];
                txtBirthday.placeholder = @"Birthday (YYYY-MM-DD)";
                txtBirthday.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
                txtBirthday.backgroundColor = [UIColor whiteColor];
                txtBirthday.autocorrectionType = UITextAutocorrectionTypeNo;
                txtBirthday.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtBirthday.tag = 0;
                txtBirthday.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtBirthday setEnabled: YES];
                [cell.contentView addSubview:txtBirthday];
                cell.imageView.image = [UIImage imageNamed:@"24-gift.png"];
                cell.imageView.alpha = 0.3;
                //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                //cell.selectionStyle = UITableViewCellSelectionStyleDefault;

                
            }
            else if ([indexPath row] == 4) {
                txtWeight = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtWeight.adjustsFontSizeToFitWidth = YES;
                txtWeight.textColor = [UIColor blackColor];
                txtWeight.placeholder = @"Weight (Kg)";
                txtWeight.keyboardType = UIKeyboardTypeNumberPad;
                txtWeight.backgroundColor = [UIColor whiteColor];
                txtWeight.autocorrectionType = UITextAutocorrectionTypeNo;
                txtWeight.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtWeight.tag = 0;
                txtWeight.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtWeight setEnabled: YES];
                [cell.contentView addSubview:txtWeight];
                cell.imageView.image = [UIImage imageNamed:@"81-dashboard.png"];
                cell.imageView.alpha = 0.3;
            }
            else  {
                txtHeight = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 185, 30)];
                txtHeight.adjustsFontSizeToFitWidth = YES;
                txtHeight.textColor = [UIColor blackColor];
                txtHeight.placeholder = @"Height (Cm)";
                txtHeight.keyboardType = UIKeyboardTypeNumberPad;
                txtHeight.backgroundColor = [UIColor whiteColor];
                txtHeight.autocorrectionType = UITextAutocorrectionTypeNo;
                txtHeight.autocapitalizationType = UITextAutocapitalizationTypeNone;
                txtHeight.tag = 0;
                txtHeight.clearButtonMode = UITextFieldViewModeWhileEditing;
                [txtHeight setEnabled: YES];
                [cell.contentView addSubview:txtHeight];
                cell.imageView.image = [UIImage imageNamed:@"186-ruler.png"];
                cell.imageView.alpha = 0.3;
            }
        }
    }
    if ([indexPath section] == 1) { // Profile Section
        if ([indexPath row] == 0) {
            cell.textLabel.text = @"";
        }
        else {
            cell.textLabel.text = @"";
        }
    }
    else { // Login button section

    }
    return cell;    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName = NSLocalizedString(@"Account", @"Account");
            break;
        case 1:
            sectionName = NSLocalizedString(@"Profile", @"Profile");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if ( section ==0 ) return nil;
    //if ( section ==1 ) return @"By Clicking Done you are indicating that you have read and agree to the Privacy Policy and Term of Service.";
    
    return nil;
}
- (IBAction)done:(id)sender {
    [self.view endEditing:YES];
   
    NSMutableArray *txt = [[NSMutableArray alloc]init];
    [txt addObject:txtUsername];
    [txt addObject:txtPassword];
    [txt addObject:txtName];
    [txt addObject:txtEmail];
    [txt addObject:txtGender];
    [txt addObject:txtBirthday];
    [txt addObject:txtWeight];
    [txt addObject:txtHeight];
    
    for(UITextField *x in txt)
    {
        if([x.text isEqualToString:@""]) [self redborderTextField:x];
    }
    for(UITextField *x in txt)
    {
        if([x.text isEqualToString:@""]) return;
    }
    [self register_user];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    loading = [[UIAlertView alloc] initWithTitle:@"" message:@"Please Wait..." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 50, 30, 30)];
    progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    [loading addSubview:progress];
    [progress startAnimating];
    [loading show];
    

}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = FALSE;
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    [super viewWillDisappear:animated];
}
-(void)redborderTextField:(UITextField *)textField
{
    UIColor *color = [UIColor colorWithRed:1 green:0.729 blue:0.729 alpha:1];
    
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:textField.placeholder attributes:@{NSForegroundColorAttributeName: color}];
}

- (void)register_user
{
    // 0 - WRONGUSER
    // 1 - WRONGPASSWORD
    // 2 - PASS
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@&name=%@&email=%@&gender=%@&birthday=%@&weight=%@&height=%@",txtUsername.text, txtPassword.text,txtName.text,txtEmail.text,txtGender.text,txtBirthday.text,txtWeight.text,txtHeight.text];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
    
    NSURL *url = [NSURL URLWithString:@"http://fitny.co.nf/php/register.php"];
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
        NSString *strMessage = [jsonObjects objectForKey:@"Message"];
        NSLog(@"Status = %@",strStatus);
        NSLog(@"Message = %@",strMessage);
        
        // Completed
        if( [strStatus isEqualToString:@"1"] ){
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@"Registered !"
                                 message:strMessage delegate:self
                                 cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [error show];
            
        }
        else // Error
        {
            UIAlertView *error =[[UIAlertView alloc]
                                 initWithTitle:@": ( Error!"
                                 message:strMessage delegate:self
                                 cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [error show];
        }
        
    }
    
    // release the connection, and the data object
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Dismiss"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if(indexPath.section == 1 && indexPath.row == 3)
    {
        if(!transform){
        [txtBirthday setEnabled:YES];
        [txtBirthday becomeFirstResponder];
        
        [UIView beginAnimations:@"picker" context:nil];
        [UIView setAnimationDuration:0.5];
        picker.transform = CGAffineTransformMakeTranslation(0,-110);
        transform =YES;
        [UIView commitAnimations];
        [txtBirthday setEnabled:NO];
        }
    }
    else{
        [txtBirthday setEnabled:YES];
        [UIView beginAnimations:@"picker" context:nil];
        [UIView setAnimationDuration:0.5];
        [txtBirthday resignFirstResponder];
        picker.transform = CGAffineTransformMakeTranslation(0,110);
        transform =NO;
        
        [UIView commitAnimations];
        [txtBirthday setEnabled:NO];

    }
*/}
@end
