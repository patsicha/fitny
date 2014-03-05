//
//  ExerciseTabBarController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 2/20/2557 BE.
//  Copyright (c) 2557 Patsicha Tongteeka. All rights reserved.
//

#import "ExerciseTabBarController.h"
#import "addExerxiseViewController.h"
#import "addExViewController.h"

@interface ExerciseTabBarController ()
@property (weak, nonatomic) IBOutlet UITabBar *TabBar;

@end

@implementation ExerciseTabBarController
@synthesize exerciseInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_rbtnAdd setEnabled:!_btnAdd];
    
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = [exerciseInfo valueForKey:@"ExerciseName"];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:exerciseInfo  forKey:@"exerciseInfo"];
    if([[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"])
    {
        NSMutableArray *viewControllers = [NSMutableArray arrayWithArray:self.viewControllers];
        [viewControllers removeObjectAtIndex:1];
        [self setViewControllers:viewControllers];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAdd:(id)sender {
    /*if(![[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"]){
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Program Type"
                                                          message:nil
                                                         delegate:self
                                                cancelButtonTitle:@"Cancel"
                                                otherButtonTitles:@"By Rep", @"By Time", nil];
        [message show];
    }else{*/
        addExerxiseViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addExercise"];
        svc.exerciseInfo =exerciseInfo;
        //svc.ProgramType = @"By Time";
        svc.delegate = self;
        //[self.navigationController pushViewController:svc animated:YES];
        [self presentPopupViewController:svc animationType:MJPopupViewAnimationFade];
   // }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"By Rep"])
    {
        addExViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addEx"];
        svc.exerciseInfo =exerciseInfo;
        //svc.ProgramType = title;
        svc.delegate = self;
        //[self.navigationController pushViewController:svc animated:YES];
        [self presentPopupViewController:svc animationType:MJPopupViewAnimationSlideBottomTop];
    }
    else if([title isEqualToString:@"By Time"])
    {
        addExViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addEx"];
        svc.exerciseInfo =exerciseInfo;
        //svc.ProgramType = title;
        svc.delegate = self;
        //[self.navigationController pushViewController:svc animated:YES];
        [self presentPopupViewController:svc animationType:MJPopupViewAnimationSlideBottomTop];
    }
}


-(void)addSuccess:(addExerxiseViewController *)sv
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.navigationController popViewControllerAnimated:NO];
}

@end
