//
//  BMGAdController.h
//  BMGAdFramework
//
//  Created by Jordan Jasinski on 12.11.2015.
//  Copyright © 2015 Backflip Media Group Inc. All rights reserved.
//

@import UIKit;

typedef void(^BMGAdFrameworkAdRequestCompletion)(UIViewController * _Nullable vc, NSError * _Nullable error);

typedef NS_ENUM(NSUInteger, BMGAdFrameworkAdType) {
    BMGAdFrameworkAdTypeAny = 0,
    BMGAdFrameworkAdTypeAppWall = 1,
    BMGAdFrameworkAdTypeAppGrid = 2,
    BMGAdFrameworkAdTypeAppSingle = 3,
    BMGAdFrameworkAdTypeVideo = 4,
    BMGAdFrameworkAdTypeFeaturedItem = 5,
    BMGAdFrameworkAdTypeFullscreen = 6
};

extern NSString * _Nonnull const BMGAdFrameworkPlacementAppLaunch;
extern NSString * _Nonnull const BMGAdFrameworkPlacementAppResume;
extern NSString * _Nonnull const BMGAdFrameworkPlacementAppClose;
extern NSString * _Nonnull const BMGAdFrameworkPlacementMainMenu;
extern NSString * _Nonnull const BMGAdFrameworkPlacementPause;
extern NSString * _Nonnull const BMGAdFrameworkPlacementStageOpen;
extern NSString * _Nonnull const BMGAdFrameworkPlacementStageComplete;
extern NSString * _Nonnull const BMGAdFrameworkPlacementStageFailed;
extern NSString * _Nonnull const BMGAdFrameworkPlacementLevelUp;
extern NSString * _Nonnull const BMGAdFrameworkPlacementBetweenLevels;
extern NSString * _Nonnull const BMGAdFrameworkPlacementStoreOpen;
extern NSString * _Nonnull const BMGAdFrameworkPlacementInAppPurchase;
extern NSString * _Nonnull const BMGAdFrameworkPlacementInAppPurchaseAbandoned;
extern NSString * _Nonnull const BMGAdFrameworkPlacementVirtualGoodPurchase;
extern NSString * _Nonnull const BMGAdFrameworkPlacementUserHighScore;
extern NSString * _Nonnull const BMGAdFrameworkPlacementOudOfGoods;
extern NSString * _Nonnull const BMGAdFrameworkPlacementOutOfEnergy;
extern NSString * _Nonnull const BMGAdFrameworkPlacementInsufficientCurrency;
extern NSString * _Nonnull const BMGAdFrameworkPlacementFinishedTutorial;

extern NSString * _Nonnull const BMGAdFrameworkNotificationDidGetCurrency;

@protocol BMGAdControllerDelegate <NSObject>

@optional

-(void)didGetCurrency:(NSUInteger)currencyAmount;

@end

@interface BMGAdController : NSObject

@property (nonatomic, assign) BOOL debugMode;
@property (nonatomic, assign) NSString* _Nonnull currentPlacement;

@property (nonatomic, weak) id<BMGAdControllerDelegate> _Nullable delegate;

+(instancetype _Null_unspecified)sharedAdController;

-(void)startWithAppIdentifier:(NSString* _Nonnull)appIdentifier;

-(void)adViewControllerWithCompletion:(BMGAdFrameworkAdRequestCompletion _Nonnull)completion;
-(void)adViewControllerOfType:(BMGAdFrameworkAdType)type withCompletion:(BMGAdFrameworkAdRequestCompletion _Nonnull)completion;

-(NSBundle* _Null_unspecified)frameworkBundle;

@end
