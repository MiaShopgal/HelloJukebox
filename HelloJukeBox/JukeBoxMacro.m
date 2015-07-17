//
// Created by Mia Yu on 7/15/15.
// Copyright (c) 2015 Miao. All rights reserved.
//


#import "JukeBoxMacro.h"


@implementation JukeBoxMacro {

}
@synthesize settingNowPlayingInfo;

@synthesize requestingRemoteControl;

+ (JukeBoxMacro *)sharedSingleton {
    static JukeBoxMacro *_sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,
                  ^{
                      _sharedSingleton = [ [ self alloc ] init ];
                  });
    return _sharedSingleton;
}

- (instancetype)init {
    self = [ super init ];
    if (self) {
        settingNowPlayingInfo = NO;
        requestingRemoteControl = NO;
    }

    return self;
}
- (void)swizzling:(Class)aClass
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