//
//  CardioViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/8/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "CardioViewController.h"

@interface CardioViewController ()
{
    NSMutableArray *cardioData;
}

@end

@implementation CardioViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    cardioData = [[NSMutableArray alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Cardio" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    int i = 0;
    for (NSString *dataDict in [dict objectForKey:@"ExerciseID"]) {
        NSDictionary *temp = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[dict objectForKey:@"ExerciseID"] objectAtIndex:i], @"ExerciseID",
                              [[dict objectForKey:@"ExerciseName"] objectAtIndex:i], @"ExerciseName",
                              nil];
        [cardioData addObject:temp];
        i++;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [cardioData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
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
    
    //UILabel *typeLabel = (UILabel *)[cell viewWithTag:333];
    //typeLabel.text = [[NSString alloc] initWithFormat:@"Muscle : %@",[exerciseInfo valueForKey:@"ExerciseType"]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 78;
}

@end
