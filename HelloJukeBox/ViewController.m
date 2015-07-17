//
//  ViewController.m
//  HelloJukeBox
//
//  Created by Mia Yu on 7/14/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//



#import "ViewController.h"
#import "JukeBoxMacro.h"



@interface ViewController () <UIWebViewDelegate>

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

    _socialWebView.delegate = self;
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL:[ NSURL URLWithString:socialUrl ] ];
    [ _socialWebView loadRequest:request ];

}

- (void)didReceiveMemoryWarning {
    [ super didReceiveMemoryWarning ];
    // Dispose of any resources that can be recreated.

}

- (BOOL)           webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
            navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {

//        NSLog(@"UIWebViewNavigationTypeLinkClicked");

    } else if (navigationType == UIWebViewNavigationTypeOther) {

//        NSLog(@"UIWebViewNavigationTypeOther");

    }
    return YES;
}

- (void)viewWillLayoutSubviews {
    [ super viewWillLayoutSubviews ];
    NSLog(@"viewWillLayoutSubviews");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    NSLog(@"webViewDidFinishLoad");
    BOOL isFirst=[ webView isFirstResponder ];

    if ([ webView isFirstResponder ]) {

        NSLog(@" isFirstResponder ");

    }else {

        NSLog(@" is NOT FirstResponder ");

    }

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
    [ _playSwitch setOn:isOn
               animated:YES ];
    [ self setControlCenterShowingNowPlayingInfo ];


}

- (void)registerRemoteControl {
    MPRemoteCommandCenter *commandCenter = [ MPRemoteCommandCenter sharedCommandCenter ];

    MPRemoteCommand *playCommand = [ commandCenter playCommand ];
    [ playCommand setEnabled:YES ];
    [ JukeBoxMacro sharedSingleton ].settingRemoteCommandTarget = YES;
    [ playCommand addTargetWithHandler:^(MPRemoteCommandEvent *event) {
        [ self playMusic:YES ];
        return MPRemoteCommandHandlerStatusSuccess;
    } ];
    [ JukeBoxMacro sharedSingleton ].settingRemoteCommandTarget = NO;

    MPRemoteCommand *pauseCommand = [ commandCenter pauseCommand ];
    [ JukeBoxMacro sharedSingleton ].settingRemoteCommandTarget = YES;
    [ pauseCommand setEnabled:YES ];
    [ pauseCommand addTargetWithHandler:^(MPRemoteCommandEvent *event) {
        [ self playMusic:NO ];
        return MPRemoteCommandHandlerStatusSuccess;

    } ];
    [ JukeBoxMacro sharedSingleton ].settingRemoteCommandTarget = NO;
}

- (void)setControlCenterShowingNowPlayingInfo {

    NSMutableDictionary *songInfo = [ [ NSMutableDictionary alloc ] init ];
    songInfo[MPMediaItemPropertyArtist] = @"name of Artist";
    songInfo[MPMediaItemPropertyAlbumTitle] = @"title of Album";
    songInfo[MPMediaItemPropertyTitle] = @"title of Song";

    [ JukeBoxMacro sharedSingleton ].settingNowPlayingInfo = YES;
    [ [ MPNowPlayingInfoCenter defaultCenter ] setNowPlayingInfo:songInfo ];
    [ JukeBoxMacro sharedSingleton ].settingNowPlayingInfo = NO;

/*


    [ JukeBoxMacro sharedSingleton ].requestingRemoteControl = YES;

    BOOL isFirst = [ [ UIApplication sharedApplication ] isFirstResponder ];

    if([ [ UIApplication sharedApplication ] isFirstResponder ]){

        NSLog(@"isFirstResponder");

    } else{

        NSLog(@"is NOT FirstResponder");

    }
    [ [ UIApplication sharedApplication ] beginReceivingRemoteControlEvents ];

    if([ [ UIApplication sharedApplication ] becomeFirstResponder ]) {

        NSLog(@"success");

    }else{

        NSLog(@"fail");

    }
    [ JukeBoxMacro sharedSingleton ].requestingRemoteControl = NO;


*/


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