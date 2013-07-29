//
//  XYTaskListController.m
//  Simple Storyboards
//
//  Created by Xia Yong on 13-7-29.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYTaskListController.h"

@interface XYTaskListController ()

@end

@implementation XYTaskListController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tasks = [NSArray arrayWithObjects:@"Walk the dog", @"URGENT: Buy milk", @"Clean hidden lair", @"Invent miniature dolphines", @"Find new henchmen", @"Get revenge on do-gooder heroes", @"URGENT: Fold laundry", @"Hold entire wolrd hostage", @"Manicure", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = nil;
    NSString *task = [self.tasks objectAtIndex:[indexPath row]];
    NSRange range = [task rangeOfString:@"URGENT"];
    if (range.location == NSNotFound)
        cellIdentifier = @"plainCell";
    else
        cellIdentifier = @"attentionCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Configure the cell...
    
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    
    cellLabel.text = task;
    
    return cell;
}

@end
