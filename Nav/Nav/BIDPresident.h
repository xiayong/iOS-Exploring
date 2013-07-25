//
//  BIDPresident.h
//  Nav
//
//  Created by Xia Yong on 13-7-22.
//  Copyright (c) 2013年 Xia Yong. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kPresidentNumberKey     @"President"
#define kPresidentNameKey       @"Name"
#define kPresidentFromKey       @"FromYear"
#define kPresidentToKey         @"ToYear"
#define kPresidentPartyKey      @"Party"

@interface BIDPresident : NSObject <NSCoding>

@property int number;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *fromYear;
@property (copy, nonatomic) NSString *toYear;
@property (copy, nonatomic) NSString *party;

@end
