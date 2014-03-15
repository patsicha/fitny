//
//  CardioViewControllerII.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/8/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "CardioViewControllerII.h"
#import "ExerciseTabBarController.h"

@interface CardioViewControllerII ()
{
    NSMutableArray *cardioData;
}

@end

@implementation CardioViewControllerII

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
    self.tabBarController.tabBar.hidden = NO;
    
    cardioData = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cardio" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    int i = 0;
    for (NSString *dataDict in [dict objectForKey:@"ExerciseID"]) {
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[dict objectForKey:@"ExerciseID"] objectAtIndex:i], @"ExerciseID",
                              [[dict objectForKey:@"ExerciseName"] objectAtIndex:i], @"ExerciseName",
                              [[dict objectForKey:@"ExerciseType"] objectAtIndex:i], @"ExerciseType",
                              nil];
        [cardioData addObject:temp];
        i++;
    }
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    [self.tabBarController.tabBar setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cardioData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell3";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    
    NSManagedObject *exerciseInfo;
    exerciseInfo = [cardioData objectAtIndex:indexPath.row];
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:111];
    
    imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[exerciseInfo valueForKey:@"ExerciseName"]]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:222];
    nameLabel.text = [exerciseInfo valueForKey:@"ExerciseName"];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    UILabel *idLabel = (UILabel *)[cell viewWithTag:999];
    idLabel.text = [exerciseInfo valueForKey:@"ExerciseID"];
    
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:333];
    typeLabel.text = [exerciseInfo valueForKey:@"ExerciseType"];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *exerciseInfo;
    exerciseInfo = [cardioData objectAtIndex:indexPath.row];
    
    ExerciseTabBarController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"exercise"];
    svc.exerciseInfo = exerciseInfo;
    [self.tabBarController.navigationController pushViewController:svc animated:YES];
    
}

@end
