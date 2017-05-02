//
//  VideoViewController.m
//  ColorTV Demo Objective-C
//
//  Created by Jordan Jasinski on 15/03/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

#import "VideoViewController.h"

#if TARGET_OS_TV
@import COLORAdFramework;
#else
@import COLORMobileAdFramework;
#endif

static NSString *const kPlaybackLikelyToKeepUpKeyPath = @"currentItem.playbackLikelyToKeepUp";
const char *kDemoVideoViewPlayerAccessQueue = "com.colortv.DemoApp.DemoVideoViewPlayerAccessQueue";

@interface DemoPlayerVideoView : UIView

@property (atomic, strong) dispatch_queue_t playerViewAccessQueue;
@property (atomic, strong) AVPlayer *player;

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

@interface VideoViewController ()

@property (nonatomic, assign, readwrite) BOOL isVideoPlaying;
@property (nonatomic, strong, readonly) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UITapGestureRecognizer *playPauseBtnRecognizer;
@property (nonatomic, strong) COLORRecommendationViewController *recommendationVC;
@property (nonatomic, strong) COLORNextItemRecommendationViewController *nextItemVC;

@end

@implementation VideoViewController

- (instancetype)init {
    self = [super init];
    if(self) {
        
        self.playPauseBtnRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playPauseButtonClicked)];
        self.playPauseBtnRecognizer.allowedPressTypes = @[@(UIPressTypePlayPause)];
    }
    return self;
}

- (void)loadView {
    self.view = [[DemoPlayerVideoView alloc] init];
    
    _loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    
    self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.loadingIndicator];
    
    [self.loadingIndicator.widthAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.loadingIndicator.heightAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.loadingIndicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.loadingIndicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    
    [self.loadingIndicator startAnimating];
    
#if TARGET_OS_IOS
    UIButton *playPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [playPauseBtn setTitle:@"|>" forState:UIControlStateNormal];
    playPauseBtn.backgroundColor = [UIColor redColor];
    [playPauseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [playPauseBtn addTarget:self action:@selector(playPauseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playPauseBtn];
    
    playPauseBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [playPauseBtn.widthAnchor constraintEqualToConstant:70.0f].active = YES;
    [playPauseBtn.heightAnchor constraintEqualToConstant:70.0f].active = YES;
    [playPauseBtn.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40.0f].active = YES;
    [playPauseBtn.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40.0f].active = YES;
#endif
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view addGestureRecognizer:self.playPauseBtnRecognizer];
    
    [self.videoPlayer addObserver:self forKeyPath:@"rate" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.videoPlayer addObserver:self forKeyPath:kPlaybackLikelyToKeepUpKeyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(self.isVideoPlaying) {
        [self pause];
    }
    
    [self.view removeGestureRecognizer:self.playPauseBtnRecognizer];
    
    [self.videoPlayer removeObserver:self forKeyPath:@"rate"];
    [self.videoPlayer removeObserver:self forKeyPath:kPlaybackLikelyToKeepUpKeyPath];
}

- (AVPlayer *)videoPlayer {
    return ((AVPlayerLayer *)self.view.layer).player;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if([keyPath isEqualToString:@"rate"]) {
        
        float rate = [change[@"new"] floatValue];
        
        if(rate == 0) {
            if(self.recommendationVC) {
                
                if(self.presentedViewController != self.recommendationVC) {
                    [self presentViewController:self.recommendationVC animated:YES completion:nil];
                }
            }
        }
        
        if(self.videoPlayer.currentItem.isPlaybackLikelyToKeepUp) {
            [self.loadingIndicator stopAnimating];
        } else {
            [self.loadingIndicator startAnimating];
        }
    } else if([keyPath isEqualToString:kPlaybackLikelyToKeepUpKeyPath]) {

        BOOL likelyToKeepUp = [change[@"new"] boolValue];
        
        if(likelyToKeepUp) {
            [self.loadingIndicator stopAnimating];
        } else {
            [self.loadingIndicator startAnimating];
        }
    }
}

- (void)loadVideoWithURL:(NSURL *)url andId:(NSString *)identifier {
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithURL:url];
    
    if(self.videoPlayer) {
        [self.videoPlayer replaceCurrentItemWithPlayerItem:videoItem];
    } else {
        ((DemoPlayerVideoView *)self.view).player = [AVPlayer playerWithPlayerItem:videoItem];
    }
    
    [[COLORAdController sharedAdController] contentRecommendationControllerForPlacement:COLORAdFrameworkPlacementVideoStart andVideoId:identifier withCompletion:^(COLORRecommendationViewController * _Nullable vc, NSError * _Nullable error) {
        
        if(!error && vc) {
            
            vc.itemSelected = ^(NSString *videoId, NSURL *videoURL, NSDictionary *clickParams) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                        [self loadVideoWithURL:videoURL andId:videoId];
                        [self play];
                    }];
                });
            };
            
            vc.contentRecommendationClosed = ^() {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self dismissViewControllerAnimated:YES completion:^{
                        [self play];
                    }];
                });
            };

            self.recommendationVC = vc;
            
        } else {
            NSLog(@"::>> ConRec ERROR: %@", error);
        }
    }];

}

- (void)play {
    [[self videoPlayer] play];
    self.isVideoPlaying = YES;
}

- (void)pause {
    [[self videoPlayer] pause];
    self.isVideoPlaying = NO;
}

- (void)playPauseButtonClicked {
    if(self.isVideoPlaying) {
        [self pause];
    } else {
        [self play];
    }
}

@end
