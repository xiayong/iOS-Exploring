//
//  XYQuartzFunView.m
//  QuartzFun
//
//  Created by Xia Yong on 13-11-5.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYQuartzFunView.h"
#import "UIColor+XYRandomColor.h"

@implementation XYQuartzFunView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.currentColor = [UIColor redColor];
        self.useRandomColor = NO;
        self.drawImage = [UIImage imageNamed:@"iphone.png"];
    }
    
    return self;
}

#pragma mark - Touch Handling
// 当用户的手指第一次触摸屏幕时视图控制器会向自己的视图对象发送此消息
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.useRandomColor) {
        self.currentColor = [UIColor randomColor];
    }
    UITouch *touch = [touches anyObject];
    self.firstTouch = [touch locationInView:self];
    self.lastTouch = [touch locationInView:self];
    self.redrawRect = CGRectMake(self.firstTouch.x, self.firstTouch.y, self.lastTouch.x - self.firstTouch.x, self.lastTouch.y - self.firstTouch.y);
    [self setNeedsDisplayInRect:self.redrawRect];
}
// 当用户在屏幕上拖动手指时视图控制器会向自己的视图对象连续发送此消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    self.lastTouch = [touch locationInView:self];
    if (self.shapeType == kImageShape)
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouch.x - self.drawImage.size.width / 2, self.lastTouch.y - self.drawImage.size.height / 2, self.drawImage.size.width, self.drawImage.size.height));
    self.redrawRect = CGRectUnion(self.redrawRect, self.currentRect);
    [self setNeedsDisplayInRect:self.redrawRect];
    
    //[self setNeedsDisplay];
}
// 当用户将手指从屏幕上抬起时视图控制器会向自己的视图对象发送此消息
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //[self touchesMoved:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    self.lastTouch = [touch locationInView:self];
    if (self.shapeType == kImageShape)
        self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouch.x - self.drawImage.size.width / 2, self.lastTouch.y - self.drawImage.size.height / 2, self.drawImage.size.width, self.drawImage.size.height));
    else
        self.redrawRect = CGRectUnion(self.redrawRect, self.currentRect);
    //self.redrawRect = CGRectInset(self.redrawRect, -2.0, -2.0);
    [self setNeedsDisplayInRect:self.redrawRect];
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    // 检索当前上下问
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);
    // 设置线条宽度
    CGContextSetLineWidth(context, 2.0);
    // 设置填充颜色
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);
    // 计算要画的矩形范围
    //CGRect currentRect = CGRectMake(self.firstTouch.x, self.firstTouch.y, self.lastTouch.x - self.firstTouch.x, self.lastTouch.y - self.firstTouch.y);
    
    switch (self.shapeType) {
        case kLineShape:
            // 移动到起点
            CGContextMoveToPoint(context, self.firstTouch.x, self.firstTouch.y);
            // 设置终点
            CGContextAddLineToPoint(context, self.lastTouch.x, self.lastTouch.y);
            // 画出这条线
            CGContextStrokePath(context);
            break;
        case kRectShape:
            // 画一个矩形
            CGContextAddRect(context, self.currentRect);
            // 使用填充的方式画出这个矩形
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kEllipseShape:
            // 画一个椭圆形
            CGContextAddEllipseInRect(context, self.currentRect);
            // 使用填充的方式画出这个椭圆形
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        case kImageShape: {
            // 计算图像的位置
            CGPoint drawPoint = CGPointMake(self.lastTouch.x - self.drawImage.size.width / 2, self.lastTouch.y - self.drawImage.size.height / 2);
            // 告诉图像绘制自己
            [self.drawImage drawAtPoint:drawPoint];
            break;
        }
        default:
            break;
    }
}
-(CGRect)currentRect {
    return CGRectMake(self.firstTouch.x, self.firstTouch.y, self.lastTouch.x - self.firstTouch.x, self.lastTouch.y - self.firstTouch.y);
}

@end
