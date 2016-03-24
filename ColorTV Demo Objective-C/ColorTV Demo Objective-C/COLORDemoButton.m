//
//  COLORButton.m
//  COLORAdFramework
//
//  Created by Jordan Jasinski on 02/03/16.
//  Copyright © 2016 Replay inc. All rights reserved.
//

#import "COLORDemoButton.h"

@interface COLORDemoButton ()

@property (nonatomic, assign) CGSize normalShadowOffset;
@property (nonatomic, assign) CGFloat normalShadowRadius;
@property (nonatomic, assign) CGAffineTransform normalTransform;

@end

@implementation COLORDemoButton

-(void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];

    if(highlighted) {
        self.normalShadowOffset = self.layer.shadowOffset;
        self.normalShadowRadius = self.layer.shadowRadius;
        self.normalTransform = self.transform;

        self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
        self.layer.shadowRadius = 5.0f;
        self.transform = CGAffineTransformMakeScale(1.02f, 1.02f);
    } else {
        self.layer.shadowOffset = self.normalShadowOffset;
        self.layer.shadowRadius = self.normalShadowRadius;
        self.transform = self.normalTransform;
    }
}

@end
