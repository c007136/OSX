//
//  main.m
//  MessageForwarding
//
//  Created by miniu on 16/2/4.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"
#import <objc/runtime.h>

int main(int argc, const char * argv[])
{
    
    //objc_class
    
    instrumentObjcMessageSends(YES);
    NSObject * t = [NSObject new];
    [t performSelector:@selector(XXX)];
    
    return 0;
}
