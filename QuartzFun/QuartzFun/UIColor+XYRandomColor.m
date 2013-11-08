//
//  UIColor+XYRandomColor.m
//  QuartzFun
//
//  Created by Xia Yong on 13-11-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "UIColor+XYRandomColor.h"

@implementation UIColor (XYRandomColor)
+ (UIColor *)randomColor {
    static BOOL sended = NO;
    if (!sended) {
        sended = YES;
        srandom(time(NULL));
    }
    CGFloat red = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random() / (CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random() / (CGFloat)RAND_MAX;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}
@end
