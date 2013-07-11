//
//  XYViewController.m
//  Sections
//
//  Created by Xia Yong on 13-7-12.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 加载属性文件，初始化names字典
    // key为A-Z
    self.names = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"]];
    // 将names字典的所有的key排序作为keys
    self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.keys count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // key = [self.keys objectAtIndex:section] 根据分区索引获取A-Z
    // array = [self.names objectForKey:key] 根据A-Z获取单个分区列表
    return [[self.names objectForKey:[self.keys objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *SectionsTableIdentifier = @"SectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SectionsTableIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SectionsTableIdentifier];
    NSString *key = [self.keys objectAtIndex:[indexPath section]];
    NSArray *nameSction = [self.names objectForKey:key];
    cell.textLabel.text = [nameSction objectAtIndex:[indexPath row]];
    
    return cell;
}

// UITableView对象询问自己的数据源对象，指定分区的标题显示什么
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.keys objectAtIndex:section];
}

// UITableView对象询问自己的数据源对象，分区索引显示什么
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}


@end
