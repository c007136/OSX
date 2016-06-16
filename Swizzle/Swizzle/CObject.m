//
//  CObject.m
//  Swizzle
//
//  Created by miniu on 16/5/6.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "CObject.h"

@implementation CObject

+ (void)initialize
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

- (void)fun
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end
