//
//  VideoViewController.h
//  HelloTV
//
//  Created by Jordan Jasinski on 06/02/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

@import UIKit;

@interface VideoViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL isVideoPlaying;

- (void)loadVideoWithURL:(NSURL *)url andId:(NSString *)identifier;
- (void)play;
- (void)pause;

@end
