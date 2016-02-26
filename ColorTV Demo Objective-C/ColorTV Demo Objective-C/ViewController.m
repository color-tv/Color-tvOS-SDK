//
//  ViewController.m
//  ColorTV Demo Objective-C
//
//  Created by Jordan Jasinski on 26/02/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

#import "ViewController.h"

@import COLORAdFramework;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView *view in self.view.subviews) {
        if([view isKindOfClass:[UIButton class]]) {
            view.layer.cornerRadius = 8.0f;
        }
    }
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
    
    [[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementMainMenu];
}

-(IBAction)showInterstitial:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementStageFailed];
    
    [[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementMainMenu];
}

-(IBAction)showFullscreenAd:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementStageOpen];
    
    [[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementMainMenu];
}

-(IBAction)showVideoAd:(id)sender {
    [self showAdForPlacement:COLORAdFrameworkPlacementLevelUp];
    
    [[COLORAdController sharedAdController] setCurrentPlacement:COLORAdFrameworkPlacementMainMenu];
}

-(void)showAdForPlacement:(NSString*)placement {
    [[COLORAdController sharedAdController] adViewControllerForPlacement:placement withCompletion:^(COLORAdViewController * _Nullable vc, NSError * _Nullable error) {
        
        NSLog(@"ViewController: %@", vc);
        NSLog(@"Error: %@", error);
        
        if(!error && vc) {
            vc.adCompleted = ^{
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


@end
