//
//  UIResponder+AvoidWebViewUse.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/16/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//

#import "UIResponder+AvoidWebViewUse.h"
#import "JukeboxMacro.h"

@interface UIResponder () {

}
@end

@implementation UIResponder (AvoidWebViewUse)
+ (void)load {
    [ [ JukeboxMacro sharedSingleton ] swizzling:[ self class ]
                                            from:@selector(remoteControlReceivedWithEvent:)
                                              to:@selector(avoidWebViewUse_remoteControlReceivedWithEvent:) ];
}

- (void)avoidWebViewUse_remoteControlReceivedWithEvent:(UIEvent *)event {

    NSLog(@"avoidWebViewUse_remoteControlReceivedWithEvent");

}
@end
