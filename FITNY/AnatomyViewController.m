//
//  AnatomyViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/26/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "AnatomyViewController.h"
#import "ExerciseTableViewController.h"

@interface AnatomyViewController ()
{
    BOOL choose;
    NSString *lastChoose;
}
@end

@implementation AnatomyViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //body.center = CGPointMake(168, 700);
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    txtChoose.alpha = 0;
    body.alpha = 0;
    btnAbs.alpha = 0;
    btnLeg.alpha = 0;
    btnFor.alpha = 0;
    btnLat.alpha = 0;
    btnLba.alpha = 0;
    btnSho.alpha = 0;
    btnMba.alpha = 0;
    btnTra.alpha = 0;
    btnTri.alpha = 0;
    btnBic.alpha = 0;
    btnChe.alpha = 0;
    
    scrollView.minimumZoomScale=1;
    scrollView.maximumZoomScale=2.0;
    
    //scrollView.contentSize=CGSizeMake(1280, 960);
    scrollView.delegate=self;
    
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return zoomView;
}


-(void)viewDidAppear:(BOOL)animated
{
    btnAbs.highlighted = NO;
    btnLeg.highlighted = NO;
    btnFor.highlighted = NO;
    btnLat.highlighted = NO;
    btnLba.highlighted = NO;
    btnSho.highlighted = NO;
    btnMba.highlighted = NO;
    btnTra.highlighted = NO;
    btnTri.highlighted = NO;
    btnBic.highlighted = NO;
    btnChe.highlighted = NO;
    lastChoose = @"";
    txtChoose.alpha = 0;
    // body.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    /*
    [UIView animateWithDuration:1.5 animations:^{
        body.alpha = 1;
        body.center = CGPointMake(168, 300);
        
    }];
     */
    //if(body.alpha == 0) body.center = CGPointMake(168, 700);
    [UIView beginAnimations:@"animation1" context:nil];
    [UIView setAnimationDuration:1];
    [UIView setAnimationDelegate:self];
    body.alpha = 0.6;
    //body.center = CGPointMake(168, 300);
    [UIView commitAnimations];
    
    
    

}
- (void)animationWillStart:(NSString *)animationID context:(void *)context{
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context{
    if([animationID isEqualToString:@"animation1"]){
        //Second Animation
        [UIView beginAnimations:@"animation2" context:nil];
        [UIView setAnimationDuration:1];
        [UIView setAnimationDelegate:self];
        body.alpha = 0.7;
        btnAbs.alpha = 1;
        btnLeg.alpha = 1;
        btnFor.alpha = 1;
        btnLat.alpha = 1;
        btnLba.alpha = 1;
        btnSho.alpha = 1;
        btnMba.alpha = 1;
        btnTra.alpha = 1;
        btnTri.alpha = 1;
        btnBic.alpha = 1;
        btnChe.alpha = 1;
        
        [UIView commitAnimations];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)selectedMuscle:(id)sender {
    
    btnAbs.highlighted = NO;
    btnLeg.highlighted = NO;
    btnFor.highlighted = NO;
    btnLat.highlighted = NO;
    btnLba.highlighted = NO;
    btnSho.highlighted = NO;
    btnMba.highlighted = NO;
    btnTra.highlighted = NO;
    btnTri.highlighted = NO;
    btnBic.highlighted = NO;
    btnChe.highlighted = NO;
    
    if(txtChoose.alpha == 0.5)
    {
        [UIView beginAnimations:@"ss" context:nil];
        [UIView setAnimationDuration:0.5];
        txtChoose.alpha = 0;
        [UIView commitAnimations];
    }
    
    
    NSString *muscle = @"";
    
    if(sender == btnAbs) // Abdominals
    {
        muscle = @"Abdominals";
    }
    else if(sender == btnBic ) // Biceps
    {
        muscle = @"Biceps";
    }
    else if(sender == btnChe) // Chest
    {
        muscle = @"Chest";
    }
    else if(sender == btnFor) // Forearms
    {
        muscle = @"Forearms";
    }
    else if(sender == btnLat) // Lats
    {
        muscle = @"Lats";
    }
    else if(sender == btnLba) // Lower Back
    {
        muscle = @"Lower Back";
    }
    else if(sender == btnLeg ) // Legs
    {
        muscle = @"Legs";
    }
    else if(sender == btnMba) // Middle Back
    {
        muscle = @"Middle Back";
    }
    else if(sender == btnSho) // Shoulders
    {
        muscle = @"Shoulders";
    }
    else if(sender == btnTra) // Traps
    {
        muscle = @"Traps";
    }
    else if(sender == btnTri) // Triceps
    {
        muscle = @"Triceps";
    }
    
    
    if([lastChoose isEqualToString:muscle]) {
        [UIView beginAnimations:@"animation3" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        scrollView.zoomScale = 1;
        
        [UIView commitAnimations];
        ExerciseTableViewController *svc = [[ExerciseTableViewController alloc]init];
        svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ExerciseTable"];
        svc.muscle = muscle;
        [self.navigationController pushViewController:svc animated:YES];
    }else {
        [UIView beginAnimations:@"ss" context:nil];
        [UIView setAnimationDuration:0.5];
        txtChoose.alpha = 0.5;
        [UIView commitAnimations];
        txtChoose.text = muscle;
        lastChoose = muscle;
        if(sender == btnAbs) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnAbs.highlighted = YES; }];
        else if(sender == btnBic) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnBic.highlighted = YES; }];
        else if(sender == btnChe) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnChe.highlighted = YES; }];
        else if(sender == btnFor) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnFor.highlighted = YES; }];
        else if(sender == btnLat) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnLat.highlighted = YES; }];
        else if(sender == btnLba) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnLba.highlighted = YES; }];
        else if(sender == btnLeg) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnLeg.highlighted = YES; }];
        else if(sender == btnMba) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnMba.highlighted = YES; }];
        else if(sender == btnSho) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnSho.highlighted = YES; }];
        else if(sender == btnTra) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnTra.highlighted = YES; }];
        else if(sender == btnTri) [NSOperationQueue.mainQueue addOperationWithBlock:^{ btnTri.highlighted = YES; }];
    }
}
@end
