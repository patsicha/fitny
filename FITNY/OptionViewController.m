//
//  OptionViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/25/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "OptionViewController.h"
#import "UIViewController+MJPopupViewController.h"

@interface OptionViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
{
    IBOutlet UITextField *txtRestTime;
    IBOutlet UITextField *txtReadyTime;
    NSMutableArray *pickerHr;
    NSMutableArray *pickerMin;
    NSMutableArray *pickerSec;
    NSInteger restTimeMinPicker_index;
    NSInteger restTimeSecPicker_index;
    NSInteger readyTimeMinPicker_index;
    NSInteger readyTimeSecPicker_index;
    UIPickerView *restTimePicker;
    UIPickerView *readyTimePicker;
    
    UILabel *rest_minlabel;
    UILabel *rest_seclabel;
    
    UILabel *ready_minlabel;
    UILabel *ready_seclabel;
    
}
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
    
    restTimePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    restTimePicker.delegate = self;
    restTimePicker.dataSource = self;
    [restTimePicker setShowsSelectionIndicator:YES];
    txtRestTime.inputView = restTimePicker;
    
    readyTimePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    readyTimePicker.delegate = self;
    readyTimePicker.dataSource = self;
    [readyTimePicker setShowsSelectionIndicator:YES];
    txtReadyTime.inputView = readyTimePicker;
    
    txtRestTime.text = @"0:15";
    txtReadyTime.text = @"0:05";
    
    pickerHr = [[NSMutableArray alloc]init];
    pickerMin = [[NSMutableArray alloc]init];
    pickerSec = [[NSMutableArray alloc]init];
    
    restTimeMinPicker_index=0;
    restTimeSecPicker_index=15;
    
    readyTimeMinPicker_index=0;
    readyTimeSecPicker_index=5;
    
    for (int i = 0; i<60; i++) {
        
        [pickerHr addObject:[[NSString alloc] initWithFormat:@"%02d",i]];
        [pickerMin addObject:[[NSString alloc] initWithFormat:@"%d",i]];
        [pickerSec addObject:[[NSString alloc] initWithFormat:@"%02d",i]];
    }
    
    [restTimePicker selectRow:15 inComponent:1 animated:YES];
    [readyTimePicker selectRow:5 inComponent:1 animated:YES];
    
    rest_minlabel = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 83.5, 100, 50.0)];
    [rest_minlabel setText:@"Minute"];
    [rest_minlabel setFont:[UIFont systemFontOfSize:13]];
    [rest_minlabel setBackgroundColor:[UIColor clearColor]];
    [restTimePicker addSubview:rest_minlabel];
    rest_seclabel = [[UILabel alloc] initWithFrame:CGRectMake(263.0, 83.5, 100, 50.0)];
    [rest_seclabel setText:@"Seconds"];
    [rest_seclabel setFont:[UIFont systemFontOfSize:13]];
    [rest_seclabel setBackgroundColor:[UIColor clearColor]];
    [restTimePicker addSubview:rest_seclabel];
    
    ready_minlabel = [[UILabel alloc] initWithFrame:CGRectMake(95.0, 83.5, 100, 50.0)];
    [ready_minlabel setText:@"Minute"];
    [ready_minlabel setFont:[UIFont systemFontOfSize:13]];
    [ready_minlabel setBackgroundColor:[UIColor clearColor]];
    [readyTimePicker addSubview:ready_minlabel];
    ready_seclabel = [[UILabel alloc] initWithFrame:CGRectMake(263.0, 83.5, 100, 50.0)];
    [ready_seclabel setText:@"Seconds"];
    [ready_seclabel setFont:[UIFont systemFontOfSize:13]];
    [ready_seclabel setBackgroundColor:[UIColor clearColor]];
    [readyTimePicker addSubview:ready_seclabel];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if(component == 0)
        return pickerMin.count;
    else
        return pickerSec.count;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if(component == 0)
        return [pickerMin objectAtIndex:row];
    else
        return [pickerSec objectAtIndex:row];
}

- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView == restTimePicker) {
        if(component == 0) {
            restTimeMinPicker_index = row;
            if(row < 2) [rest_minlabel setText:@"Minute"];
            else [rest_minlabel setText:@"Minutes"];
        }
        else {
            restTimeSecPicker_index = row;
            if(row < 2) [rest_seclabel setText:@"Second"];
            else [rest_seclabel setText:@"Seconds"];
        }
        
        txtRestTime.text = [[NSString alloc] initWithFormat:@"%@:%@",[pickerMin objectAtIndex:restTimeMinPicker_index],[pickerSec objectAtIndex:restTimeSecPicker_index]];
    }
    
    if (pickerView == readyTimePicker) {
        if(component == 0) {
            readyTimeMinPicker_index = row;
            if(row < 2) [ready_minlabel setText:@"Minute"];
            else [ready_minlabel setText:@"Minutes"];
        }
        else {
            readyTimeSecPicker_index = row;
            if(row < 2) [ready_seclabel setText:@"Second"];
            else [ready_seclabel setText:@"Seconds"];
        }
        txtReadyTime.text = [[NSString alloc] initWithFormat:@"%@:%@",[pickerMin objectAtIndex:readyTimeMinPicker_index],[pickerSec objectAtIndex:readyTimeSecPicker_index]];
    }
    
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];// this will do the trick
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
