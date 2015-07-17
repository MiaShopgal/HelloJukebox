//
//  MPNowPlayingInfoCenter+AvoidWebViewUse.m
//  TEST_2015_7_9
//
//  Created by DaidoujiChen on 2015/7/9.
//  Copyright (c) 2015年 DaidoujiChen. All rights reserved.
//

#import "MPNowPlayingInfoCenter+AvoidWebViewUse.h"
#import "JukeboxMacro.h"

@interface MPMoviePlayerController () {
}
@end

@implementation MPNowPlayingInfoCenter (AvoidWebViewUse)

+ (void)load {
    [ [ JukeboxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(setNowPlayingInfo:)
                                              to:@selector(avoidWebViewUse_setNowPlayingInfo:) ];

}


- (void)avoidWebViewUse_setNowPlayingInfo:(NSDictionary *)playingInfo {

//    NSLog(@"avoidWebViewUse_setNowPlayingInfo");

    if ([ JukeboxMacro sharedSingleton ].settingNowPlayingInfo) {

        [ self avoidWebViewUse_setNowPlayingInfo:playingInfo ];

    } else {

//        NSLog(@" UIWebView trying to set now playing info ");

    }
}


@end
