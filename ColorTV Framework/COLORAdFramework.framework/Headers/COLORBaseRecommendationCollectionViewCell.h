//
//  COLORBaseRecommendationCollectionViewCell.h
//  ColorTV Demo Objective-C
//
//  Created by Michał Ciuba on 06/12/2016.
//  Copyright (c) 2016 Color Media Group. All rights reserved.
//

@import UIKit;

#import "COLORContentRecommendationCellProtocol.h"
#import "COLORGridCell.h"

@class COLORTimerPresenter;
@class COLORTimerProgress;
@class AVPlayerLayer;

@interface COLORBaseRecommendationCollectionViewCell : UICollectionViewCell<COLORContentRecommendationCellProtocol, COLORGridCell>

@property (weak, nonatomic) IBOutlet UIImageView *adImageView;
@property (weak, nonatomic) IBOutlet COLORTimerProgress *timerProgress;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *genreLabels;
@property (nonatomic, weak) IBOutlet UIImageView *logoImageView;

@property (strong, nonatomic) NSURL *videoPreviewURL;
@property (strong, nonatomic) COLORTimerPresenter *timerPresenter;
@property (assign, nonatomic) NSTimeInterval autoPlayTime;

- (void)startVideoPreview;

- (void)stopVideoPreview;

- (void)showAutoPlayTimer;

-(void)prepareForFocusedState __attribute__((objc_requires_super));
-(void)prepareForUnfocusedState __attribute__((objc_requires_super));

// methods to be overriden by subclasses
- (void)configureWithContent:(COLORRecommendedContent *)content __attribute__((objc_requires_super));

- (CGRect)frameForPlayerLayer;

- (CALayer *)layerBelowPlayerLayer;

- (void)customizePlayerLayer:(AVPlayerLayer *)layer;

@end
