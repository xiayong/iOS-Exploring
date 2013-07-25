//
//  XYPresidentsViewController.m
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYPresidentsViewController.h"
#import "XYPresidentDetailController.h"
#import "BIDPresident.h"

@interface XYPresidentsViewController ()

@end

@implementation XYPresidentsViewController

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Presidents" ofType:@"plist"];
    NSData *data;
    NSKeyedUnarchiver *unArchiver;
    // 从plist文件解压数据
    data = [[NSData alloc] initWithContentsOfFile:path];
    unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.list = [unArchiver decodeObjectForKey:@"Presidents"];
    [unArchiver finishDecoding];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *PresidentListCellIdentifier = @"PresidentListCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentListCellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PresidentListCellIdentifier];
    BIDPresident *president = [self.list objectAtIndex:[indexPath row]];
    cell.textLabel.text = president.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@", president.fromYear, president.toYear];
    return cell;
}

#pragma mark - Table View Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BIDPresident *president = [self.list objectAtIndex:[indexPath row]];
    XYPresidentDetailController *childController = [[XYPresidentDetailController alloc] initWithStyle:UITableViewStyleGrouped];
    childController.title = president.name;
    childController.president = president;
    [self.navigationController pushViewController:childController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
