//
//  Test.m
//  dynamic
//
//  Created by miniu on 15/12/23.
//  Copyright © 2015年 muyu. All rights reserved.
//
//  参考链接：
//  https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtDynamicResolution.html#//apple_ref/doc/uid/TP40008048-CH102-SW1
//  http://blog.ibireme.com/2013/11/26/objective-c-messaging/

#import "Test.h"
#import <objc/runtime.h>

@interface Test ()

@property (copy, nonatomic) NSString         * cString;

@end


void dynamicMethodIMP(id _self, SEL _cmd)
{
    NSLog(@"cmd is %@ in 0", NSStringFromSelector(_cmd));
}

void dynamicMethodIMP1(id _self, SEL _cmd)
{
    NSLog(@"cmd is %@ in 1", NSStringFromSelector(_cmd));
}

@implementation Test


@dynamic cString;
//@synthesize cString = _cString;

- (instancetype)init
{
    self = [super init];
    if (self) {
        // property可以
        self.cString = @"abc";
        
        // 这种情况不允许
        //[self testDynamic];
        
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"sel is %@", NSStringFromSelector(sel));
    
    if (sel == @selector(setCString:)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP, "v@:");
    } else if (sel == @selector(testDynamic)) {
        class_addMethod([self class], sel, (IMP)dynamicMethodIMP1, "v@:");
    }
    
    return [super resolveInstanceMethod:sel];
}

//- (void)testDynamic
//{
//    NSLog(@"testDynamic is called");
//}

//- (void)setCString:(NSString *)cString
//{
//    NSLog(@"setCString is called");
//}

@end
