//
//  MyClass.m
//  Block
//
//  Created by miniu on 16/3/10.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "MyClass.h"

NSObject      * __globalObject = nil;

@implementation MyClass

- (id)init
{
    self = [super init];
    if (self) {
        _instanceObject = [[NSObject alloc] init];
    }
    return self;
}

- (void)test
{
    static NSObject * __staticObject = nil;
    __globalObject = [[NSObject alloc] init];
    __staticObject = [[NSObject alloc] init];
    
    NSObject * localObject = [[NSObject alloc] init];
    __block NSObject * blockObject = [[NSObject alloc] init];
    
    typedef void (^MyBlock)(void);
    MyBlock aBlock = ^{
        NSLog(@"global object : %@", __globalObject);
        NSLog(@"static object : %@", __staticObject);
        NSLog(@"instance object : %@", _instanceObject);
        NSLog(@"local object : %@", localObject);
        NSLog(@"block object : %@", blockObject);
    };
    aBlock = [[aBlock copy] autorelease];
    aBlock();
    
    NSLog(@"global object : %ld", [__globalObject retainCount]);
    NSLog(@"static object : %ld", [__staticObject retainCount]);
    NSLog(@"instance object : %ld", [_instanceObject retainCount]);
    NSLog(@"local object : %ld", [localObject retainCount]);
    NSLog(@"block object : %ld", [blockObject retainCount]);
    NSLog(@"self : %ld", [self retainCount]);   // 等于2，因为_instanceObject
}

@end
