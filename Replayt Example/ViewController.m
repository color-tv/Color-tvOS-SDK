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

#pragma mark - exemplary implementation

//Typical implementation within app. Please note that AdViewController should be initiated asynchronously in background and shown when required.
-(IBAction)showRandomAd:(id)sender {
    [[RPLTAdController sharedAdController] adViewControllerWithCompletion:^(RPLTAdViewController * _Nullable vc, NSError * _Nullable error) {
        
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

#pragma mark - presentation functions

//The code placed below is written only for presentation purposes. Please note that developer should not choose type of ad shown based on particular placement mark. It is very unlikely such placement will be available for your application.

-(IBAction)showDiscoveryCenter:(id)sender {
    [[RPLTAdController sharedAdController] setCurrentPlacement:@"TestAppWall"];
    
    //Placement is sent to the server asynchronously. This is only workaround which forces ad sever to present ad of particular type. We do not recommend to use such code in production app.
    sleep(1);
    
    [self showRandomAd:sender];

    [[RPLTAdController sharedAdController] setCurrentPlacement:RPLTAdFrameworkPlacementMainMenu];
}

-(IBAction)showInterstitial:(id)sender {
    [[RPLTAdController sharedAdController] setCurrentPlacement:@"TestInterstitial"];

    //Placement is sent to the server asynchronously. This is only workaround which forces ad sever to present ad of particular type. We do not recommend to use such code in production app.
    sleep(1);

    [self showRandomAd:sender];
    
    [[RPLTAdController sharedAdController] setCurrentPlacement:RPLTAdFrameworkPlacementMainMenu];
}

-(IBAction)showFullscreenAd:(id)sender {
    [[RPLTAdController sharedAdController] setCurrentPlacement:@"TestFullScreen"];

    //Placement is sent to the server asynchronously. This is only workaround which forces ad sever to present ad of particular type. We do not recommend to use such code in production app.
    sleep(1);

    [self showRandomAd:sender];
    
    [[RPLTAdController sharedAdController] setCurrentPlacement:RPLTAdFrameworkPlacementMainMenu];
}

@end
