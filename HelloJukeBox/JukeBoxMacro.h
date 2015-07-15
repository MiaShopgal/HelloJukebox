//
// Created by Mia Yu on 7/15/15.
// Copyright (c) 2015 Miao. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JukeboxMacro : NSObject{
}
@property(nonatomic) BOOL settingNowPlayingInfo;

@property(nonatomic) BOOL requestingRemoteControl;

+(JukeboxMacro *)sharedSingleton;
@end
