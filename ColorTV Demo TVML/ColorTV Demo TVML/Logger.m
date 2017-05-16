//
//  Logger.m
//  ColorTV Demo TVML
//
//  Created by Michał Papp on 12.05.2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

#import "Logger.h"

@implementation Logger

- (instancetype)initWithJSContext:(JSContext *)jsContext {
    return [super init];
}

- (void)log:(NSString *)message {
    NSLog(@"[TVJS] %@", message);
}

@end
