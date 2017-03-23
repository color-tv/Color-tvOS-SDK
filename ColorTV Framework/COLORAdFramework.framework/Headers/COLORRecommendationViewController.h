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
@property (nonatomic, copy) void (^_Nullable itemSelected)(NSString * _Nonnull videoId, NSURL * _Nonnull videoURL, NSDictionary * _Nullable parameters);

@property (nonatomic, strong) UIView * _Nullable backgroundView;
@property (nonatomic, strong) NSMutableDictionary* _Nonnull developerSettings;

-(void)registerNib:(UINib* _Nonnull)nib forReusableCellWithIdentifier:(NSString * _Nonnull)identifier;
-(void)registerClass:(Class _Nonnull)className forReusableCellWithIdentifier:(NSString * _Nonnull)identifier;

@end
