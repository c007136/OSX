//
//  DFather.h
//  Accessor
//
//  Created by miniu on 15/12/17.
//  Copyright © 2015年 muyu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DFather : NSObject

@property (nonatomic, strong) NSString       * info;

@end



//
//  Child
//
@interface DChild : DFather

@property (nonatomic, strong) NSString        * childInfo;

@end