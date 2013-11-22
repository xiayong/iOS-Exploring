//
//  XYGLFunView.h
//  GLFun
//
//  Created by Xia Yong on 13-11-14.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYConstants.h"
#import "OpenGLES2DView.h"

@class Texture2D;

@interface XYGLFunView : OpenGLES2DView

@property CGPoint firstTouch;
@property CGPoint lastTouch;
@property (nonatomic, strong) UIColor *currentColor;
@property BOOL useRandomColor;
@property ShapeType shapeType;
@property (nonatomic, strong) Texture2D *sprite;

@end
