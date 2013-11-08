//
//  XYConstants.h
//  QuartzFun
//
//  Created by Xia Yong on 13-11-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

// #ifndef 这条编译指令的目的是先检查QuartzFun_XYConstants_h是否已经定义了，如果没有定义，才定义它
#ifndef QuartzFun_XYConstants_h
#define QuartzFun_XYConstants_h
typedef enum {
    kLineShape = 0,
    kRectShape,
    kEllipseShape,
    kImageShape
} ShapeType;

typedef enum {
    kRedColorTab = 0,
    kBlueColorTab,
    kYellowColorTab,
    kGreenColorTab,
    kRandomColorTab
} ColorTabIndex;

#define degreesToRandian(x) (M_PI * (x) /180)

#endif