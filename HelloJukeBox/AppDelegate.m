//
//  AppDelegate.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/14/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//


#import "AppDelegate.h"
#import "ViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate {
    ViewController * viewController;
}


- (BOOL)          application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSError *error;
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    if (!success) {
        //Handle error
        NSLog(@"%@", [error localizedDescription]);
    } else {
        // Yay! It worked!
    }
    viewController = (ViewController *) self.window.rootViewController;

    [ [ UIApplication sharedApplication ] beginReceivingRemoteControlEvents ];

    [ [ UIApplication sharedApplication ] becomeFirstResponder ];

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.

}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    [ super remoteControlReceivedWithEvent:event ];
    
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {

            case UIEventSubtypeNone:
                break;
            case UIEventSubtypeMotionShake:
                break;
            case UIEventSubtypeRemoteControlPlay:
                [ viewController.player play ];
                break;
            case UIEventSubtypeRemoteControlPause:
                [ viewController.player pause ];
                break;
            case UIEventSubtypeRemoteControlStop:
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                break;
            case UIEventSubtypeRemoteControlBeginSeekingBackward:
                break;
            case UIEventSubtypeRemoteControlEndSeekingBackward:
                break;
            case UIEventSubtypeRemoteControlBeginSeekingForward:
                break;
            case UIEventSubtypeRemoteControlEndSeekingForward:
                break;
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if (![ viewController.playSwitch isOn ]) {
        [ viewController.playSwitch setOn:YES ];
        [ viewController playMusic];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end