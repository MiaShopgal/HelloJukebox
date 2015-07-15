//
// Created by Mia Yu on 7/15/15.
// Copyright (c) 2015 Miao. All rights reserved.
//

#import "JukeboxMacro.h"


@implementation JukeboxMacro {

}
@synthesize settingNowPlayingInfo;

@synthesize requestingRemoteControl;

+ (JukeboxMacro *)sharedSingleton {
    static JukeboxMacro *_sharedSingleton = nil;
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

@end