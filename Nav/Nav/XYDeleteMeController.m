//
//  XYDeleteMeController.m
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYDeleteMeController.h"

@interface XYDeleteMeController ()

@end

@implementation XYDeleteMeController

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
    
    if (self.list == nil) {
        // 从属性文件初始化列表
        NSString *path = [[NSBundle mainBundle] pathForResource:@"computers" ofType:@"plist"];
        self.list = [[NSMutableArray alloc] initWithContentsOfFile:path];
    }
    // 初始化导航栏右边按钮，并问此按钮设置事件操作方法
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleEdit:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleEdit:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing)
        self.navigationItem.title = @"Done";
    else
        self.navigationItem.title = @"Delete";
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *DeleteMeCellIdentifier = @"DeleteMeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DeleteMeCellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DeleteMeCellIdentifier];
    cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
    
    return cell;
}

// 当用户完成一项编辑(删除或者插入)时,UITableView对象向自己的数据源对象发送此消息
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 删除列表中的响应要删除的内容
    [self.list removeObjectAtIndex:[indexPath row]];
    // 通知UITableView对象删除指定的行
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
