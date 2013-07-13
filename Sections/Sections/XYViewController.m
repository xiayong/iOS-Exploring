//
//  XYViewController.m
//  Sections
//
//  Created by Xia Yong on 13-7-12.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYViewController.h"
#import "NSDictionary+XYMutableDeepCopy.h"

@interface XYViewController ()

@end

@implementation XYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // 加载属性文件，初始化names字典
    // key为A-Z
    self.allNames = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sortednames" ofType:@"plist"]];
    // 将names字典的所有的key排序作为keys
    //self.keys = [[self.names allKeys] sortedArrayUsingSelector:@selector(compare:)];
    
    [self resetSearch];
    [self.table reloadData];
    [self.table setContentOffset:CGPointMake(0, 44) animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table View Data Source Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return [self.keys count];
    // 若没有数据(没有搜索到内容)，则只显示一个分区
    return [self.keys count] > 0 ? [self.keys count] : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // key = [self.keys objectAtIndex:section] 根据分区索引获取A-Z
    // array = [self.names objectForKey:key] 根据A-Z获取单个分区列表
    if ([self.keys count] == 0)
        return 0;
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

// UITableView对象询问自己的数据源对象，指定分区的头的标题显示什么
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.keys count] == 0)
        return nil;
    return [self.keys objectAtIndex:section];
}

// UITableView对象询问自己的数据源对象，分区索引标题显示什么
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keys;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.search resignFirstResponder];
    return indexPath;
}

#pragma mark -
#pragma mark Search Bar Delegate Methods
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self handleSearchForTerm:[self.search text]];
    [searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] == 0) {
        [self resetSearch];
        [self.table reloadData];
        return;
    }
    [self handleSearchForTerm:searchText];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [self resetSearch];
    [self.table reloadData];
    [searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark Custom Methods
- (void)resetSearch {
    // 复制所有的内容
    self.names = [self.allNames mutableDeepCopy];
    // 刷新所有的key，因为前一次搜索可能删除了某些key(整个分区被删除了)
    self.keys = [[NSMutableArray alloc] init];
    [self.keys addObjectsFromArray:[[self.allNames allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}

// 真正的搜索实现
- (void)handleSearchForTerm:(NSString *) searchIerm {
    [self resetSearch];
    NSMutableArray *sectionsToRemove = [[NSMutableArray alloc] init];
    for (NSString *key in self.keys) {
        NSMutableArray *array = [self.names valueForKey:key];
        NSMutableArray *toRemore = [[NSMutableArray alloc] init];
        for (NSString *name in array) {
            // 忽略大小写进行搜索，此方法返回一个NSRange
            if ([name rangeOfString:searchIerm options:NSCaseInsensitiveSearch].location == NSNotFound)
                [toRemore addObject:name];
        }
        // 若整个分区里面的所有内容都与要搜索的字符串不能匹配，则将整个分区删除
        if ([array count] == [toRemore count])
            [sectionsToRemove addObject:key];
        [array removeObjectsInArray:toRemore];
    }
    
    // 删除需要删除的分区
    [self.keys removeObjectsInArray:sectionsToRemove];
    [self.table reloadData];
}

@end
