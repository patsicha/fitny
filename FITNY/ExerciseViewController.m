//
//  ExerciseViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/27/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "ExerciseViewController.h"
#import "addExerxiseViewController.h"

@interface ExerciseViewController ()
{
    MPMoviePlayerController *player;
}
@end

@implementation ExerciseViewController
@synthesize exerciseInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title = [exerciseInfo valueForKey:@"ExerciseName"];
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(0,0, self.navigationItem.titleView.frame.size.width, 40)];
    label.text=self.navigationItem.title;
    label.backgroundColor =[UIColor clearColor];
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView=label;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(![[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"]){
    return 4;
    }else{
        return 1;
    }
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIView *playerView = (UIView *)[cell viewWithTag:111];
    UIImageView *image = (UIImageView *)[cell viewWithTag:222];
    UITextView *desciption = (UITextView *)[cell viewWithTag:333];
    UIButton *add = (UIButton *)[cell viewWithTag:444];
    if(![[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"]){
    if(indexPath.row == 0)
    {
        add.hidden = YES;
        desciption.hidden = YES;
        image.hidden = YES;
        
        NSString *myURL = [[NSBundle mainBundle]
                           pathForResource:[exerciseInfo valueForKey:@"ExerciseName"]
                           ofType:@"mp4"];
        player =
        [[MPMoviePlayerController alloc] initWithContentURL: [NSURL fileURLWithPath:myURL]];
        [player prepareToPlay];
        //player.shouldAutoplay = NO;
        [player.view setFrame: playerView.bounds];  // player's frame must match parent's
        [playerView addSubview: player.view];
        player.backgroundView.backgroundColor = [UIColor whiteColor];
        player.repeatMode = MPMovieRepeatModeOne;
        player.scalingMode = MPMovieScalingModeAspectFit;
    }
    else if(indexPath.row == 1)
    {
        add.hidden = YES;
        desciption.hidden = YES;
        playerView.hidden = YES;
        NSString *temp = [[NSString alloc] initWithFormat:@"%@.gif",[exerciseInfo valueForKey:@"ExerciseType"]];
        image.image = [UIImage imageNamed:temp];
    }
    else if(indexPath.row == 2)
    {
        add.hidden = YES;
        playerView.hidden = YES;
        image.hidden = YES;
        NSString *txtFilePath = [[NSBundle mainBundle] pathForResource: [exerciseInfo valueForKey:@"ExerciseName"] ofType: @"txt"];
        NSString *txtFileContents = [NSString stringWithContentsOfFile:txtFilePath encoding:NSUTF8StringEncoding error:nil];
        
        desciption.text = txtFileContents;
    }
    else
    {
        cell.hidden =_btnAdd;
        desciption.hidden = YES;
        playerView.hidden = YES;
        image.hidden = YES;
        
    }}else{
        desciption.hidden = YES;
        playerView.hidden = YES;
        image.hidden = YES;
    }
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(![[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"]){
    if(indexPath.row == 3) return 50;
    else return 180;
    } else{
        return 50;
    }
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (![player isFullscreen]) {
        [player play];
    }
    
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.tabBarController.tabBar setHidden:NO];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (![player isFullscreen]) {
        [player stop];
    }
    
}
- (IBAction)btnAdd:(id)sender {
     if(![[exerciseInfo valueForKey:@"ExerciseType"] isEqualToString:@"Cardio"]){
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Program Type"
                                                      message:nil
                                                     delegate:self
                                            cancelButtonTitle:@"Cancel"
                                            otherButtonTitles:@"By Rep", @"By Time", nil];
    [message show];
     }else{
         addExerxiseViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addExercise"];
         svc.exerciseInfo =exerciseInfo;
         svc.ProgramType = @"By Time";
         [self.navigationController pushViewController:svc animated:YES];
     }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"By Rep"])
    {
        addExerxiseViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addExercise"];
        svc.exerciseInfo =exerciseInfo;
        svc.ProgramType = title;
        [self.navigationController pushViewController:svc animated:YES];
    }
    else if([title isEqualToString:@"By Time"])
    {
        addExerxiseViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"addExercise"];
        svc.exerciseInfo =exerciseInfo;
        svc.ProgramType = title;
        [self.navigationController pushViewController:svc animated:YES];
    }
}


@end
