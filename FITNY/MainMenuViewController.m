//
//  MainMenuViewController.m
//  SImple-Link
//
//  Created by Patsicha Tongteeka on 9/17/56 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "MainMenuViewController.h"
#import "LoginViewController.h"
#import "SocialViewController.h"
#import "OptionViewController.h"

@interface MainMenuViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lblwelcome;
@property (weak, nonatomic) IBOutlet UILabel *lbl0;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;

@end

@implementation MainMenuViewController
@synthesize Thai;

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
    [self setBG];
    [self initTxt];
}

-(void) initTxt
{
  //  _lblwelcome.font = fontthai(30);
   // titleLabel.font = fontthai(40);
   // weightLabel.font = fontthai(16);
   // heightLabel.font = fontthai(16);
   // _lbl0.font = fontthai(25);
   // _lbl1.font = fontthai(25);
   // _lbl2.font = fontthai(25);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *MemberInfo = [prefs objectForKey:@"MemberInfo"];
    titleLabel.text = [[NSString alloc] initWithFormat:@"%@",[MemberInfo valueForKey:@"name"]];
    if(!Thai) {
         _lblwelcome.text = @"Hello";
        _lbl0.text = @"TODAY'S WORKOUT";
        _lbl1.text = @"TRAINER";
        _lbl2.text = @"PROGRAM";
        weightLabel.text = [[NSString alloc] initWithFormat:@"Weight : %@ kg",[MemberInfo valueForKey:@"weight"]];
        heightLabel.text = [[NSString alloc] initWithFormat:@"Height : %@ cm",[MemberInfo valueForKey:@"height"]];
    }else{
        _lblwelcome.text = @"สวัสดี";
        _lbl0.text = @"ตารางฝึกวันนี้";
        _lbl1.text = @"ฝึกสอน";
        _lbl2.text = @"โปรแกรม";
        weightLabel.text = [[NSString alloc] initWithFormat:@"น้ำหนัก : %@ กก.",[MemberInfo valueForKey:@"weight"]];
        heightLabel.text = [[NSString alloc] initWithFormat:@"ส่วนสูง : %@ ซม.",[MemberInfo valueForKey:@"height"]];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setBG
{
    UIImageView *backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_page_bg"]];
    backgroundImage.contentMode = UIViewContentModeScaleAspectFit;
    backgroundImage.frame = CGRectMake(0,0,320,568);
    [self.view addSubview:backgroundImage];
    [self.view sendSubviewToBack:backgroundImage];
}



- (IBAction)presentSpecialViewController:(id)sender {
    
    
    OptionViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"Option"];
    svc.Thai = Thai;
    svc.delegate = self;
    [self presentPopupViewController:svc animationType:MJPopupViewAnimationFade];
    
    /*
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil  forKey:@"MemberInfo"];
    [self.navigationController popViewControllerAnimated:YES];
     */
    
    
}
- (void)cancelButtonClicked:(OptionViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil  forKey:@"MemberInfo"];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)changeLanguege:(BOOL)ss
{
    Thai = ss;
    [self initTxt];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    [super viewWillDisappear:animated];
}


@end
