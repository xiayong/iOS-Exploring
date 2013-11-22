//
//  XYGLFunView.m
//  GLFun
//
//  Created by Xia Yong on 13-11-14.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYGLFunView.h"
#import "UIColor+XYRandomColor.h"
#import "Texture2D.h"

@implementation XYGLFunView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.currentColor = [UIColor redColor];
        self.useRandomColor = NO;
        
        self.sprite = [[Texture2D alloc] initWithImage:[UIImage imageNamed:@"iphone.png"]];
        glBindTexture(GL_TEXTURE_2D, self.sprite.name);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
}
*/

- (void)draw {
    // Drawing code
    // 重置虚拟世界以便删除任何旋转、转换或已经用于它的其他变换
    glLoadIdentity();
    // 清除背景
    glClearColor(0.78f, 0.78f, 0.78f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);
    // 通过分隔UIColor并从中拖出各个RGB组件来设置OpenGL绘图颜色
    CGColorRef color = self.currentColor.CGColor;
    const CGFloat *componets = CGColorGetComponents(color);
    CGFloat red = componets[0];
    CGFloat green = componets[1];
    CGFloat blue = componets[2];
    glColor4f(red, green, blue, 1.0f);
    switch (self.shapeType) {
        case kLineShape: {
            // 关闭OpenGL ES映射纹理的功能
            glDisable(GL_TEXTURE_2D);
            // 定义描述我们需要绘制的直线的顶点数组
            GLfloat vertices[4];
            vertices[0] = self.firstTouch.x;
            vertices[1] = self.frame.size.height - self.firstTouch.y;
            vertices[2] = self.lastTouch.x;
            vertices[3] = self.frame.size.height - self.lastTouch.y;
            // 指定线宽
            glLineWidth(2.0);
            // 将顶点数组传递到OpenGL ES中
            glVertexPointer(2, GL_FLOAT, 0, vertices);
            // 通知OpenGL ES绘制数组
            glDrawArrays(GL_LINES, 0, 2);
            break;
        }
        case kRectShape: {
            glDisable(GL_TEXTURE_2D);
            GLfloat vertices[8];
            GLfloat minX = (self.firstTouch.x > self.lastTouch.x) ? self.lastTouch.x : self.firstTouch.x;
            GLfloat minY = (self.frame.size.height - self.firstTouch.y > self.frame.size.height - self.lastTouch.y) ? self.frame.size.height - self.lastTouch.y : self.frame.size.height - self.firstTouch.y;
            GLfloat maxX = (self.firstTouch.x > self.lastTouch.x) ? self.firstTouch.x : self.lastTouch.x;
            CGFloat maxY = (self.frame.size.height - self.firstTouch.y > self.frame.size.height - self.lastTouch.y) ? self.frame.size.height - self.firstTouch.y : self.frame.size.height - self.lastTouch.y;
            vertices[0] = maxX;
            vertices[1] = maxY;
            vertices[2] = minX;
            vertices[3] = maxY;
            vertices[4] = minX;
            vertices[5] = minY;
            vertices[6] = maxX;
            vertices[7] = minY;
            glVertexPointer(2, GL_FLAT, 0, vertices);
            glDrawArrays(GL_TRIANGLE_FAN, 0, 4);
            break;
        }
        case kEllipseShape: {
            glDisable(GL_TEXTURE_2D);
            // 使用360个点来定义一个椭圆
            GLfloat vertices[720];
            // 椭圆的水平半径
            GLfloat xradius = fabsf((self.firstTouch.x - self.lastTouch.x) / 2);
            // 椭圆的垂直半径
            GLfloat yradius = fabsf((self.firstTouch.y - self.lastTouch.y) / 2);
            // 围绕圆进行循环，计算围绕圆的正确的点
            for (int i = 0; i < 720; i += 2) {
                GLfloat xOffset = (self.firstTouch.x > self.lastTouch.x) ? self.lastTouch.x + xradius : self.firstTouch.x + xradius;
                GLfloat yOffset = (self.firstTouch.y < self.lastTouch.y) ? self.frame.size.height - self.lastTouch.y + yradius : self.frame.size.height - self.firstTouch.y + yradius;
                vertices[i] = cos(degreesToRandian(i / 2)) * xradius + xOffset;
                vertices[i+1] = sin(degreesToRandian(i / 2)) * yradius + yOffset;
            }
            glVertexPointer(2, GL_FLAT, 0, vertices);
            glDrawArrays(GL_TRIANGLE_FAN, 0, 360);
            break;
        }
        case kImageShape:
            glEnable(GL_TEXTURE_2D);
            [self.sprite drawAtPoint:CGPointMake(self.lastTouch.x, self.frame.size.height - self.lastTouch.y)];
            break;
        default:
            break;
    }
    // 在OpenGL ES中完成绘图之后，我们必须告诉它渲染其缓冲器
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
    // 告诉视图上下文显示新渲染的缓冲器
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.useRandomColor)
        self.currentColor = [UIColor randomColor];
    
    //UITouch *touch = [[event touchesForView:self] anyObject];
    UITouch *touch = [touches anyObject];
    self.firstTouch = [touch locationInView:self];
    self.lastTouch = [touch locationInView:self];
    
    [self draw];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //UITouch *touch = [[event touchesForView:self] anyObject];
    UITouch *touch = [touches anyObject];
    self.lastTouch = [touch locationInView:self];
    
    [self draw];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

@end
