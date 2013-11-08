//
//  XYViewController.h
//  Sections
//
//  Created by Xia Yong on 13-7-12.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

- (IBAction)changeShape:(UISegmentedControl *)sender;
- (IBAction)changeColor:(UISegmentedControl *)sender;
//@property (strong, nonatomic) NSDictionary *names;
//@property (strong, nonatomic) NSArray *keys;

@property (strong, nonatomic) NSDictionary *allNames;
@property (strong, nonatomic) NSMutableDictionary *names;
@property (strong, nonatomic) NSMutableArray *keys;
@property (assign, nonatomic) BOOL isSearching;

@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) IBOutlet UISearchBar *search;

- (void) resetSearch;
- (void)handleSearchForTerm:(NSString *) searchIerm;

@end
