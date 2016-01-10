//
//  Father.m
//  Accessor
//
//  Created by miniu on 15/12/17.
//  Copyright © 2015年 muyu. All rights reserved.
//
//
//  http://blog.smilexiaofeng.com/blog/2015/08/11/why-do-not-use-accessor-in-init-and-dealloc/

#import "IFather.h"

@implementation IFather

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init in Father");
        
        // 会崩溃
        //self.fatherString = @"FatherString";
    }
    return self;
}

@end



//
//  Child
//
@implementation IChild

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"init in Child");
        self.childString = @"I am really ChildString";
        self.fatherString = @"ChildString";
    }
    return self;
}

- (void)setFatherString:(NSString *)fatherString
{
    [super setFatherString:fatherString];
    
    NSString * string = [NSString stringWithString:self.childString];
    NSLog(@"string in Child is %@", string);
}

@end