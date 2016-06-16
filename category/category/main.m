//
//  main.m
//  category
//
//  Created by miniu on 16/3/15.
//  Copyright © 2016年 muyu. All rights reserved.
//
//  1.跟类或者父类的函数名冲突
//  2.跟静态库的category函数名冲突
//
//  http://www.jianshu.com/p/c98f216f5390

#import <Foundation/Foundation.h>
#import "NSObject+MainApp.h"


@interface NSObject (MyCategory)

- (void)sayHelloWorld;

@end

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
//        // 跟私有方法冲突
//        MyClass * obj = [[MyClass alloc] init];
//        [obj test];
        
        // 跟静态库的category函数名冲突 -- 未能实现
        NSObject * obj = [[NSObject alloc] init];
        [obj fun];
    }
    return 0;
}
