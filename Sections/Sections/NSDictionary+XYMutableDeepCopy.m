//
//  NSDictionary+XYMutableDeepCopy.m
//  Sections
//
//  Created by Xia Yong on 13-7-13.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "NSDictionary+XYMutableDeepCopy.h"

@implementation NSDictionary (XYMutableDeepCopy)

- (NSMutableDictionary *)mutableDeepCopy {
    NSMutableDictionary *returnDict = [[NSMutableDictionary alloc] initWithCapacity:[self count]];
    NSArray *keys = [self allKeys];
    for (id key in keys) {
        id value = [self valueForKey:key];
        id oneCopy = nil;
        if ([value respondsToSelector:@selector(mutableDeepCopy)])
            oneCopy = [value mutableDeepCopy];
        else if ([value respondsToSelector:@selector(mutableCopy)])
            oneCopy = [value mutableCopy];
        if (oneCopy == nil)
            oneCopy = [value copy];
        [returnDict setValue:oneCopy forKey:key];
    }
    
    return returnDict;
}

@end
