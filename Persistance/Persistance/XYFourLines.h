//
//  XYFourLines.h
//  Persistance
//
//  Created by Xia Yong on 13-8-13.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kField1Key      @"Field1"
#define kField2Key      @"Field2"
#define kField3Key      @"Field3"
#define kField4Key      @"Field4"

@interface XYFourLines : NSObject <NSCoding, NSCopying>

@property (copy, nonatomic) NSString *field1;
@property (copy, nonatomic) NSString *field2;
@property (copy, nonatomic) NSString *field3;
@property (copy, nonatomic) NSString *field4;

@end
