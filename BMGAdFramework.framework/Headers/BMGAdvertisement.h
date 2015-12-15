//
//  BMGAdvertisement.h
//  BMGAdFramework
//
//  Created by Jordan Jasinski on 13.11.2015.
//  Copyright © 2015 Backflip Media Group Inc. All rights reserved.
//

@import Foundation;

#import "BMGAdController.h"

@interface BMGAdvertisement : NSObject

@property (nonatomic, copy) NSString *txId;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) NSDate *validUntil;
@property (nonatomic, assign) BMGAdFrameworkAdType type;
@property (nonatomic, copy) NSURL *moreItemsURL;

-(instancetype)initWithDictionary:(NSDictionary*)dictionary;

-(void)updateWithDictionary:(NSDictionary*)dictionary;

-(NSArray*)items;
-(void)addItemsFromArray:(NSArray*)array;

+(BMGAdFrameworkAdType)typeByString:(NSString*)string;
+(NSString*)stringByType:(BMGAdFrameworkAdType)type;

@end
