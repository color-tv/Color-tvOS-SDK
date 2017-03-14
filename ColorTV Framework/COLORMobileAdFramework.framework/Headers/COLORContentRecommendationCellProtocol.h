//
// Created by Michał Ciuba on 25/10/2016.
// Copyright (c) 2016 Color Media Group. All rights reserved.
//

@import Foundation;

@class COLORRecommendedContent;

@protocol COLORContentRecommendationCellProtocol <NSObject>

@property (assign, nonatomic) NSTimeInterval autoPlayTime;

- (void)configureWithContent:(COLORRecommendedContent *)content;
- (void)showAutoPlayTimer;

@optional
@property (strong, nonatomic) NSURL *videoPreviewURL;

- (void)stopVideoPreview;


@end
