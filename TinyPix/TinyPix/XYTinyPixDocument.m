//
//  XYTinyPixDocument.m
//  TinyPix
//
//  Created by Xia Yong on 13-8-21.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYTinyPixDocument.h"

@interface XYTinyPixDocument()

@property (strong, nonatomic) NSMutableData *bitMap;

@end

@implementation XYTinyPixDocument

- (id)initWithFileURL:(NSURL *)url {
    self = [super initWithFileURL:url];
    if (self) {
        unsigned char startPattern[] = {
            0x01,
            0x02,
            0x04,
            0x08,
            0x10,
            0x20,
            0x40,
            0x80,
        };
        self.bitMap = [NSMutableData dataWithBytes:startPattern length:8];
    }
    return self;
}

- (BOOL)stateAtRow:(NSUInteger)row column:(NSUInteger)column {
    const char *bitMapBytes = [_bitMap bytes];
    char rowByte = bitMapBytes[row];
    char result = (1 << column) & rowByte;
    return result != 0;
}

-  (void)setState:(BOOL)state atRow:(NSUInteger)row column:(NSUInteger)column {
    char *bitMapByte = [_bitMap mutableBytes];
    char *rowByte = &bitMapByte[row];
    *rowByte = state ? *rowByte | (1 << column) : *rowByte & ~(1 << column);
}

- (void)toggleStateAtRow:(NSUInteger)row column:(NSUInteger)column {
    [self setState:! [self stateAtRow:row column:column] atRow:row column:column];
}

- (id)contentsForType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"saving document to URL %@", self.fileURL);
    return [self.bitMap copy];
}

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError *__autoreleasing *)outError {
    NSLog(@"loading document fro URL %@", self.fileURL);
    self.bitMap = [contents mutableCopy];
    return YES;
}

@end
