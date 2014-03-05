//
//  VideoViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/22/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "VideoViewController.h"

@interface VideoViewController ()
{
    MPMoviePlayerController *player;
}
@end

@implementation VideoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBarController.delegate = self;
    [self setupSwipeGestureRecognizer];

}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSManagedObject *exerciseInfo = [prefs objectForKey:@"exerciseInfo"];
    NSString *myURL = [[NSBundle mainBundle]
                       pathForResource:[exerciseInfo valueForKey:@"ExerciseName"]
                       ofType:@"mp4"];
    
    player =
    [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:myURL]];
    [player prepareToPlay];
    //player.shouldAutoplay = NO;
    [player.view setFrame: self.playerView.bounds];  // player's frame must match parent's
    [self.playerView addSubview: player.view];
    player.repeatMode = MPMovieRepeatModeOne;
}

-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if(viewController != self)
    {
        [player stop];
        [player.view removeFromSuperview];
    }
        
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
        [player stop];
        [player.view removeFromSuperview];
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
