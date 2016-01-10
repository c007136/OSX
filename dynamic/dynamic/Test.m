//
//  Test.m
//  dynamic
//
//  Created by miniu on 15/12/23.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import "Test.h"
#import <objc/runtime.h>

@interface Test ()

@property (copy, nonatomic) NSString         * cString;

@end


void dynamicMethodIMP(id _self, SEL _cmd)
{
    NSLog(@"cmd is %@", NSStringFromSelector(_cmd));
}

void dynamicMethodIMP1(id _self, SEL _cmd)
{
    NSLog(@"cmd is %@", NSStringFromSelector(_cmd));
}

@implementation Test


@dynamic cString;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cString = @"abc";
        //NSLog(@"cString is %@", self.cString);
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"sel is %@", NSStringFromSelector(sel));
    
    if (sel == @selector(setCString:)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

@end
