//
//  DTFUpgrader.h
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/17/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

typedef NS_ENUM(NSUInteger, DTFUpgraderFailureCode) {
    DTFUpgraderFailureCodeData = 0,
    DTFUpgraderFailureCodeNetwork
};

@class DTFUpgraderError;
@import Foundation;

#ifndef _DTFUpgrader_h
#define _DTFUpgrader_h

@protocol DTFUpgraderDelegate;

@protocol DTFUpgrader <NSObject>

/**
 * Delegate that shall be utilized to handle callbacks
 */
@property (nonatomic, weak) id<DTFUpgraderDelegate>upgraderDelegate;

/**
 * upgradeVersion
 * @abstract: Return a version of the application that the upgrade was written for (1.4.0, 1.4.1 etc...)
 *
 * @param 'NSString' version of the application the upgrade should run for
 */
+ (NSString*)upgradeVersion;

/**
 * runUpgrade
 * @abstract: Run the upgrade provided and then call the completion script once finished
 */
- (void)runUpgrade;

@end

@protocol DTFUpgraderDelegate <NSObject>

/**
 * dtfUpgraderVersionSuccess:
 * @abstract:
 *
 * @param 'upgrader'
 */
- (void)dtfUpgraderVersionSuccess:(id<DTFUpgrader>)upgrader;

/**
 * dtfUpgraderVersionFailure::
 * @abstract:
 *
 * @param 'upgrader'
 * @param 'failure'
 */
- (void)dtfUpgraderVersionFailure:(id<DTFUpgrader>)upgrader failure:(DTFUpgraderError*)failure;

@end

#endif
