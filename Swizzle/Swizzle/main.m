//
//  main.m
//  Swizzle
//
//  Created by miniu on 16/5/5.
//  Copyright © 2016年 muyu. All rights reserved.
//
//  meta class
//  http://blog.devtang.com/2013/10/15/objective-c-object-model/
//
//  load和initialize
//  http://www.cnblogs.com/ider/archive/2012/09/29/objective_c_load_vs_initialize.html
//  http://blog.leichunfeng.com/blog/2015/05/02/objective-c-plus-load-vs-plus-initialize/

#import <Foundation/Foundation.h>
#import "AObject.h"
#import "BObject.h"
#import "AAObject.h"
#import <objc/runtime.h>
#import "CObject.h"
#import "CObject+Category.h"


int main(int argc, const char * argv[]) {

    @autoreleasepool
    {
        //        // method swizzling
        //        AObject * a = [[AObject alloc] init];
        //        [a fun];
        //
        //        BObject * b = [[BObject alloc] init];
        //        [b fun];
        
        //
        // load和initialize
        //
//        [CObject load];
//        NSLog(@"%@", [AAObject class]);
        
        //
        // meta class的理解，无法验证meta class的isa指向同一个root meta class
        //
//        NSString * className = NSStringFromClass([AAObject class]);
//        NSLog(@"class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        className = NSStringFromClass([AObject class]);
//        NSLog(@"class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        className = NSStringFromClass([NSObject class]);
//        NSLog(@"class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        AAObject * aao = [[AAObject alloc] init];
//        NSLog(@"(%p, %@)...(%p, %@)...(%p, %@)..(%p, %@)", [aao class], [aao class], [aao superclass], [aao superclass], [AAObject class], [AAObject class], [AAObject superclass], [AAObject superclass]);
//        AObject * ao = [[AObject alloc] init];
//        NSLog(@"(%p, %@)...(%p, %@)...(%p, %@)..(%p, %@)", [ao class], [ao class], [ao superclass], [ao superclass], [AObject class], [AObject class], [AObject superclass], [AObject superclass]);
//        NSObject * o = [[NSObject alloc] init];
//        NSLog(@"(%p, %@)...(%p, %@)...(%p, %@)..(%p, %@)", [o class], [o class], [o superclass], [o superclass],[NSObject class], [NSObject class], [NSObject superclass], [NSObject superclass]);
        
        //
        // a和NSarray，ma和NSMutableArray的metaclass不一致
        // http://stackoverflow.com/questions/13255572/objective-c-internals-for-nsarray-and-nsmutablearray
        //
//        NSString * className = NSStringFromClass([NSMutableArray class]);
//        NSLog(@"NSMutableArray--class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        className = NSStringFromClass([NSArray class]);
//        NSLog(@"NSArray--class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        NSMutableArray * ma = [[NSMutableArray alloc] init];
//        
//        className = NSStringFromClass([ma class]);
//        NSLog(@"ma--class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        NSArray * a = [[NSArray alloc] init];
//        className = NSStringFromClass([a class]);
//        NSLog(@"a--class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        className = NSStringFromClass([NSObject class]);
//        NSLog(@"NSObject--class is %p, meta class : %p", objc_getClass([className UTF8String]), objc_getMetaClass([className UTF8String]));
//        
//        NSLog(@"(%p, %@)...(%p, %@)...(%p, %@)...(%p, %@)", [ma class], [ma class], [ma superclass], [ma superclass], [NSMutableArray class], [NSMutableArray class], [NSMutableArray superclass], [NSMutableArray superclass]);
//        NSLog(@"(%p, %@)...(%p, %@)...(%p, %@)...(%p, %@)", [a class], [a class], [a superclass], [a superclass], [NSArray class], [NSArray class], [NSArray superclass], [NSArray superclass]);
    }
    return 0;
}
