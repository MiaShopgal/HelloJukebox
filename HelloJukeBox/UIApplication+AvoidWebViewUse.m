//
//  UIApplication+AvoidWebViewUse.m
//  EscapeMusic
//
//  Created by Mia Yu on 7/13/15.
//  Copyright (c) 2015 Interchan. All rights reserved.
//

#import "UIApplication+AvoidWebViewUse.h"
#import "JukeBoxMacro.h"

@implementation UIApplication (AvoidWebViewUse)

+ (void)load {
    [ [ JukeBoxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(beginReceivingRemoteControlEvents)
                                              to:@selector(avoidWebViewUse_beginReceivingRemoteControlEvents) ];
    [ [ JukeBoxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(becomeFirstResponder)
                                              to:@selector(avoidWebViewUse_becomeFirstResponder) ];
}

- (void)avoidWebViewUse_becomeFirstResponder {

    NSLog(@"avoidWebViewUse_becomeFirstResponder");

    if ([ JukeBoxMacro sharedSingleton ].requestingRemoteControl) {

        [ self avoidWebViewUse_becomeFirstResponder ];

    } else {

        NSLog(@"UIWebView trying to becomeFirstResponder ");

    }
}


- (void)avoidWebViewUse_beginReceivingRemoteControlEvents {

    NSLog(@"avoidWebViewUse_beginReceivingRemoteControlEvents");

    if ([ JukeBoxMacro sharedSingleton ].requestingRemoteControl) {

        [ self avoidWebViewUse_beginReceivingRemoteControlEvents ];

    } else {

        NSLog(@"UIWebView trying to beginReceivingRemoteControlEvents ");

    }

}


@end
