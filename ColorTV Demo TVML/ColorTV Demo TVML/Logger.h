//
//  Logger.h
//  ColorTV Demo TVML
//
//  Created by Michał Papp on 12.05.2017.
//  Copyright © 2017 Jordan Jasinski. All rights reserved.
//

#import <Foundation/Foundation.h>

@import JavaScriptCore;

@protocol LoggerExport <JSExport>

- (void)log:(NSString *)message;

@end

@interface Logger : NSObject <LoggerExport>

- (instancetype)initWithJSContext:(JSContext *)jsContext;

@end
