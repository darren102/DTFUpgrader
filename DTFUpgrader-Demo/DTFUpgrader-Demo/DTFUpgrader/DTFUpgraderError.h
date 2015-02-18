//
//  DTFUpgraderError.h
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/17/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

@import Foundation;
#import "DTFUpgrader.h"

@interface DTFUpgraderError : NSObject

/**
 * Predefined code that caused the upgrade to fail
 */
@property (nonatomic, assign, readonly) DTFUpgraderFailureCode code;

/**
 * Provides information pertaining to the failure
 */
@property (nonatomic, copy, readonly) NSString *message;

/**
 * Initializer to be called so the error can be initialized correctly
 *
 * @param 'code' predefined code that caused the upgrade to fail
 * @param 'message' provides information pertaining to the failure
 */
- (instancetype)initWithCode:(DTFUpgraderFailureCode)code message:(NSString*)message __attribute__((nonnull(2)));

@end
