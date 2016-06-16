//
//  Friend.m
//  CycleRetain
//
//  Created by miniu on 16/3/11.
//  Copyright © 2016年 muyu. All rights reserved.
//
//
//  http://www.cnblogs.com/wengzilin/p/4347974.html

#import "Friend.h"

@interface Friend ()

@property (strong, nonatomic) NSTimer             * timer;

@end

@implementation Friend

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFire) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)timeFire
{
    NSLog(@"%@ say: Hi!", [self class]);
}

- (void)cleanTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc
{
    [self cleanTimer];
    NSLog(@"fried is dealloc");
}

@end
