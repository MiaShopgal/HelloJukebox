//
//  ViewController.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/14/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//



#import "ViewController.h"


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
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL:[ NSURL URLWithString:@"https://instagram.com/michaeljackson/" ] ];
    [ _socialWebView loadRequest:request ];

}

- (void)didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ];
    // Dispose of any resources that can be recreated.

}


- (IBAction)switchChanged:(id)sender {
    if ([ sender isOn ]) {
        NSLog(@"on");
        [ self playMusic ];
    } else {
        NSLog(@"off");
        [ player pause ];
    }
}

- (void)playMusic {
    [ player play ];

    NSMutableDictionary *songInfo = [ [ NSMutableDictionary alloc ] init ];
    songInfo[MPMediaItemPropertyArtist] = @"name of Artist";
    songInfo[MPMediaItemPropertyAlbumTitle] = @"title of Album";
    songInfo[MPMediaItemPropertyTitle] = @"title of Song";
    [ [ MPNowPlayingInfoCenter defaultCenter ] setNowPlayingInfo:songInfo ];
}



- (void)viewDidAppear:(BOOL)animated {
    [ super viewDidAppear:animated ];
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(enterVideoFullScreen)
                                                    name:UIWindowDidBecomeVisibleNotification
                                                  object:nil ];
}

- (void)enterVideoFullScreen {
    [ player pause ];
    [ [ NSNotificationCenter defaultCenter ] removeObserver:self
                                                       name:UIWindowDidBecomeVisibleNotification
                                                     object:nil ];
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(leaveVideoFullScreen)
                                                    name:UIWindowDidBecomeHiddenNotification
                                                  object:nil ];
}

- (void)leaveVideoFullScreen {
    [ self playMusic ];
    [ [ NSNotificationCenter defaultCenter ] removeObserver:self
                                                       name:UIWindowDidBecomeHiddenNotification
                                                     object:nil ];
    [ [ NSNotificationCenter defaultCenter ] addObserver:self
                                                selector:@selector(enterVideoFullScreen)
                                                    name:UIWindowDidBecomeVisibleNotification
                                                  object:nil ];
}
@end