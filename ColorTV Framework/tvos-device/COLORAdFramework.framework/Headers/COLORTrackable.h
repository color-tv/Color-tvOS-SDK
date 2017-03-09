//
// Created by Michał Ciuba on 29/09/16.
// Copyright (c) 2016 Replay inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol COLORTrackable <NSObject>

@property (nonatomic, copy, readonly) NSURL *impressionURL;
@property (nonatomic, copy, readonly) NSURL *clickTracker;

@property (nonatomic, assign, readwrite) BOOL impressionMarked;

@end
