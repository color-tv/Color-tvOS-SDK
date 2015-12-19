//
//  RPLTConstans.h
//  RPLTAdFramework
//
//  Created by Jordan Jasinski on 16/12/15.
//  Copyright © 2015 Backflip Media Group Inc. All rights reserved.
//

@import Foundation;

#ifndef constans_h
#define constans_h

#pragma mark Notifications
extern NSString * _Nonnull const RPLTAdFrameworkNotificationDidGetCurrency;

#pragma mark General
extern NSString * _Nonnull const RPLTAdFrameworkBundleIdentifier;

#pragma mark App Placement
extern NSString * _Nonnull const RPLTAdFrameworkPlacementAppLaunch;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementAppResume;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementAppClose;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementMainMenu;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementPause;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementStageOpen;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementStageComplete;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementStageFailed;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementLevelUp;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementBetweenLevels;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementStoreOpen;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementInAppPurchase;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementInAppPurchaseAbandoned;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementVirtualGoodPurchase;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementUserHighScore;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementOudOfGoods;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementOutOfEnergy;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementInsufficientCurrency;
extern NSString * _Nonnull const RPLTAdFrameworkPlacementFinishedTutorial;

#pragma mark User Preferences
extern NSString * _Nonnull const RPLTAdFrameworkPreferencesEmailAddress;
extern NSString * _Nonnull const RPLTAdFrameworkPreferencesPhoneNumber;

#pragma handlers
@class RPLTAdViewController;
typedef void(^RPLTAdFrameworkAdRequestCompletion)(RPLTAdViewController * _Nullable vc, NSError * _Nullable error);

#pragma types
typedef NS_ENUM(NSUInteger, RPLTAdFrameworkAdType) {
    RPLTAdFrameworkAdTypeAny = 0,
    RPLTAdFrameworkAdTypeAppWall = 1,
    RPLTAdFrameworkAdTypeAppGrid = 2,
    RPLTAdFrameworkAdTypeAppSingle = 3,
    RPLTAdFrameworkAdTypeVideo = 4,
    RPLTAdFrameworkAdTypeFeaturedItem = 5,
    RPLTAdFrameworkAdTypeFullscreen = 6
};

#endif /* constans_h */
