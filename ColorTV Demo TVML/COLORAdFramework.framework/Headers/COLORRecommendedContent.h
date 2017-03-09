//
//  COLORRecommendedContent.h
//  COLORAdFramework
//
//  Created by Michał Ciuba on 08/09/16.
//  Copyright © 2016 Replay inc. All rights reserved.
//

@import UIKit;

#import "COLORImageDownloadable.h"
#import "COLORTrackable.h"

@interface COLORRecommendedContent : NSObject<COLORImageDownloadable, COLORTrackable>

@property (nonatomic, readonly, assign) NSUInteger partnerId;
@property (nonatomic, readonly, assign) NSUInteger videoId;
@property (nonatomic, readonly, copy) NSString *partnerVideoId;
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly, copy) NSString *contentDescription;
@property (nonatomic, readonly, assign) NSUInteger durationInMinutes;
@property (nonatomic, readonly, assign) NSUInteger durationInSeconds;
@property (nonatomic, readonly, copy) NSArray<NSString *> *genre;
@property (nonatomic, readonly, copy) NSURL* url;
@property (nonatomic, readonly, copy) NSURL* thumbnailUrl;
@property (nonatomic, readonly, copy) NSURL *backgroundURL;
@property (nonatomic, readonly, copy) NSURL *logoURL;
@property (nonatomic, readonly, assign) NSUInteger publishTimestampMilis;
@property (nonatomic, readonly, copy) NSURL *impressionURL;
@property (nonatomic, readonly, copy) NSURL *clickTracker;
@property (nonatomic, readonly, copy) NSURL *favoriteUrl;
@property (nonatomic, readonly, copy) NSURL *videoPreviewURL;

@property (nonatomic, readonly, copy) NSNumber *rating;
@property (nonatomic, readonly, copy) NSNumber *numberOfViews;

@property (nonatomic, readonly, assign) BOOL isFirstParty;

@property(nonatomic, readonly, copy) NSString *displayedNumberOfViews;

@property(nonatomic, readonly, copy) NSString *displayedRating;

@property (nonatomic, strong, readonly) NSDictionary *clickParameters;

@property (nonatomic, assign) BOOL impressionMarked;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
