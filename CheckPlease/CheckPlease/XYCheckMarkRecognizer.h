//
//  XYCheckMarkRecognizer.h
//  CheckPlease
//
//  Created by Xia Yong on 13-12-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYCheckMarkRecognizer : UIGestureRecognizer
@property (assign, nonatomic) CGPoint lastPreviousPoint;
@property (assign, nonatomic) CGPoint lastCurrentPoint;
@property (assign, nonatomic) CGFloat lineLengthSoFar;
@end
