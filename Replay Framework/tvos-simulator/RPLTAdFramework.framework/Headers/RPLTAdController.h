//
//  BMGAdController.h
//  BMGAdFramework
//
//  Created by Jordan Jasinski on 12.11.2015.
//  Copyright © 2015 Backflip Media Group Inc. All rights reserved.
//

@import UIKit;

#import "RPLTAdViewController.h"

#import "RPLTConstans.h"

@protocol RPLTAdControllerDelegate <NSObject>

@optional

-(void)didGetCurrency:(NSDictionary * _Null_unspecified)details;

@end

@interface RPLTAdController : NSObject

@property (nonatomic, assign) BOOL debugMode;
@property (nonatomic, assign) NSString* _Nonnull currentPlacement;

@property (nonatomic, weak) id<RPLTAdControllerDelegate> _Nullable delegate;

+(instancetype _Null_unspecified)sharedAdController;

-(void)startWithAppIdentifier:(NSString* _Nonnull)appIdentifier;

-(void)adViewControllerWithCompletion:(RPLTAdFrameworkAdRequestCompletion _Nonnull)completion;
-(void)adViewControllerOfType:(RPLTAdFrameworkAdType)type withCompletion:(RPLTAdFrameworkAdRequestCompletion _Nonnull)completion;

@end
