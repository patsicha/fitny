//
//  OptionViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/25/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "OptionViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface OptionViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *ET;
@property (weak, nonatomic) IBOutlet UILabel *lbl0;
@property (weak, nonatomic) IBOutlet UIButton *btn0;
@property (weak, nonatomic) IBOutlet UIButton *btn0_th;

@end

@implementation OptionViewController

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self initTxt];
}

-(void)initTxt
{
    if(!_Thai) {
        [_ET setSelectedSegmentIndex:0];
        _lbl0.text = @"     Language :";
        [_btn0 setHidden:NO];
        [_btn0_th setHidden:YES];
    }
    else {
        [_ET setSelectedSegmentIndex:1];
        _lbl0.text = @"ภาษาที่ใช้งาน :";
        [_btn0 setHidden:YES];
        [_btn0_th setHidden:NO];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logout:(id)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelButtonClicked:)]) {
        [self.delegate cancelButtonClicked:self];
    }
}
- (IBAction)sw:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if (selectedSegment == 0) {
        _Thai = NO;
        [prefs setObject:@"NO" forKey:@"Thai"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(changeLanguege:)]) {
            [self.delegate changeLanguege:NO];
        }
    }
    else{
        _Thai = YES;
        [prefs setObject:@"YES" forKey:@"Thai"];
        if (self.delegate && [self.delegate respondsToSelector:@selector(changeLanguege:)]) {
            [self.delegate changeLanguege:YES];
        }
    }
    [self initTxt];
    
}

@end
