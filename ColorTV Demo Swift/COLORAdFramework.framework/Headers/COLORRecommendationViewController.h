//
//  COLORRecommendationViewController.h
//  COLORAdFramework
//
//  Created by Michał Ciuba on 08/09/16.
//  Copyright © 2016 Replay inc. All rights reserved.
//

@import UIKit;


@class COLORItemClickHandler;
@class COLORTimerPresenter;

@interface COLORRecommendationViewController : UIViewController

@property (nonatomic, copy) void (^_Nullable contentRecommendationClosed)();
@property (nonatomic, copy) void (^_Nullable itemSelected)(NSString * _Nonnull videoId,  NSURL * _Nonnull videoURL);

@end
