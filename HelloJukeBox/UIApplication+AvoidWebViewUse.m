//
//  UIApplication+AvoidWebViewUse.m
//  EscapeMusic
//
//  Created by Mia Yu on 7/13/15.
//  Copyright (c) 2015 Interchan. All rights reserved.
//

#import "UIApplication+AvoidWebViewUse.h"
#import <objc/runtime.h>

@implementation UIApplication(AvoidWebViewUse)

+ (void)load {
    [ self swizzling:[ self class ]
                from:@selector(beginReceivingRemoteControlEvents)
                  to:@selector(avoidWebViewUse_beginReceivingRemoteControlEvents) ];
    [ self swizzling:[ self class ]
                from:@selector(becomeFirstResponder)
                  to:@selector(avoidWebViewUse_becomeFirstResponder) ];
}

- (void)avoidWebViewUse_becomeFirstResponder {

    NSLog(@"avoidWebViewUse_becomeFirstResponder");

   /* if ([ [ PlayAudioItem_MGR getInstance ] isEnterBackground ]) {

        [ self avoidWebViewUse_becomeFirstResponder ];

    } else {

        NSLog(@"avoidWebViewUse_becomeFirstResponder not in background");

    }*/
}


- (void)avoidWebViewUse_beginReceivingRemoteControlEvents {
    
    NSLog(@"avoidWebViewUse_beginReceivingRemoteControlEvents");

    /*if ([ [ PlayAudioItem_MGR getInstance ] isEnterBackground ]) {

        [ self avoidWebViewUse_beginReceivingRemoteControlEvents ];

    } else {

        NSLog(@"avoidWebViewUse_beginReceivingRemoteControlEvents not in background");

    }*/
    
}


+ (void)swizzling:(Class)aClass
             from:(SEL)before
               to:(SEL)after {
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
