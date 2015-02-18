//
//  DTFUpgraderManager.h
//  
//
//  Created by Darren Ferguson on 2/18/15.
//
//

@import Foundation;
@class DTFUpgraderError;

@interface DTFUpgraderManager : NSObject

/**
 * Initializer for the DTFUpgraderManager
 *
 * @param 'currentApplicationVersion'
 * @param 'firstLaunch'
 */
- (instancetype)initWithCurrentApplicationVersion:(NSString*)currentApplicationVersion __attribute__((nonnull(1)));

/**
 * manageApplicationUpgrade::
 * @abstract: Perform the application upgrade
 *
 * @param 'complete' block to call if the application was upgraded successfully
 * @param 'failure' block to call if the application upgraders fails
 */
- (void)manageApplicationUpgrade:(void(^)(void))complete failure:(void(^)(DTFUpgraderError*))failure __attribute__((nonnull(1, 2)));

/**
 * shouldRunUpgrades
 * @abstract:
 *
 * @return 'BOOL' YES upgrades need to be ran
 *                NO upgrades do not need to be ran
 */
- (BOOL)shouldRunUpgrades;

@end
