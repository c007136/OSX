//
//  NSArray+Swizzle.m
//  Swizzle
//
//  Created by miniu on 16/5/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "NSArray+Swizzle.h"
#import <objc/runtime.h>

@implementation NSArray (Swizzle)

+ (void)load
{
    Method ori_method = class_getInstanceMethod([NSArray class], @selector(lastObject));
    Method my_method = class_getInstanceMethod([NSArray class], @selector(myLastObject));
    method_exchangeImplementations(ori_method, my_method);
}

- (id)myLastObject
{
    id ret = [self myLastObject];
    NSLog(@"my last object ........");
    return ret;
}


@end
