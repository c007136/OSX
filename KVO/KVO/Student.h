//
//  Student.h
//  KVO
//
//  Created by miniu on 16/1/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (copy, nonatomic) NSString      * name;
@property (copy, nonatomic) NSString      * course;
@property (assign, nonatomic) NSInteger   ID;

- (void)setCourse:(NSString *)course;

@end
