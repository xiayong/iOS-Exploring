//
//  XYCheckListViewController.h
//  Nav
//
//  Created by Xia Yong on 13-7-17.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYSecondLevelController.h"

@interface XYCheckListViewController : XYSecondLevelController

@property (strong, nonatomic) NSArray *list;
@property (strong, nonatomic) NSIndexPath *lastIndexPath;

@end
