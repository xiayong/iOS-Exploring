//
//  XYTinyPixView.h
//  TinyPix
//
//  Created by Xia Yong on 13-8-25.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYTinyPixDocument.h"

@interface XYTinyPixView : UIView

@property (strong, nonatomic) XYTinyPixDocument *document;
@property (strong, nonatomic) UIColor *highlightColorl;

@end
