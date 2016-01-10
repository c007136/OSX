//
//  Test.m
//  GetterAndSetter
//
//  Created by miniu on 15/12/19.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import "Test.h"

@interface Test ()

@end

@implementation Test

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cString = @"edf";
        NSLog(@"string is %@", self.cString);
    }
    return self;
}


// 同时写setter and getter函数，系统自动生成_cString这个变量
// _cString可任意n
@synthesize cString = _cString;

- (NSString *)cString
{
    if (nil == _cString) {
        _cString = @"abc";
    }
    return _cString;
}

- (void)setCString:(NSString *)cString
{
    _cString = cString;
}

@end
