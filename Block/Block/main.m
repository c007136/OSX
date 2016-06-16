//
//  main.m
//  Block
//
//  Created by miniu on 16/3/9.
//  Copyright © 2016年 muyu. All rights reserved.
//
//  block内存与循环引用
//  http://tanqisen.github.io/blog/2013/04/19/gcd-block-cycle-retain/
//  http://www.starfelix.com/blog/2014/10/19/ru-he-geng-an-quan-de-shi-yong-block/
//  http://ios.jobbole.com/81900/

#import <Foundation/Foundation.h>
#import "MyClass.h"

// block
typedef long (^BlkSum)(int, int);

int main(int argc, const char * argv[])
{
    // －－－－－－－－－－－内存类型－－－－－－－－－－－－－－－ //
    
//    // NSGlobalBlock
//    BlkSum block1 = ^long (int a, int b) {
//        return a + b;
//    };
//    NSLog(@"block1 = %@", block1);
//    
//    // NSStackBlock
//    // 在ARC下NSStackBlock类型的block会替换成NSMallocBlock类型
//    // 局部变量base会被copy到stack中
//    int base = 100;
//    BlkSum block2 = ^long (int a, int b) {
//        return base + a + b;
//    };
//    NSLog(@"block2 = %@", block2);
//
//    // NSMallocBlock
//    BlkSum block3 = [[block2 copy] autorelease];
//    NSLog(@"block3 = %@", block3);
    
    // －－－－－－－－－－－内存类型－－－－－－－－－－－－－－－ //
    
    MyClass * object = [[[MyClass alloc] init] autorelease];
    [object test];
    
    return 0;
}
