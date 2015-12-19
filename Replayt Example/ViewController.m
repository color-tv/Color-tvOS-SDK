//
//  ViewController.m
//  Replayt Example
//
//  Created by Jordan Jasinski on 14/12/15.
//  Copyright © 2015 Jordan Jasinski. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)showRandomAd:(id)sender {
    [[RPLTAdController sharedAdController] adViewControllerWithCompletion:^(UIViewController * _Nullable vc, NSError * _Nullable error) {
        
        NSLog(@"ViewController: %@", vc);
        NSLog(@"Error: %@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vc animated:YES];
        });
    }];
}

-(IBAction)showAppWall:(id)sender {
    [[RPLTAdController sharedAdController] adViewControllerOfType:RPLTAdFrameworkAdTypeAppWall withCompletion:^(UIViewController * _Nullable vc, NSError * _Nullable error) {
        NSLog(@"ViewController: %@", vc);
        
        if(vc) {
            //        vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //            [self.navigationController pushViewController:vc animated:YES];
                
                [self presentViewController:vc animated:YES completion:^{
                    
                }];
            });
        } else {
            NSLog(@"Error: %@", error);
        }
        
    }];
}

-(IBAction)showInterstitialAd:(id)sender {
    [[RPLTAdController sharedAdController] adViewControllerOfType:RPLTAdFrameworkAdTypeAppSingle withCompletion:^(UIViewController * _Nullable vc, NSError * _Nullable error) {
        NSLog(@"ViewController: %@", vc);
        NSLog(@"Error: %@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vc animated:YES];
        });
    }];
}

-(IBAction)showFullscreenAd:(id)sender {
    NSLog(@"::>> showFullscreenAd");
    [[RPLTAdController sharedAdController] adViewControllerOfType:RPLTAdFrameworkAdTypeFullscreen withCompletion:^(UIViewController * _Nullable vc, NSError * _Nullable error) {
        NSLog(@"ViewController: %@", vc);
        NSLog(@"Error: %@", error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController pushViewController:vc animated:YES];
        });
    }];
}

@end
