//
//  ProgramViewController.m
//  FITNY
//
//  Created by Patsicha Tongteeka on 12/7/2556 BE.
//  Copyright (c) 2556 Patsicha Tongteeka. All rights reserved.
//

#import "ProgramViewController.h"
#import "ProgramDetailViewController.h"

@interface ProgramViewController ()
{
    NSMutableArray *dataProgram;
}
@end

@implementation ProgramViewController
@synthesize receivedData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    self.navigationController.navigationBar.translucent = NO;
    dataProgram = [[NSMutableArray alloc]init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    dataProgram = [[prefs objectForKey:@"Program"] mutableCopy];
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]); // see all NSUserDefaults
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [dataProgram count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSManagedObject *programInfo;
    programInfo = [dataProgram objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [programInfo valueForKey:@"name"];
    cell.detailTextLabel.text = [programInfo valueForKey:@"type"];
    // Configure the cell...
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        //[dataProgramDetail deleteObject:[food_Core objectAtIndex:indexPath.row]];
        
        
        // Remove device from table view
        [dataProgram removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:dataProgram forKey:@"Program"];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *programInfo;
    programInfo = [dataProgram objectAtIndex:indexPath.row];
    ProgramDetailViewController *svc = [self.storyboard instantiateViewControllerWithIdentifier:@"ProgramDetail"];
    svc.pid = [programInfo valueForKey:@"id"];
    svc.pname = [programInfo valueForKey:@"name"];
    svc.ptype = [programInfo valueForKey:@"type"];
    [self.tabBarController.navigationController pushViewController:svc animated:YES];
}
@end
