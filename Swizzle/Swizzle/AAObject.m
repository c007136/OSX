//
//  AAObject.m
//  Swizzle
//
//  Created by miniu on 16/5/5.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "AAObject.h"
#import "BObject.h"

@implementation AAObject

//+ (void)initialize
//{
//    NSLog(@"%@ %s", [self class], __FUNCTION__);
//    
//    BObject * b = [[BObject alloc] init];
//    [b objectMethod];
//}

+ (void)initialize
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

+ (void)load
{
    NSLog(@"%@ %s", [self class], __FUNCTION__);
}

@end
