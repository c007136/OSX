//
//  main.m
//  KVO
//
//  Created by miniu on 16/1/21.
//  Copyright © 2016年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVO.h"
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Student * student = [[Student alloc] init];
        student.course = @"math";
        NSLog(@"course is %@", student.course);
        
        student.ID = 11;
        NSLog(@"ID is %ld", (long)student.ID);
        
        KVO * kvo = [[KVO alloc] initWithStudent:student];
        
        //[student setValue:@"english" forKey:@"course"];
        student.course = @"english";
        NSLog(@"course is %@", student.course);
        
        student.ID = 110;
        NSLog(@"ID is %ld", (long)student.ID);
    }
    return 0;
}
