//
//  KVO.h
//  KVO
//
//  Created by miniu on 16/1/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Student;

@interface KVO : NSObject

@property (strong, nonatomic) Student       * student;

- (instancetype)initWithStudent:(Student *)student;

@end
