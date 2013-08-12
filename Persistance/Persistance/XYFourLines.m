//
//  XYFourLines.m
//  Persistance
//
//  Created by Xia Yong on 13-8-13.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "XYFourLines.h"

@implementation XYFourLines

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_field1 forKey:kField1Key];
    [aCoder encodeObject:_field2 forKey:kField2Key];
    [aCoder encodeObject:_field3 forKey:kField3Key];
    [aCoder encodeObject:_field4 forKey:kField4Key];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _field1 = [aDecoder decodeObjectForKey:kField1Key];
        _field2 = [aDecoder decodeObjectForKey:kField2Key];
        _field3 = [aDecoder decodeObjectForKey:kField3Key];
        _field4 = [aDecoder decodeObjectForKey:kField4Key];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    XYFourLines *copy = [[[self class] allocWithZone:zone] init];
    copy.field1 = [self.field1 copyWithZone:zone];
    copy.field2 = [self.field2 copyWithZone:zone];
    copy.field3 = [self.field3 copyWithZone:zone];
    copy.field4 = [self.field4 copyWithZone:zone];
    
    return copy;
}

@end
