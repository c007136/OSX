//
//  DFather.m
//  Accessor
//
//  Created by miniu on 15/12/17.
//  Copyright © 2015年 muyu. All rights reserved.
//
//  dealloc的情形

#import "DFather.h"

@implementation DFather

- (void)dealloc
{
    NSLog(@"dealloc in DFather");
    
    // 会崩溃
    //self.info = nil;
}

@end



//
//  Child
//
@implementation DChild

- (id)init
{
    self = [super init];
    if (self) {
        _childInfo = @"ChildInfo";
    }
    return self;
}

- (void)setInfo:(NSString *)info
{
    NSString * string = [NSString stringWithString:self.childInfo];
    NSLog(@"%@", string);
}

- (void)dealloc
{
    NSLog(@"dealloc in DChild");
    _childInfo = nil;
}

@end
