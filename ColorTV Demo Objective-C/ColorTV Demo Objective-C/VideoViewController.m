//
//  VideoViewController.m
//  ColorTV Demo Objective-C
//
//  Created by Jordan Jasinski on 15/03/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

#import "VideoViewController.h"

#import "DemoPlayerVideoView.h"

#if TARGET_OS_TV
@import COLORAdFramework;
#else
@import COLORMobileAdFramework;
#endif

static NSString *const kPlaybackLikelyToKeepUpKeyPath = @"currentItem.playbackLikelyToKeepUp";
static NSString *const kRateKeyPath = @"rate";

@interface VideoViewController ()

@property (nonatomic, assign, readwrite) BOOL isVideoPlaying;
@property (nonatomic, strong) UIActivityIndicatorView *loadingIndicator;
@property (nonatomic, strong) UITapGestureRecognizer *playPauseButtonRecognizer;
@property (nonatomic, strong) COLORRecommendationViewController *recommendationVC;
@property (nonatomic, strong) COLORNextItemRecommendationViewController *nextItemVC;

@end

@implementation VideoViewController

- (void)loadView {
    self.view = [[DemoPlayerVideoView alloc] init];
    [self setupLoadingIndicator];
    [self setupPlayPauseButtonIfNeeded];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self addObservers];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if(self.isVideoPlaying) {
        [self pause];
    }
    
    [self removeObservers];
}

#pragma mark - Observers

- (void)addObservers {
    [self.view addGestureRecognizer:self.playPauseButtonRecognizer];
    
    [self.videoPlayer addObserver:self
                       forKeyPath:kRateKeyPath
                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                          context:nil];
    [self.videoPlayer addObserver:self
                       forKeyPath:kPlaybackLikelyToKeepUpKeyPath
                          options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                          context:nil];
}

- (void)removeObservers {
    [self.view removeGestureRecognizer:self.playPauseButtonRecognizer];
    
    [self.videoPlayer removeObserver:self forKeyPath:kRateKeyPath];
    [self.videoPlayer removeObserver:self forKeyPath:kPlaybackLikelyToKeepUpKeyPath];
}

- (UITapGestureRecognizer *)playPauseButtonRecognizer {
    if (!_playPauseButtonRecognizer) {
        _playPauseButtonRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                             action:@selector(playPauseButtonClicked)];
        _playPauseButtonRecognizer.allowedPressTypes = @[@(UIPressTypePlayPause)];
    }
    return _playPauseButtonRecognizer;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if([keyPath isEqualToString:kRateKeyPath]) {
        float rate = [change[@"new"] floatValue];
        BOOL recommendationsShouldBePresented = self.recommendationVC && (self.presentedViewController != self.recommendationVC);
        if(rate == 0 && recommendationsShouldBePresented) {
            [self presentViewController:self.recommendationVC animated:YES completion:nil];
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

#pragma mark - View

- (AVPlayer *)videoPlayer {
    return ((AVPlayerLayer *)self.view.layer).player;
}

- (void)setupLoadingIndicator {
    self.loadingIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    self.loadingIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loadingIndicator];
    [self.loadingIndicator.widthAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.loadingIndicator.heightAnchor constraintEqualToConstant:100.0f].active = YES;
    [self.loadingIndicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [self.loadingIndicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    [self.loadingIndicator startAnimating];
}

- (void)setupPlayPauseButtonIfNeeded {
#if TARGET_OS_IOS
    UIButton *playPauseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"pause"];
    [playPauseButton setImage:image forState:UIControlStateNormal];
    playPauseButton.backgroundColor = [UIColor clearColor];
    [playPauseButton addTarget:self action:@selector(playPauseButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playPauseButton];
    playPauseButton.layer.cornerRadius = 35.0f;
    playPauseButton.translatesAutoresizingMaskIntoConstraints = NO;
    [playPauseButton.widthAnchor constraintEqualToConstant:70.0f].active = YES;
    [playPauseButton.heightAnchor constraintEqualToConstant:70.0f].active = YES;
    [playPauseButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:40.0f].active = YES;
    [playPauseButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-40.0f].active = YES;
#endif
}

#pragma mark - Video

- (void)loadVideoWithURL:(NSURL *)url andId:(NSString *)identifier {
    AVPlayerItem *videoItem = [AVPlayerItem playerItemWithURL:url];
    
    if(self.videoPlayer) {
        [self.videoPlayer replaceCurrentItemWithPlayerItem:videoItem];
    } else {
        ((DemoPlayerVideoView *)self.view).player = [AVPlayer playerWithPlayerItem:videoItem];
    }
    
    [[COLORAdController sharedAdController] contentRecommendationControllerForPlacement:COLORAdFrameworkPlacementVideoStart
                                                                             andVideoId:identifier
                                                                         withCompletion:^(COLORRecommendationViewController * _Nullable viewController, NSError * _Nullable error) {
         if (error) {
             NSLog(@"::>> ConRec ERROR: %@", error);
             return;
         }
         if (!viewController) {
             NSLog(@"::>> ConRec No RecommendationViewController");
             return;
         }
         
         viewController.itemSelected = ^(NSString *videoId, NSURL *videoURL, NSDictionary *clickParams) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self dismissViewControllerAnimated:YES completion:^{
                     [self loadVideoWithURL:videoURL andId:videoId];
                     [self play];
                 }];
             });
         };
         
         viewController.contentRecommendationClosed = ^() {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self dismissViewControllerAnimated:YES completion:^{
                     [self play];
                 }];
             });
         };
         
         self.recommendationVC = viewController;
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
