//
//  main.m
//  KeyedArchiver
//
//  Created by miniu on 16/3/18.
//  Copyright © 2016年 muyu. All rights reserved.
//
//  使用NSKeyedArchiver可以归档和恢复NSString、NSArray、NSDictionary、NSSet、NSDate、NSNumber和NSData等基本的Foundation对象
//
//  参考链接：
//  http://blog.csdn.net/jymn_chen/article/details/18893939

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool
    {
        NSString * string = @"hello world";
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:string];
        NSLog(@"data is %@", data);
    }
    return 0;
}
