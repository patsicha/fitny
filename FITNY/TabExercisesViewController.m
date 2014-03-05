//
//  TabExercisesViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/14/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "TabExercisesViewController.h"

@interface TabExercisesViewController ()

@end

@implementation TabExercisesViewController

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
    self.navigationController.navigationBarHidden = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = FALSE;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = TRUE;
    self.tabBarController.tabBar.hidden = NO;
    
}



@end
