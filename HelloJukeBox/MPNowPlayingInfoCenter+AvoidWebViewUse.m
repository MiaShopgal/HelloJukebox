//
//  MPNowPlayingInfoCenter+AvoidWebViewUse.m
//  TEST_2015_7_9
//
//  Created by DaidoujiChen on 2015/7/9.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "MPNowPlayingInfoCenter+AvoidWebViewUse.h"
#import "JukeboxMacro.h"
#import <objc/runtime.h>

@interface MPMoviePlayerController(){
}
@end
@implementation MPNowPlayingInfoCenter (AvoidWebViewUse)

+ (void)load {
    [ self swizzling:[ self class ]
                from:@selector(setNowPlayingInfo:)
                  to:@selector(avoidWebViewUse_setNowPlayingInfo:) ];
}


- (void)avoidWebViewUse_setNowPlayingInfo:(NSDictionary *)playingInfo {

    NSLog(@"avoidWebViewUse_setNowPlayingInfo");

    if([ JukeboxMacro sharedSingleton ].settingNowPlayingInfo){

        [ self avoidWebViewUse_setNowPlayingInfo:playingInfo ];

    } else {

        NSLog(@" UIWebView trying to set now playing info ");

    }
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
