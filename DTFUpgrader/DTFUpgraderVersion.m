//
//  DTFUpgraderVersion.m
//  
//
//  Created by Darren Ferguson on 2/18/15.
//
//

#import "DTFUpgraderVersion.h"

static NSString *const kDTFUpgraderInitialVersion = @"0.0.1";
static NSString *const kDTFUpgraderPathComponent = @"DTFUpgrader";
static NSString *const kDTFUpgraderVersionFile = @"DTFUpgrader.version";

@implementation DTFUpgraderVersion

# pragma mark - Public class methods (PUBLIC-CLASS)

+ (NSString*)currentVersion
{
    NSString *filePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDTFUpgraderVersionFile];
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        if (![kDTFUpgraderInitialVersion writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
            if (error) {
                NSLog(@"Error Setting Initial Version: %@", [error localizedDescription]);
            }
        }
        return kDTFUpgraderInitialVersion;
    }
    NSData *versionInfo = [[NSFileManager defaultManager] contentsAtPath:filePath];
    return [[NSString alloc] initWithData:versionInfo encoding:NSUTF8StringEncoding];
}

+ (void)setCurrentVersion:(NSString*)currentVersion
{
    NSCParameterAssert(currentVersion);
    NSError *error = nil;
    NSString *filePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDTFUpgraderVersionFile];
    if (filePath) {
        if (![currentVersion writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
            if (error) {
                NSLog(@"Error Setting Current Version: %@, %@", currentVersion, [error localizedDescription]);
            }
        }
    }
}

+ (BOOL)firstUpgraderRun
{
    NSString *filePath = [[self sharedDocumentsPath] stringByAppendingPathComponent:kDTFUpgraderVersionFile];
    return ![[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

# pragma mark - Private class methods (PRIVATE-CLASS)

+ (NSString*)sharedDocumentsPath
{
    // Compose a path to the Documents/DTFUpgrader directory
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *path = [documentsPath stringByAppendingPathComponent:kDTFUpgraderPathComponent];
    
    // Ensure the database directory exists
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    if (![manager fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory) {
        NSError *error = nil;
        if (![manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            if (error) {
                NSLog(@"Error creating directory path: %@", [error localizedDescription]);
            }
            return nil;
        }
    }
    return path;
}

@end
