//
//  main.m
//  CycleRetain
//
//  Created by miniu on 16/3/11.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Friend.h"

int main(int argc, const char * argv[])
{
    Friend * f = [[Friend alloc] init];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [f release];
    });
    NSLog(@"main is done");
//    @autoreleasepool
//    {
//        Friend * f = [[Friend alloc] init];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [f release];
//        });
//    }
    return 0;
}
