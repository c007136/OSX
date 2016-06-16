//
//  BObject.m
//  Swizzle
//
//  Created by miniu on 16/5/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "BObject.h"

@implementation BObject

- (void)fun
{
    NSArray * array = @[@"0", @"1", @"2"];
    NSString * string = [array lastObject];
    NSLog(@"string is %@", string);
}

- (void)objectMethod
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)initialize
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)load
{
    //
    // 有[self class]则调用initialize
    // 没有则不调用
    // 这说明对load的调用不算第一个方法
    //
    
    NSLog(@"%s", __FUNCTION__);
    //NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end
