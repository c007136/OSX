//
//  Father.h
//  Accessor
//
//  Created by miniu on 15/12/17.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFather : NSObject

@property (nonatomic, strong) NSString               * fatherString;

@end



//
//  Child
//
@interface IChild : IFather

@property (nonatomic, strong) NSString               * childString;

@end