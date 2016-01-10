//
//  main.m
//  IMP
//
//  Created by miniu on 15/12/19.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        Test * t = [[Test alloc] init];
        
//        // 方法一
//        void (*FUN)(id, SEL, NSInteger);
//        FUN = (void (*)(id, SEL, NSInteger))[t methodForSelector:@selector(fun:)];
//        for (NSInteger i = 0; i < 10; i++) {
//            FUN(t, @selector(fun:), i);
//        }
        
        
        // 方法二
        // IMP就是函数指针
        // 不允许使用了
//        IMP imp = [t methodForSelector:@selector(fun:)];
//        for (NSInteger i = 0; i < 10; i++) {
//            imp();
//        }
        
        
        // 方法三
        // invocation
        SEL sel = @selector(fun:);
        NSMethodSignature * signature = [t methodSignatureForSelector:sel];
        NSInvocation * invocation = [NSInvocation invocationWithMethodSignature:signature];
        [invocation setTarget:t];
        [invocation setSelector:sel];
        for (NSInteger i = 0; i < 10; i++) {
            [invocation setArgument:&i atIndex:2];
            [invocation invoke];
        }
    }
    
    return 0;
}
