//
//  ViewController.h
//  HelloJukeBox
//
//  Created by Mia Yu on 7/14/15.
//  Copyright (c) 2015 Miao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVPlayer.h>
#import <MediaPlayer/MPNowPlayingInfoCenter.h>
#import <MediaPlayer/MPMediaItem.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
}


@property(nonatomic, strong) AVPlayer *player;

- (void)playMusic:(BOOL)isOn;

- (IBAction)switchChanged:(id)sender;
@property(nonatomic, weak) IBOutlet UISwitch *playSwitch;
@property(nonatomic, weak) IBOutlet UIWebView *socialWebView;

@end
