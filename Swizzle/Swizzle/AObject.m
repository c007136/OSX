//
//  AObject.m
//  Swizzle
//
//  Created by miniu on 16/5/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "AObject.h"
#import "NSArray+Swizzle.h"

@implementation AObject

- (void)fun
{
    NSArray * array = @[@"0", @"1", @"2"];
    NSString * string = [array lastObject];
    NSLog(@"string is %@", string);
}

+ (void)initialize
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

//+ (void)load
//{
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//}

@end
