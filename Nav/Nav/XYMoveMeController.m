//
//  XYMoveMeController.m
//  Nav
//
//  Created by Xia Yong on 13-7-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYMoveMeController.h"

@interface XYMoveMeController ()

@end

@implementation XYMoveMeController

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
    
    if (self.list == nil)
        self.list = [[NSMutableArray alloc] initWithObjects:@"Eeny", @"Meeny", @"Miney", @"Mo", @"Catch", @"A", @"Tiger", @"By", @"The", @"Toe", nil];
    // 指定导航栏右侧按钮， 并为此按钮设置样式和被单击时调用的方法.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Move" style:UIBarButtonItemStyleBordered target:self action:@selector(toggleMove)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleMove {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    if (self.tableView.editing)
        self.navigationItem.rightBarButtonItem.title = @"Done";
    else
        self.navigationItem.rightBarButtonItem.title = @"Move";
}

#pragma mark - Table View Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MoveMeCellIdentifier = @"MoveMeCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MoveMeCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MoveMeCellIdentifier];
        // 启动重新排序控件
        cell.showsReorderControl = YES;
    }
    cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
    
    return cell;
}
// UITableView对象询问自己的数据源对象，表单元的编辑模式的样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // 所有的行的可以移动
    return YES;
}
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSUInteger sourceRow = [sourceIndexPath row];
    // 将要移除的对象取出
    id object = [self.list objectAtIndex:sourceRow];
    [self.list removeObjectAtIndex:sourceRow];
    [self.list insertObject:object atIndex:[destinationIndexPath row]];
}
@end
