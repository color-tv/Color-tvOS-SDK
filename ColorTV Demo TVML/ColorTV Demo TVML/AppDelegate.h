//
//  AppDelegate.h
//  ColorTV Demo TVML
//
//  Created by Jordan Jasinski on 02/03/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

@import UIKit;
@import TVMLKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate, TVApplicationControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TVApplicationController * appController;

@end

