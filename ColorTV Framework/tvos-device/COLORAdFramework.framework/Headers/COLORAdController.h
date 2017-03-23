//
//  COLORAdController.h
//  COLORAdFramework
//
//  Created by Jordan Jasinski on 12.11.2015.
//  Copyright © 2015 Backflip Media Group Inc. All rights reserved.
//

@import UIKit;
@import JavaScriptCore;

#if TARGET_OS_TV
#import <COLORAdFramework/COLORAdViewController.h>
#import <COLORAdFramework/COLORConstans.h>
#else
#import <COLORMobileAdFramework/COLORAdViewController.h>
#import <COLORMobileAdFramework/COLORConstans.h>
#endif

@class COLORContentRecommendationResponse;
@class COLORRecommendationViewController;

@protocol COLORAdControllerJavaScript <JSExport>

+(instancetype _Null_unspecified)sharedAdController;

-(void)startWithAppIdentifier:(NSString* _Nonnull)appIdentifier;

-(void)prepareAdForPlacement:(NSString* _Nonnull)placement withCompletion:(JSValue* _Nonnull)completion andExpirationHandler:(JSValue* _Nonnull)expiration;

-(void)showLastAdWithCompletionHandler:(JSValue* _Nullable)completion;

-(void)setCurrentPlacement:(NSString* _Nonnull)placement;

-(void)registerThirdPartyUserId:(NSString* _Nonnull)userId withCompletionHandler:(JSValue* _Nonnull)completion;

-(JSValue* _Nonnull)userProfile;

//Content recommendation methods

-(void)trackEvent:(COLORAdFrameworkVideoEventType)eventType forPartnerVideoId:(NSString *_Nonnull)partnerVideoId andSecondsWatched:(NSTimeInterval)secondsWatched;

-(void)prepareRecommendationControllerForPlacement:(NSString* _Nonnull)placement andVideoId:(NSString* _Nonnull)videoId withCompletion:(JSValue* _Nonnull)completion;

-(void)showLastRecommendationWithCompletionHandler:(JSValue* _Nullable)completion;

@end

@protocol COLORAdControllerDelegate <NSObject>

@optional

-(void)didGetCurrency:(NSDictionary * _Null_unspecified)details;

@end

@interface COLORAdController : NSObject<COLORAdControllerJavaScript>

@property (nonatomic, assign) BOOL debugMode;
@property (nonatomic, assign) NSString* _Nonnull currentPlacement;

@property (nonatomic, weak) id<COLORAdControllerDelegate> _Nullable delegate;

@property (nonatomic, strong) NSMutableDictionary* _Nonnull developerSettings;

-(void)monitorAdsForPlacements:(NSArray * _Nullable)placements;

-(BOOL)isAdReady;

-(COLORAdViewController * _Nullable)ad;

-(void)registerThirdPartyUserId:(NSString* _Nonnull)userId withCompletion:(COLORAdFrameworkRegisterThirdPartyUserIdCompletion _Nonnull)completion;

-(void)adViewControllerForPlacement:(NSString* _Nonnull)placement withCompletion:(COLORAdFrameworkAdRequestCompletion _Nonnull)completion expirationHandler:(COLORAdFrameworkAdExpirationHandler _Nonnull)expirationHandler;

-(void)adViewControllerOfType:(COLORAdFrameworkAdType)type withCompletion:(COLORAdFrameworkAdRequestCompletion _Nonnull)completion expirationHandler:(COLORAdFrameworkAdExpirationHandler _Nonnull)expirationHandler;

-(void)checkAvailableCurrencyAfterTimeInterval:(NSTimeInterval)timeInterval;

-(void)contentRecommendationControllerForPlacement:(NSString* _Nonnull)placement andVideoId:(NSString* _Nullable)videoId withCompletion:(COLORAdFrameworkContentRecommendationRequestCompletion _Nonnull)completion;

-(void)nextItemRecommendationControllerForPlacement:(NSString* _Nonnull)placement andVideoId:(NSString* _Nullable)videoId withCompletion:(COLORAdFrameworkNextItemRecommendationRequestCompletion _Nonnull)completion;

@end
