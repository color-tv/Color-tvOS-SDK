//
//  COLORAdControllerPrivate.h
//  HelloTV
//
//  Created by Jordan Jasinski on 22/07/16.
//  Copyright © 2016 Jordan Jasinski. All rights reserved.
//

@import COLORAdFramework;

#ifndef COLORAdControllerPrivate_h
#define COLORAdControllerPrivate_h

@interface COLORAdController ()

-(void)adViewControllerForId:(NSUInteger)identifier andPlacement:(NSString* _Nonnull)placement withCompletion:(COLORAdFrameworkAdRequestCompletion _Nonnull)completion expirationHandler:(COLORAdFrameworkAdExpirationHandler _Nonnull)expirationHandler;

@end


#endif /* COLORAdControllerPrivate_h */
