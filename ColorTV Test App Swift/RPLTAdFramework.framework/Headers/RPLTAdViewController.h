//
//  RPLTAdViewController.h
//  RPLTAdFramework
//
//  Created by Jordan Jasinski on 15/12/15.
//  Copyright © 2015 Replay Inc. All rights reserved.
//

@import UIKit;

typedef void(^RPLTPreloadedAdViewControllerCompletion)(NSError * _Nullable error);

@protocol RPLTPreloadedAdViewController <NSObject>

-(void)preloadAdElementsWithCompletion:(RPLTPreloadedAdViewControllerCompletion _Nonnull)completion;

@end

@interface RPLTAdViewController : UIViewController

@property (nonatomic, copy) void (^_Nullable adCompleted)();

@end
