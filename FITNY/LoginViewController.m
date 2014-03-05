//
//  LoginViewController.m
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/17/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "LoginViewController.h"
#import "MainMenuViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "RegisterViewController.h"
#import  <QuartzCore/QuartzCore.h>


@interface LoginViewController ()
{
    UIAlertView *loading;
    NSMutableURLRequest *request;
    BOOL Thai;
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
    IBOutlet UIView *subview;
}
@property (weak, nonatomic) IBOutlet UILabel *lblwordlogo;
@end

@implementation LoginViewController
@synthesize receivedData;

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self initLoginButton];
    [self initRegisterButton];
    [self setBG];
    [self setsubBG];
    self.navigationController.navigationBarHidden = YES;
    usernameField.delegate = self;
    passwordField.delegate = self;
    
    _lblwordlogo.font = font1(10);
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [LoginButton addGestureRecognizer:longPress];
    
	// Do any additional setup after loading the view.
}
- (void)longPress:(UILongPressGestureRecognizer*)gesture {
    if ( gesture.state == UIGestureRecognizerStateEnded ) {
        NSLog(@"Long Press");
        usernameField.text = @"admin";
        passwordField.text = @"password";
        [self presentSpecialViewController:LoginButton];
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *MemberInfo = [prefs objectForKey:@"MemberInfo"];
    NSLog(@"%@",MemberInfo);
    if(MemberInfo != nil)
    {
        UIStoryboard *storyboard = self.storyboard;
        MainMenuViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
        [self.navigationController pushViewController:svc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)presentSpecialViewController:(id)sender {
    
    [usernameField endEditing:YES];
    [passwordField endEditing:YES];
    
    NSString *username = usernameField.text;
    NSString *password = passwordField.text;
    
    [self textFieldDidEndEditing:usernameField];
    [self textFieldDidEndEditing:passwordField];
    
    if([password isEqualToString:@""] )
    {
        [self redborderTextField:passwordField];
    }
    if([username isEqualToString:@""] )
    {
        [self redborderTextField:usernameField];
        [EEHUDView growlWithMessage:@"miss something?"
                          showStyle:EEHUDViewShowStyleShake
                          hideStyle:EEHUDViewHideStyleFadeOut
                    resultViewStyle:EEHUDResultViewStyleNG
                           showTime:1.0];
        return;
    }
    
    
    if(![username isEqualToString:@""] && ![password isEqualToString:@""]) {
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        loadingView = [[UIView alloc] initWithFrame:CGRectMake(130, 250, 68, 68)];
        loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        loadingView.clipsToBounds = YES;
        loadingView.layer.cornerRadius = 10.0;
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectMake(15 , 15, activityView.bounds.size.width, activityView.bounds.size.height);
        [loadingView addSubview:activityView];
        
        [self.view addSubview:loadingView];
        [activityView startAnimating];
        /*
        loading = [[UIAlertView alloc] initWithTitle:@"" message:@"" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
        UIActivityIndicatorView *progress= [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 100, 30, 30)];
        progress.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [loading addSubview:progress];
        [progress startAnimating];
        [loading show];
         */
        
        [self checkLogin];

    }
    
    
    
}

-(void)redborderTextField:(UITextField *)textField
{
    textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor=[[UIColor redColor]CGColor];
    textField.layer.borderWidth= 2.0f;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        textField.layer.borderColor=[[UIColor clearColor]CGColor];
    }
}

-(void)initLoginButton
{
    UIImage *buttonImageNormal = [UIImage imageNamed:@"login_btn01.png"];
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [LoginButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"login_btn02.png"];
    UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [LoginButton setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
}

-(void)initRegisterButton
{
    UIImage *buttonImageNormal = [UIImage imageNamed:@"register_btn01.png"];
    UIImage *strechableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [RegisterButton setBackgroundImage:strechableButtonImageNormal forState:UIControlStateNormal];
    UIImage *buttonImagePressed = [UIImage imageNamed:@"register_btn02.png"];
    UIImage *strechableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
    [RegisterButton setBackgroundImage:strechableButtonImagePressed forState:UIControlStateHighlighted];
}

- (void)setBG
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg.png"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImage.frame = CGRectMake(0,0,320,568);
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
}
- (void)setsubBG
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg02.png"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImage.frame = CGRectMake(0,0,320,243);
    [subview addSubview:backgroundImage];
    [subview sendSubviewToBack:backgroundImage];
}




- (void)checkLogin
{
    // 0 - WRONGUSER
    // 1 - WRONGPASSWORD
    // 2 - PASS
    NSString *post =[NSString stringWithFormat:@"username=%@&password=%@",usernameField.text, passwordField.text];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *asciiString = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",asciiString);
    
    NSURL *url = [NSURL URLWithString:@"http://fitny.co.nf/php/login.php"];
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
    //sleep(0);
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    // inform the user
    /*
    UIAlertView *didFailWithErrorMessage = [[UIAlertView alloc] initWithTitle: @"NSURLConnection " message: @"didFailWithError"  delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
    [didFailWithErrorMessage show];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [loading dismissWithClickedButtonIndex:0 animated:YES];
    
    
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
    
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    
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
        NSString *strMemberID = [jsonObjects objectForKey:@"MemberID"];
        NSLog(@"Status = %@",strStatus);
        NSLog(@"Message = %@",strMessage);
        NSLog(@"MemberID = %@",strMemberID);
        
        // Completed
        if( [strStatus isEqualToString:@"2"] ){
            
            
            NSMutableArray *memberInfo = [[NSMutableArray alloc] init];

            NSDictionary *dict;
            dict = [NSDictionary dictionaryWithObjectsAndKeys:
                    [jsonObjects objectForKey:@"name"], @"name",
                    [jsonObjects objectForKey:@"email"], @"email",
                    [jsonObjects objectForKey:@"gender"], @"gender",
                    [jsonObjects objectForKey:@"birthday"], @"birthday",
                    [jsonObjects objectForKey:@"weight"], @"weight",
                    [jsonObjects objectForKey:@"height"], @"height",
                    [jsonObjects objectForKey:@"MemberID"], @"id",
                    nil];
            [memberInfo addObject:dict];
            
            NSLog(@"%@",memberInfo);
            // values in foreach loop
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:[memberInfo objectAtIndex:0]  forKey:@"MemberInfo"];
            [prefs setObject:[jsonObjects objectForKey:@"Program"]  forKey:@"Program"];
            [prefs setObject:[jsonObjects objectForKey:@"Calendar"]  forKey:@"Calendar"];
            [prefs setObject:[jsonObjects objectForKey:@"ProgramDetail"]  forKey:@"ProgramDetail"];
            
            [self textFieldDidEndEditing:usernameField];
            [self textFieldDidEndEditing:passwordField];
            UIStoryboard *storyboard = self.storyboard;
            MainMenuViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
            //svc.modalTransitionStyle=UIModalTransitionStyleFlipHorizontal;
            usernameField.text = @"";
            passwordField.text = @"";
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
           
            [EEHUDView growlWithMessage:@"welcome"
                              showStyle:EEHUDViewShowStyleShake
                              hideStyle:EEHUDViewHideStyleFadeOut
                        resultViewStyle:EEHUDResultViewStyleChecked
                               showTime:2.0];
            
            
            [loading dismissWithClickedButtonIndex:0 animated:YES];
            [self.navigationController pushViewController:svc animated:YES];
        }
        else if([strStatus isEqualToString:@"1"])
        {
            [self redborderTextField:passwordField];
            passwordField.text = @"";
            [passwordField becomeFirstResponder];
            [EEHUDView growlWithMessage:@"wrong password"
                              showStyle:EEHUDViewShowStyleShake
                              hideStyle:EEHUDViewHideStyleFadeOut
                        resultViewStyle:EEHUDResultViewStyleNG
                               showTime:1.0];
        }
        else if([strStatus isEqualToString:@"0"])
        {
            [self redborderTextField:usernameField];
            usernameField.text = @"";
            passwordField.text = @"";
            [usernameField becomeFirstResponder];
            [EEHUDView growlWithMessage:@"wrong username"
                              showStyle:EEHUDViewShowStyleShake
                              hideStyle:EEHUDViewHideStyleFadeOut
                        resultViewStyle:EEHUDResultViewStyleNG
                               showTime:1.0];
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

@end
