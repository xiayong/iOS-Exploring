//
//  XYMoveMeController.h
//  Nav
//
//  Created by Xia Yong on 13-7-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYSecondLevelController.h"

@interface XYMoveMeController : XYSecondLevelController

@property (strong, nonatomic) NSMutableArray *list;

- (IBAction)toggleMove;

@end
