//
//  XYCheckMarkRecognizer.m
//  CheckPlease
//
//  Created by Xia Yong on 13-12-11.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYCheckMarkRecognizer.h"
#import "CGPointUtils.h"
// 只有导入UIGestureRecognizerSubclass.h才可以readwrite手势识别器的state属性
#import <UIKit/UIGestureRecognizerSubclass.h>

// 转弯最小角度
#define kMinimumCheckMarkAngle      50
// 转弯最大角度
#define kMaximumCheckMarkAngle      135
// 足够的最小滑动距离
#define kMinimumCheckmarkLength     50

@implementation XYCheckMarkRecognizer

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    CGPoint point = [[touches anyObject] locationInView:self.view];
    self.lastPreviousPoint = point;
    self.lastCurrentPoint = point;
    self.lineLengthSoFar = 0.0f;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint previousPoint = [touch previousLocationInView:self.view];
    CGPoint currentPoint = [touch locationInView:self.view];
    // angleBetweenLines函数用于计算两条线条之间的角度， 前两个点组成了第一条线，后两个点组成了第二条线。
    CGFloat angle = angleBetweenLines(self.lastPreviousPoint, self.lastCurrentPoint, previousPoint, currentPoint);
    // 检查角度是否落入了可接受范围，并确认用户的手指在急转弯之前滑动了足够的距离
    if (angle >= kMinimumCheckMarkAngle && angle <= kMaximumCheckMarkAngle && self.lineLengthSoFar > kMinimumCheckmarkLength)
        self.state = UIGestureRecognizerStateEnded;
    // 计算触摸的位置与其前一个位置之间的距离
    self.lineLengthSoFar += distanceBetweenPoints(previousPoint, currentPoint);
    self.lastPreviousPoint = previousPoint;
    self.lastCurrentPoint = currentPoint;
}

@end
