//
//  KVO.m
//  KVO
//
//  Created by miniu on 16/1/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import "KVO.h"
#import "Student.h"

@implementation KVO

- (instancetype)initWithStudent:(Student *)student
{
    self = [super init];
    if (self) {
        _student = student;
        
        [_student addObserver:self forKeyPath:@"course" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [_student addObserver:self forKeyPath:@"ID" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (void)dealloc
{
    [_student removeObserver:self forKeyPath:@"course"];
    [_student removeObserver:self forKeyPath:@"ID"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"course"])
    {
        NSLog(@"course is changed new %@ old %@", [change objectForKey:@"new"], [change objectForKey:@"old"]);
    }
    else if ([keyPath isEqualToString:@"ID"])
    {
        NSLog(@"ID is changed new %@ old %@", [change objectForKey:@"new"], [change objectForKey:@"old"]);
    }
}

@end
