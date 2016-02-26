//
//  RPLTAdControllerLogger.h
//  RPLTAdFramework
//
//  Created by Jordan Jasinski on 22/12/15.
//  Copyright © 2015 Replay inc. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSInteger, RPLTAdFrameworkDebugLevel) {
    RPLTAdFrameworkDebugLevelInfo = 4,
    RPLTAdFrameworkDebugLevelNotice = 3,
    RPLTAdFrameworkDebugLevelWarning = 2,
    RPLTAdFrameworkDebugLevelError = 1
};

@interface RPLTAdFrameworkLogger : NSObject

+(void)setDebugLevel:(RPLTAdFrameworkDebugLevel)level;

+(void)logInfoWithFormat:(NSString*)format, ... NS_FORMAT_FUNCTION(1, 2);

+(void)logNoticeWithFormat:(NSString*)format, ... NS_FORMAT_FUNCTION(1, 2);

+(void)logWarningWithFormat:(NSString*)format, ... NS_FORMAT_FUNCTION(1, 2);

+(void)logErrorWithFormat:(NSString*)format, ... NS_FORMAT_FUNCTION(1, 2);

@end
