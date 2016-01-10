//
//  Property.m
//  NSString_Property
//
//  Created by miniu on 15/12/18.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import "Property.h"

@interface Property ()

@property (retain, nonatomic) NSString   * rString;
@property (copy, nonatomic) NSString     * cString;

@property (strong, nonatomic) NSObject   * sObject;
@property (weak, nonatomic) NSObject     * wObject;

@end

@implementation Property

- (void)test
{
    NSMutableString * mString = [NSMutableString stringWithFormat:@"abc"];
    
    self.rString = mString;
    self.cString = mString;        // 深拷贝
    
    NSLog(@"mString : %p, %p", mString, &mString);
    NSLog(@"rString : %p, %p", _rString, &_rString);
    NSLog(@"cString : %p, %p", _cString, &_cString);
    
    
    NSLog(@"rString before append %@", _rString);
    NSLog(@"cString before append %@", _cString);
    [mString appendString:@"def"];
    NSLog(@"rString after append %@", _rString);   // 改变
    NSLog(@"cString after append %@", _cString);   // 没改变
    
    
    
    //
    // 不能用NSString来测试
    //
    self.sObject = [[NSObject alloc] init];
    self.wObject = self.sObject;
    self.sObject = nil;
    NSLog(@"sObject is %@", self.sObject);
    NSLog(@"wObject is %@", self.wObject);

}

@end
