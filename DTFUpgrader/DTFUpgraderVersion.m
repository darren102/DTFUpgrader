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
    if (![currentVersion writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error]) {
        if (error) {
            NSLog(@"Error Setting Current Version: %@, %@", currentVersion, [error localizedDescription]);
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
    static NSString *path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // Compose a path to the Library/DTFUpgrader directory
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
        path = [libraryPath stringByAppendingPathComponent:kDTFUpgraderPathComponent];
        
        // Ensure the database directory exists
        NSFileManager *manager = [NSFileManager defaultManager];
        BOOL isDirectory;
        if (![manager fileExistsAtPath:path isDirectory:&isDirectory] || !isDirectory) {
            NSError *error = nil;
            NSDictionary *attr = [NSDictionary dictionaryWithObject:NSFileProtectionComplete
                                                             forKey:NSFileProtectionKey];
            [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:attr error:&error];
            if (error) {
                NSLog(@"Error creating directory path: %@", [error localizedDescription]);
            }
        }
    });
    return path;
    
}

@end
