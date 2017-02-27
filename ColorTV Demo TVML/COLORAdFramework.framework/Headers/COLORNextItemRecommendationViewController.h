//
//  COLORNextItemRecommendationViewController.h
//  COLORAdFramework
//
//  Created by Jordan Jasinski on 16/01/2017.
//  Copyright © 2017 Color Media Group. All rights reserved.
//

@import UIKit;

@interface COLORNextItemRecommendationViewController : UIViewController

@property (nonatomic, copy) void (^_Nullable itemSelected)(NSString * _Nonnull videoId, NSURL * _Nonnull videoURL, NSDictionary * _Nullable parameters);

@end
