//
// Created by Michał Ciuba on 22/02/16.
// Copyright (c) 2016 Replay inc. All rights reserved.
//

@import UIKit;
@import Foundation;

@protocol COLORGridCell <NSObject>

@property (nonatomic, readonly, weak) UIImageView *adImageView;

-(void)prepareForFocusedState;
-(void)prepareForUnfocusedState;

@optional

@property (nonatomic, weak) UIImageView *adBackgroundView;
@property (nonatomic, weak) UIImageView *logoImageView;

@end