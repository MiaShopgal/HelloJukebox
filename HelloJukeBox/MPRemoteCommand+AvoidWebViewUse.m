//
//  MPRemoteCommandCenter+AvoidWebViewUse.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/15/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//

#import "MPRemoteCommand+AvoidWebViewUse.h"
#import "JukeboxMacro.h"

@interface MPRemoteCommand () {

}
@end

@implementation MPRemoteCommand (AvoidWebViewUse)
+ (void)load {
    [ [ JukeboxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(addTargetWithHandler:)
                                              to:@selector(avoidWebViewUse_addTargetWithHandler:) ];
    /*[ [ JukeboxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(setEnable:)
                                              to:@selector(avoidWebViewUse_setEnable:) ];*/
}

- (void)avoidWebViewUse_setEnable:(BOOL)enable {
    NSLog(@"avoidWebViewUse_setEnable");
}

- (void)avoidWebViewUse_addTargetWithHandler:(id)avoidWebViewUse_addTargetWithHandler {
    NSLog(@"avoidWebViewUse_addTargetWithHandler");
    if ([ [ JukeboxMacro sharedSingleton ] settingRemoteCommandTarget ]) {
        [ self avoidWebViewUse_addTargetWithHandler:avoidWebViewUse_addTargetWithHandler ];
    }else {
        NSLog(@" UIWebView is trying to addTargetWithHandler");
    }
}

@end
