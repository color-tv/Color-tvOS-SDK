//
//  ViewController.m
//  ColorTV Demo Objective-C
//
//  Created by Jordan Jasinski on 26/02/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

#import "ViewController.h"

@import COLORAdFramework;

@interface ViewController ()<COLORAdControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //when user gets virtual currency your application will be notified in order to assign currency to user account and possible take other desired action. Please not that delegate and NotificationCenter are alternatives to each other.
    [COLORAdController sharedAdController].delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:COLORAdFrameworkNotificationDidGetCurrency object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"didGetCurrency: %@", note.userInfo);
    }];
    
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            view.layer.cornerRadius = 8.0f;
        }
    }
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //update profile information to better target ads.
    COLORUserProfile *profile = [COLORUserProfile sharedProfile];
    [profile reset]; //reset current profile if user is switched in your application.
    profile.age = 30;
    profile.gender = @"female"; //male or female are expected here
    //keywords which may charactirize your audience. It is used to better target ad.
    [profile addKeyword:@"aviation"];
    [profile addKeyword:@"airplane"];
    [profile addKeyword:@"airport"];
    
    //report current placement. You can call it from time to time when you believe it is important to notify our server about state of your app.
    [[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementMainMenu];
}

#pragma mark - exemplary implementation

//Typical implementation within app. Please note that AdViewController should be initiated asynchronously in background and shown when required.
-(IBAction)showRandomAd:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementInAppPurchaseAbandoned];
}

#pragma mark - presentation functions

//The code placed below is written only for presentation purposes. Please note that developer should not choose type of ad shown based on particular placement mark. It is very unlikely such placement will be available for your application.

-(IBAction)showDiscoveryCenter:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementMainMenu];
}

-(IBAction)showInterstitial:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementStageFailed];
}

-(IBAction)showFullscreenAd:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementStageOpen];
}

-(IBAction)showVideoAd:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementLevelUp];
}

-(void)showAdForPlacement:(NSString*)placement {
    [[COLORAdController sharedAdController] adViewControllerForPlacement:placement withCompletion:^(COLORAdViewController * _Nullable vc, NSError * _Nullable error) {
        
        NSLog(@"ViewController: %@", vc);
        NSLog(@"Error: %@", error);
        
        if(!error && vc) {
            vc.adCompleted = ^{
                NSLog(@"::>> AdCompleted callback!!!!! ----------");
                dispatch_async(dispatch_get_main_queue(), ^{
                    //[self.navigationController popViewControllerAnimated:YES];
                    [self dismissViewControllerAnimated:YES completion:^{
                        
                    }];
                });
            };
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
                //[self.navigationController pushViewController:vc animated:YES];
            });
            
        }
    }];
}

#pragma mark - focus updates

-(void)didUpdateFocusInContext:(UIFocusUpdateContext *)context withAnimationCoordinator:(UIFocusAnimationCoordinator *)coordinator {
    
    if ([context.nextFocusedView isKindOfClass:[UIButton class]]) {
        [coordinator addCoordinatedAnimations:^{
            context.nextFocusedView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
            context.nextFocusedView.layer.shadowColor = [[UIColor blackColor] CGColor];
            context.nextFocusedView.layer.shadowOpacity = 0.3f;
            context.nextFocusedView.layer.shadowRadius = 15.0f;
            context.nextFocusedView.layer.shadowOffset = CGSizeMake(20.0f, 20.0f);
        } completion:nil];
    }

    if ([context.previouslyFocusedView isKindOfClass:[UIButton class]]) {
        [coordinator addCoordinatedAnimations:^{
            context.previouslyFocusedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            context.previouslyFocusedView.layer.shadowColor = [[UIColor clearColor] CGColor];
            context.previouslyFocusedView.layer.shadowOpacity = 0.0f;

        } completion:nil];
    }

}

#pragma mark - button state updates

-(IBAction)buttonPressed:(UIButton*)btn {
    NSLog(@"::>> btn pressed");
}

-(IBAction)buttonReleased:(UIButton*)btn {
    NSLog(@"::>> btn released");
}

#pragma mark - virtual currency support

-(void)didGetCurrency:(NSDictionary *)details {
    NSLog(@"didGetCurrency: %@", details);
}

@end
