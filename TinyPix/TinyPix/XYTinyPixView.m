//
//  XYTinyPixView.m
//  TinyPix
//
//  Created by Xia Yong on 13-8-25.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYTinyPixView.h"

typedef struct {
    NSInteger row;
    NSInteger column;
} GridIndex;

@interface XYTinyPixView()

// 每个方格的大小
@property (assign, nonatomic) CGSize blockSize;
// 每个方格的边距大小
@property (assign, nonatomic) CGSize gapSize;
// 选择的方块的位置
@property (assign, nonatomic) GridIndex selectedBlockIndex;

// 初始化属性
- (void)initProperties;
// 绘制方格
- (void)drawBlockAtRow:(NSInteger)row column:(NSInteger)column;
// 计算选择的方格的位置
- (GridIndex)touchedGridIndexFromTouches:(NSSet *)touches;
// 替换选择的方格的颜色
- (void)toggleSelectedBlock;

@end

@implementation XYTinyPixView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //NSLog(@"%f", frame.size.height);
        [self initProperties];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self)
        [self initProperties];
    return self;
}

- (void)initProperties {
    _blockSize = CGSizeMake(34, 34);
    _gapSize = CGSizeMake(5, 5);
    _selectedBlockIndex.row = NSNotFound;
    _selectedBlockIndex.column = NSNotFound;
    _highlightColorl = [UIColor blackColor];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (!self.document)
        return;
    for (NSInteger row = 0; row < 8; row++)
        for (NSInteger column = 0; column < 8; column++)
            [self drawBlockAtRow:row column:column];
}

- (void)drawBlockAtRow:(NSInteger)row column:(NSInteger)column {
    // 计算方格在屏幕中的坐标和大小
    CGFloat startX = (self.blockSize.width + self.gapSize.width) * column + 2;
    CGFloat startY = (self.blockSize.height + self.gapSize.height) * row + 2;
    CGRect blockFrame = CGRectMake(startX, startY, self.blockSize.width, self.blockSize.height);
    // 若某个方格应该是高亮显示，则使用高亮颜色来显示，否则使用白色显示
    UIColor *color = [self.document stateAtRow:row column:column] ? self.highlightColorl : [UIColor whiteColor];
    [color setFill];
    // 使用灰白色实线画边框
    [[UIColor lightGrayColor] setStroke];
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockFrame];
    [path fill];
    [path stroke];
}

- (GridIndex)touchedGridIndexFromTouches:(NSSet *)touches {
    GridIndex result;
    UITouch *touch = [touches anyObject];
    // 获取用户触摸屏幕的坐标
    CGPoint location = [touch locationInView:self];
    // 计算用户触摸的方格的位置
    result.column = location.x / (self.blockSize.width + self.gapSize.width);
    result.row = location.y / (self.blockSize.height + self.gapSize.height);
    return result;
}

- (void)toggleSelectedBlock {
    // 替换选择的方格的颜色
    [self.document toggleStateAtRow:self.selectedBlockIndex.row column:self.selectedBlockIndex.column];
    // 将self的toggleStateAtRow消息打包压入撤销栈，以便支持撤销操作
    // 使用document的undoManager注册一个可被撤销的操作，以便将该document对象标记为一个脏对象，并且确保稍后会被自动保存。
    [[self.document.undoManager prepareWithInvocationTarget:self.document] toggleStateAtRow:self.selectedBlockIndex.row column:self.selectedBlockIndex.column];
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selectedBlockIndex = [self touchedGridIndexFromTouches:touches];
    [self toggleSelectedBlock];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    GridIndex touched = [self touchedGridIndexFromTouches:touches];
    if (touched.row != self.selectedBlockIndex.row || touched.column != self.selectedBlockIndex.column) {
        self.selectedBlockIndex = touched;
        [self toggleSelectedBlock];
    }
}

@end
