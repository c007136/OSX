//
//  main.m
//  DemoX
//
//  Created by miniu on 15/8/13.
//  Copyright (c) 2015年 miniu. All rights reserved.
//

#import <Foundation/Foundation.h>



int main()
{
    
    NSMutableDictionary *test = [NSMutableDictionary dictionaryWithDictionary:@{@"Lat": @37.321398, @"Long" : @28.292399}];
    NSData *data = [NSJSONSerialization dataWithJSONObject:test options:NSJSONWritingPrettyPrinted error:nil];
    
    NSDictionary *test1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"test1 = %@", test1);
    
    return 0;
}