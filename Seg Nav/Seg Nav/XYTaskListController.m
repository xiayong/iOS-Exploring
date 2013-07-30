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
    
    self.tasks = [NSMutableArray arrayWithObjects:@"Walk the dog", @"URGENT: Buy milk", @"Clean hidden lair", @"Invent miniature dolphines", @"Find new henchmen", @"Get revenge on do-gooder heroes", @"URGENT: Fold laundry", @"Hold entire wolrd hostage", @"Manicure", nil];
}

- (void)setEditedSelection:(NSDictionary *)editedSelection {
    if (! [editedSelection isEqual:self.editedSelection]) {
        // 获取子视图控制器回传的数据
        _editedSelection = editedSelection;
        NSIndexPath *indexPath = [editedSelection objectForKey:@"indexPath"];
        id newValue = [editedSelection objectForKey:@"object"];
        // 更新数据对象
        [self.tasks replaceObjectAtIndex:indexPath.row withObject:newValue];
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 获取即将显示的控制器
    UIViewController *destination = segue.destinationViewController;
    // 讲将要显示的子视图控制器的某个成员的引用指向自己，以便子视图可以回传值
    if ([destination respondsToSelector:@selector(setDelegate:)])
        [destination setValue:self forKey:@"delegate"];
    if ([destination respondsToSelector:@selector(setSelection:)]) {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        id object = [self.tasks objectAtIndex:indexPath.row];
        NSDictionary *selection = [NSDictionary dictionaryWithObjectsAndKeys:indexPath, @"indexPath", object, @"object", nil];
        [destination setValue:selection forKey:@"selection"];
    }
}

@end
