//
//  RegisterIIViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/6/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "RegisterIIViewController.h"

@interface RegisterIIViewController ()
{
    UIAlertView *loading;
    NSMutableURLRequest *request;
}
@end

@implementation RegisterIIViewController
@synthesize txtUsername,txtPassword,txtName,txtEmail,txtGender,txtBirthday,txtWeight,txtHeight,receivedData;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    txtUsername.imageView.alpha = 0.3;
    txtUsername.textField.adjustsFontSizeToFitWidth = YES;
    txtUsername.textField.textColor = [UIColor blackColor];
    txtUsername.textField.placeholder = @"Username";
    txtUsername.textField.keyboardType = UIKeyboardTypeASCIICapable;
    txtUsername.textField.returnKeyType = UIReturnKeyDone;
    txtUsername.textField.backgroundColor = [UIColor whiteColor];
    txtUsername.textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    txtUsername.textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    txtUsername.textField.tag = 0;
    txtUsername.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    txtPassword.imageView.alpha = 0.3;
    txtPassword.textField.adjustsFontSizeToFitWidth = YES;
    txtPassword.textField.textColor = [UIColor blackColor];
    txtPassword.textField.placeholder = @"Password";
    txtPassword.textField.keyboardType = UIKeyboardTypeASCIICapable;
    txtPassword.textField.returnKeyType = UIReturnKeyDone;
    txtPassword.textField.backgroundColor = [UIColor whiteColor];
    txtPassword.textField.secureTextEntry = YES;
    txtPassword.textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    txtPassword.textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    txtPassword.textField.tag = 0;
    txtPassword.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    txtName.imageView.alpha = 0.3;
    txtName.textField.adjustsFontSizeToFitWidth = YES;
    txtName.textField.textColor = [UIColor blackColor];
    txtName.textField.placeholder = @"Name";
    txtName.textField.keyboardType = UIKeyboardTypeDefault;
    txtName.textField.returnKeyType = UIReturnKeyDone;
    txtName.textField.backgroundColor = [UIColor whiteColor];
    txtName.textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    txtName.textField.autocapitalizationType = UITextAutocapitalizationTypeWords; // no auto capitalization support
    txtName.textField.tag = 0;
    txtName.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    txtEmail.imageView.alpha = 0.3;
    txtEmail.textField.adjustsFontSizeToFitWidth = YES;
    txtEmail.textField.textColor = [UIColor blackColor];
    txtEmail.textField.placeholder = @"Email";
    txtEmail.textField.keyboardType = UIKeyboardTypeEmailAddress;
    txtEmail.textField.returnKeyType = UIReturnKeyDone;
    txtEmail.textField.backgroundColor = [UIColor whiteColor];
    txtEmail.textField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    txtEmail.textField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    txtEmail.textField.tag = 0;
    txtEmail.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    txtGender.imageView.alpha = 0.3;
    txtGender.values = [NSArray arrayWithObjects:@" - ",@" Male", @" Female", nil];
    txtBirthday.imageView.alpha = 0.3;
    [txtBirthday setMaxDate:[NSDate date]];
    
    
    txtWeight.imageView.alpha = 0.3;
    txtWeight.textField.placeholder = @"Weight (Kg)";
    txtWeight.textField.keyboardType = UIKeyboardTypeDecimalPad;
    txtWeight.textField.textColor = [UIColor blackColor];
    txtHeight.imageView.alpha = 0.3;
    txtHeight.textField.placeholder = @"Height (Cm)";
    txtHeight.textField.keyboardType = UIKeyboardTypeDecimalPad;
    txtHeight.textField.textColor = [UIColor blackColor];
    
}
- (IBAction)done:(id)sender {
    [self.view endEditing:YES];
    
    NSMutableArray *txt = [[NSMutableArray alloc]init];
    [txt addObject:txtUsername.textField];
    [txt addObject:txtPassword.textField];
    [txt addObject:txtName.textField];
    [txt addObject:txtEmail.textField];
    /*
    [txt addObject:txtGender];
    [txt addObject:txtBirthday];
     */
    [txt addObject:txtWeight.textField];
    [txt addObject:txtHeight.textField];

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
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@&name=%@&email=%@&gender=%@&birthday=%@&weight=%@&height=%@",txtUsername.textField.text, txtPassword.textField.text,txtName.textField.text,txtEmail.textField.text,txtGender.textLabel.text,txtBirthday.textLabel.text,txtWeight.textField.text,txtHeight.textField.text];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
    
    NSURL *url = [NSURL URLWithString:@"http://fitny.co.nf/php/register.php"];
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
    /*UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
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

@end
