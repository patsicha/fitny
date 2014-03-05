//
//  SocialViewController.m
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/18/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "SocialViewController.h"
#import "MainMenuViewController.h"

@interface SocialViewController ()

@end

@implementation SocialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self reloadTimeline];
    
}

-(void) reloadTimeline
{
    NSString *hostStr = @"http://fitny.site50.net/timeline4.php";
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: hostStr ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    serverOutput = [serverOutput stringByReplacingOccurrencesOfString: @"\\n" withString: @"\n"];
    timeline.text =serverOutput;
}
- (IBAction)post:(id)sender {
    
    NSString *post =[NSString stringWithFormat:@"username=%@&txt=%@",[self req_member_field:@"name"], input.text];
    NSString *hostStr = @"http://fitny.site50.net/posting1.php?";
    hostStr = [hostStr stringByAppendingString:post];
    NSLog(@"%@",hostStr);
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: hostStr ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    NSLog(@"%@",serverOutput);
    
    [input endEditing:YES];
    [self viewDidLoad];
    
    
}

- (NSTimer*)createTimer {
    
    // create timer on run loop
    return [NSTimer scheduledTimerWithTimeInterval:20.0 target:self selector:@selector(timerTicked:) userInfo:nil repeats:YES];
}
- (void)timerTicked:(NSTimer*)timer {
    [self viewDidLoad];
}
-(NSString*) req_member_field:(NSString *)field
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *Username = [prefs objectForKey:@"username"];
    NSString *post =[NSString stringWithFormat:@"username=%@&field=%@",Username,field];
    NSString *hostStr = @"http://fitny.site50.net/req_member.php?";
    hostStr = [hostStr stringByAppendingString:post];
    NSData *dataURL =  [NSData dataWithContentsOfURL: [ NSURL URLWithString: hostStr ]];
    NSString *serverOutput = [[NSString alloc] initWithData:dataURL encoding: NSASCIIStringEncoding];
    
    return serverOutput;
}
- (IBAction)back:(id)sender {
    UIStoryboard *storyboard = self.storyboard;
    MainMenuViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"MainMenu"];
    svc.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;
    [self presentViewController:svc animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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



@end
