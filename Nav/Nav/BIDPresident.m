//
//  XYPresident.m
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import "BIDPresident.h"

@implementation BIDPresident

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInt:self.number forKey:kPresidentNumberKey];
    [coder encodeObject:self.name forKey:kPresidentNameKey];
    [coder encodeObject:self.fromYear forKey:kPresidentFromKey];
    [coder encodeObject:self.toYear forKey:kPresidentToKey];
    [coder encodeObject:self.party forKey:kPresidentPartyKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.number = [decoder decodeIntForKey:kPresidentNumberKey];
        self.name = [decoder decodeObjectForKey:kPresidentNameKey];
        self.fromYear = [decoder decodeObjectForKey:kPresidentFromKey];
        self.toYear = [decoder decodeObjectForKey:kPresidentToKey];
        self.party = [decoder decodeObjectForKey:kPresidentPartyKey];
    }
    return self;
}

@end
