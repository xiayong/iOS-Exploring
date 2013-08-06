//
//  XYLanguageListController.h
//  Presidents
//
//  Created by Xia Yong on 13-8-7.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XYDetailViewController;

@interface XYLanguageListController : UITableViewController

@property (weak, nonatomic) XYDetailViewController *detailViewController;
@property (strong, nonatomic) NSArray *languageNames;
@property (strong, nonatomic) NSArray *languageCodes;

@end
