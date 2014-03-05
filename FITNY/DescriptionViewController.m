//
//  DescriptionViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/20/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()

@end

@implementation DescriptionViewController

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
    self.navigationController.navigationBar.translucent = YES;
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSManagedObject *exerciseInfo = [prefs objectForKey:@"exerciseInfo"];
    NSString *txtFilePath = [[NSBundle mainBundle] pathForResource: [exerciseInfo valueForKey:@"ExerciseName"] ofType: @"txt"];
    NSString *txtFileContents = [NSString stringWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:nil];
    
    _descriptionTxt.contentInset = UIEdgeInsetsMake(-70.0,0.0,0,0.0);
    _descriptionTxt.text = txtFileContents;
    self.imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[exerciseInfo valueForKey:@"ExerciseName"]]];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self setupSwipeGestureRecognizer];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupSwipeGestureRecognizer {
    UISwipeGestureRecognizer *gestureRecognizerswipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)];
    [gestureRecognizerswipeRight setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:gestureRecognizerswipeRight];
    
    UISwipeGestureRecognizer *gestureRecognizerswipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    [gestureRecognizerswipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:gestureRecognizerswipeLeft];
}
- (void)swipeRight:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"Right");
    NSInteger index = [self.tabBarController selectedIndex];
    NSLog(@"%i",index);
    if (index > 0) {
        NSLog(@"%i",index-1);
        [self.tabBarController setSelectedIndex:index-1];
    }
    
}
- (void)swipeLeft:(UISwipeGestureRecognizer*)gesture
{
    NSLog(@"Left");
    NSInteger index = [self.tabBarController selectedIndex];
    NSLog(@"%i",index);
    if (index < 2) {
        NSLog(@"%i",index+1);
        [self.tabBarController setSelectedIndex:index+1];
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}
@end
