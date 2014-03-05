//
//  ExerciseTableViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 11/26/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "ExerciseTableViewController.h"
//#import "ExerciseViewController.h"
#import "ExerciseTabBarController.h"

@interface ExerciseTableViewController ()
{

    NSMutableArray *stretching;
    NSMutableArray *withWeights;
    NSMutableArray *withoutWeights;
}
@end

@implementation ExerciseTableViewController
@synthesize  muscle;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.tabBarController.tabBar.hidden = NO;
    self.navigationItem.title = muscle;
    NSString *path = [[NSBundle mainBundle] pathForResource:muscle ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    stretching = [[NSMutableArray alloc] init];
    withWeights = [[NSMutableArray alloc] init];
    withoutWeights = [[NSMutableArray alloc] init];
    int i = 0;
    for (NSString *dataDict in [dict objectForKey:@"ExerciseID"]) {
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                [[dict objectForKey:@"ExerciseID"] objectAtIndex:i], @"ExerciseID",
                [[dict objectForKey:@"ExerciseName"] objectAtIndex:i], @"ExerciseName",
                [[dict objectForKey:@"ExerciseType"] objectAtIndex:i ], @"ExerciseType",
                nil];
        NSRange match1 = [[temp valueForKey:@"ExerciseID"] rangeOfString: @"S"];
        if( match1.location ==2 ) [stretching addObject:temp];
        NSRange match2 = [[temp valueForKey:@"ExerciseID"] rangeOfString: @"W"];
        if( match2.location ==2 ) [withWeights addObject:temp];
        NSRange match3 = [[temp valueForKey:@"ExerciseID"] rangeOfString: @"N"];
        if( match3.location ==2 ) [withoutWeights addObject:temp];
        
        i++;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated

{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.translucent = YES;
    [self.tabBarController.tabBar setHidden:NO];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0) return [stretching count];
    else if(section == 1) return [withWeights count];
    else return [withoutWeights count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSManagedObject *exerciseInfo;
    if(indexPath.section == 0) exerciseInfo = [stretching objectAtIndex:indexPath.row];
    else if (indexPath.section == 1) exerciseInfo = [withWeights objectAtIndex:indexPath.row];
    else exerciseInfo = [withoutWeights objectAtIndex:indexPath.row];

    // Display recipe in the table cell
    
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:111];
    
    imageView.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[exerciseInfo valueForKey:@"ExerciseName"]]];
    
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:222];
    nameLabel.text = [exerciseInfo valueForKey:@"ExerciseName"];
    nameLabel.adjustsFontSizeToFitWidth = YES;
    UILabel *idLabel = (UILabel *)[cell viewWithTag:999];
    idLabel.text = [exerciseInfo valueForKey:@"ExerciseID"];
    
    UILabel *typeLabel = (UILabel *)[cell viewWithTag:333];
    typeLabel.text = [[NSString alloc] initWithFormat:@"Muscle : %@",[exerciseInfo valueForKey:@"ExerciseType"]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSManagedObject *exerciseInfo;
    if(indexPath.section == 0) exerciseInfo = [stretching objectAtIndex:indexPath.row];
    else if (indexPath.section == 1) exerciseInfo = [withWeights objectAtIndex:indexPath.row];
    else exerciseInfo = [withoutWeights objectAtIndex:indexPath.row];
    
    ExerciseTabBarController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"exercise"];
    svc.exerciseInfo = exerciseInfo;
    [self.navigationController pushViewController:svc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionName;
    switch (section)
    {
        case 0:
            if(!([stretching count] ==0)) sectionName = NSLocalizedString(@"Stretching", @"Stretching");
            break;
        case 1:
            if(!([withWeights count] ==0)) sectionName = NSLocalizedString(@"With Equipments", @"With Equipments");
            break;
        case 2:
            if(!([withoutWeights count] ==0)) sectionName = NSLocalizedString(@"Without Equipments", @"Without Equipments");
            break;
            // ...
        default:
            sectionName = @"";
            break;
    }
    return sectionName;
}

@end
