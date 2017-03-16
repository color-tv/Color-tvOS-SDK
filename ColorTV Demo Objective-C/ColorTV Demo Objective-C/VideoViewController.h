//
//  VideoViewController.h
//  HelloTV
//
//  Created by Jordan Jasinski on 06/02/2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

@import UIKit;
@import AVFoundation;

@interface VideoViewController : UIViewController

@property (nonatomic, assign, readonly) BOOL isVideoPlayed;

-(void)loadVideoWithURL:(NSURL*)url andId:(NSString*)identifier;
-(void)play;
-(void)pause;

@end
