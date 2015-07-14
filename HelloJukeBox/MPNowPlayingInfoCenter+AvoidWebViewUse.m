//
//  MPNowPlayingInfoCenter+AvoidWebViewUse.m
//  TEST_2015_7_9
//
//  Created by DaidoujiChen on 2015/7/9.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "MPNowPlayingInfoCenter+AvoidWebViewUse.h"
#import "ViewController.h"
#import <objc/runtime.h>

@interface MPMoviePlayerController(){
}
@end
@implementation MPNowPlayingInfoCenter (AvoidWebViewUse)

+ (void)load {
    NSLog(@"class name in load, %@",
          NSStringFromClass([ self class ]));
    [ self swizzling:[ self class ]
                from:@selector(setNowPlayingInfo:)
                  to:@selector(avoidWebViewUse_setNowPlayingInfo:) ];
}


- (void)avoidWebViewUse_setNowPlayingInfo:(id)arg1 {

    NSLog(@"avoidWebViewUse_setNowPlayingInfo");
    ViewController *viewController;
    if(viewController.playSwitch.isOn){

        NSLog(@" youtube playing");

    } else {

        [ self avoidWebViewUse_setNowPlayingInfo:arg1 ];

    }
}


+ (void)swizzling:(Class)aClass
             from:(SEL)before
               to:(SEL)after {
    NSLog(@"class name in swizzling, %@",
          NSStringFromClass(aClass));
    SEL originalSelector = before;
    SEL swizzledSelector = after;

    Method originalMethod = class_getInstanceMethod(aClass,
                                                    originalSelector);
    Method swizzledMethod = class_getInstanceMethod(aClass,
                                                    swizzledSelector);

    BOOL didAddMethod = class_addMethod(aClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod,
                                       swizzledMethod);
    }
}

@end
