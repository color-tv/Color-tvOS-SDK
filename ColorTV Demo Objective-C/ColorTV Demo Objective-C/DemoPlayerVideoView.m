//
//  DemoPlayerVideoView.m
//  ColorTV Demo Objective-C
//
//  Created by Michał Papp on 02.05.2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

#import "DemoPlayerVideoView.h"

const char *kDemoVideoViewPlayerAccessQueue = "com.colortv.DemoApp.DemoVideoViewPlayerAccessQueue";

@interface DemoPlayerVideoView ()

@property (atomic, strong) dispatch_queue_t playerViewAccessQueue;

@end

@implementation DemoPlayerVideoView

- (instancetype)init {
    self = [super init];
    if(self) {
        self.playerViewAccessQueue = dispatch_queue_create(kDemoVideoViewPlayerAccessQueue, nil);
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

+ (Class)layerClass {
    return [AVPlayerLayer class];
}

- (AVPlayer *)player {
    __block AVPlayer *result;
    
    dispatch_sync(self.playerViewAccessQueue, ^{
        result = ((AVPlayerLayer *)self.layer).player;
    });
    
    return result;
}

- (void)setPlayer:(AVPlayer *)player {
    dispatch_sync(self.playerViewAccessQueue, ^{
        ((AVPlayerLayer *)self.layer).player = player;
    });
}

@end
