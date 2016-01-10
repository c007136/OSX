//
//  main.m
//  Accessor
//
//  Created by miniu on 15/12/17.
//  Copyright © 2015年 muyu. All rights reserved.
//
//  https://developer.apple.com/library/tvos/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmPractical.html#//apple_ref/doc/uid/TP40004447-SW4
//  http://blog.smilexiaofeng.com/blog/2015/08/11/why-do-not-use-accessor-in-init-and-dealloc/
//  http://codingobjc.com/blog/2013/04/24/guan-yu-bu-yao-zai-inithe-deallocli-mian-shi-yong-accessor-de-wen-ti/

#import <Foundation/Foundation.h>
#import "IFather.h"
#import "DFather.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        IChild * ic = [[IChild alloc] init];
        
        DChild * dc = [[DChild alloc] init];
    }
    return 0;
}
