//
//  DTFUpgraderVersion.h
//  
//
//  Created by Darren Ferguson on 2/18/15.
//
//

@import Foundation;

@interface DTFUpgraderVersion : NSObject

/**
 * currentVersion
 * @abstract: Retrieve the current version of the application that DTFUpgrader has reached
 *
 * @return 'NSString' version which DTFUpgrader has upgraded the application too
 */
+ (NSString*)currentVersion;

/**
 * setCurrentVersion:
 * @abstract: Set the current version based on the upgrade that has occurred
 *
 * @param 'NSString' set the new current version based on the upgrade procedure
 */
+ (void)setCurrentVersion:(NSString*)currentVersion __attribute__((nonnull(1)));

/**
 * firstUpgraderRun
 * @abstract: Checks if the upgrader has the version file already created if so then this means it has
 *            Been run previously, if there is no version file the upgrader has not been run previously
 *
 * @return 'BOOL' YES upgrader has not been run previously
 *                NO upgrader has been ran previously
 */
+ (BOOL)firstUpgraderRun;

@end
