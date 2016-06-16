//
//  CObject+Category.m
//  Swizzle
//
//  Created by miniu on 16/5/6.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "CObject+Category.h"

@implementation CObject (Category)

+ (void)initialize
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end
