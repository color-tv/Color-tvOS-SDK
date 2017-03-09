//
// Created by Michał Ciuba on 20/09/16.
// Copyright (c) 2016 Replay inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol COLORImageStoreProtocol;
@protocol COLORImageDownloadable <NSObject>

@property (nonatomic, readonly, strong) NSURL *downloadableImageURL;
@property (nonatomic, readonly, copy) NSString *identifier;

@optional
@property (readonly) id<COLORImageStoreProtocol> imageStore;

@end
