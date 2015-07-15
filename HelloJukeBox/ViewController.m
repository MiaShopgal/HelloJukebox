//
//  ViewController.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/14/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//



#import "ViewController.h"
#import "JukeboxMacro.h"


@interface ViewController ()

@end

@implementation ViewController {
}


@synthesize player;

- (void)viewDidLoad {
    [ super viewDidLoad ];
    // Do any additional setup after loading the view, typically from a nib.

    NSURL *audioFileLocationURL = [ [ NSBundle mainBundle ] URLForResource:@"audiofile"
                                                             withExtension:@"mp3" ];

    player = [ AVPlayer playerWithURL:audioFileLocationURL ];

}

- (void)viewWillAppear:(BOOL)animated {
    [ super viewWillAppear:animated ];
    NSString *loseControlInstagram = @"https://instagram.com/michaeljackson/";
    NSString *symphonyYoutube = @"https://www.youtube.com/watch?v=UPJ1e1Hc1hw";
    //NOTE use loseControlInstagram to witness chaos in control center..
    NSString *socialUrl = loseControlInstagram;

    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL:[ NSURL URLWithString:socialUrl ] ];
    [ _socialWebView loadRequest:request ];

}

- (void)didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ];
    // Dispose of any resources that can be recreated.

}


- (IBAction)switchChanged:(id)sender {

    NSLog(@" switch is %d",
          [ sender isOn ]);

    [ self playMusic:[ sender isOn ] ];

}

- (void)playMusic:(BOOL)isOn {

    if (isOn) {

        [ player play ];

    } else {

        [ player pause ];

    }

    [ self setRemoteControl ];

}

- (void)setRemoteControl {

    NSMutableDictionary *songInfo = [ [ NSMutableDictionary alloc ] init ];
    songInfo[MPMediaItemPropertyArtist] = @"name of Artist";
    songInfo[MPMediaItemPropertyAlbumTitle] = @"title of Album";
    songInfo[MPMediaItemPropertyTitle] = @"title of Song";

    [ JukeboxMacro sharedSingleton ].settingNowPlayingInfo = YES;
    [ [ MPNowPlayingInfoCenter defaultCenter ] setNowPlayingInfo:songInfo ];
    [ JukeboxMacro sharedSingleton ].settingNowPlayingInfo = NO;

    [ JukeboxMacro sharedSingleton ].requestingRemoteControl = YES;
    [ [ UIApplication sharedApplication ] beginReceivingRemoteControlEvents ];
    [ [ UIApplication sharedApplication ] becomeFirstResponder ];
    [ JukeboxMacro sharedSingleton ].requestingRemoteControl = NO;

}


- (void)viewDidAppear:(BOOL)animated {
    [ super viewDidAppear:animated ];
    //NOTE Symphony by remove mark below
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(enterVideoFullScreen)
                                                    name:UIWindowDidBecomeVisibleNotification
                                                  object:nil ];
}

- (void)enterVideoFullScreen {
    [ self playMusic:NO ];
    [ [ NSNotificationCenter defaultCenter ] removeObserver:self
                                                       name:UIWindowDidBecomeVisibleNotification
                                                     object:nil ];
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(leaveVideoFullScreen)
                                                    name:UIWindowDidBecomeHiddenNotification
                                                  object:nil ];
}

- (void)leaveVideoFullScreen {
    [ self playMusic:YES ];
    [ [ NSNotificationCenter defaultCenter ] removeObserver:self
                                                       name:UIWindowDidBecomeHiddenNotification
                                                     object:nil ];
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(enterVideoFullScreen)
                                                    name:UIWindowDidBecomeVisibleNotification
                                                  object:nil ];
}
@end