//
//  RPLTAdViewController.h
//  RPLTAdFramework
//
//  Created by Jordan Jasinski on 15/12/15.
//  Copyright © 2015 Replay Inc. All rights reserved.
//

@import UIKit;

typedef void(^COLORPreloadedAdViewControllerCompletion)(NSError * _Nullable error);

@protocol COLORPreloadedAdViewController <NSObject>

-(void)preloadAdElementsWithCompletion:(COLORPreloadedAdViewControllerCompletion _Nonnull)completion;

@end

@class COLORAdItem;
@class COLORAdServerAPI;
@class COLORItemClickHandler;

typedef void(^COLORAdViewControllerDidCompleteAd)(BOOL watched);

@interface COLORAdViewController : UIViewController

@property (nonatomic, weak) COLORAdServerAPI * _Nullable api;

@property (nonatomic, readonly) BOOL expired;

-(void)closeAd:(BOOL)watched;

-(void)addCompletionHandler:(COLORAdViewControllerDidCompleteAd _Nonnull)completion;

@end
