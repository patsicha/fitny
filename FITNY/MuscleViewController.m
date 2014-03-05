//
//  MuscleViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/20/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "MuscleViewController.h"

@interface MuscleViewController ()

@end

@implementation MuscleViewController

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
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSManagedObject *exerciseInfo = [prefs objectForKey:@"exerciseInfo"];
    _imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.png",[exerciseInfo valueForKey:@"ExerciseType"]]];
    _lbl.text =[exerciseInfo valueForKey:@"ExerciseType"];
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
