//
// Created by Mia Yu on 7/15/15.
// Copyright (c) 2015 Miao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface JukeBoxMacro : NSObject{
}
@property(nonatomic) BOOL settingNowPlayingInfo;

@property(nonatomic) BOOL requestingRemoteControl;

@property(nonatomic) BOOL settingRemoteCommandTarget;

+(JukeBoxMacro *)sharedSingleton;
- (void)swizzling:(Class)aClass
             from:(SEL)before
               to:(SEL)after;
@end
