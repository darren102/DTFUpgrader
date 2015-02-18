//
//  DTFUpgraderManager.m
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/17/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

#import <objc/runtime.h>
#import "DTFUpgraderManager.h"
#import "DTFUpgraderVersion.h"
#import "DTFUpgraderError.h"
#import "DTFUpgrader.h"

@interface DTFUpgraderManager()<DTFUpgraderDelegate>

/**
 * Version of the application when DTFUpgrader was initially called
 */
@property (nonatomic, copy) NSString *currentApplicationVersion;

/**
 * If first launch the application will just set the version and do nothing else
 */
@property (nonatomic, assign) BOOL isFirstRun;

@property (nonatomic, copy) NSString *currentVersion;
@property (nonatomic, copy) void(^completionHandler)(void);
@property (nonatomic, copy) void(^failureHandler)(DTFUpgraderError*);
@property (nonatomic, strong) NSMutableArray *classImplementations;

@end

@implementation DTFUpgraderManager

- (instancetype)initWithCurrentApplicationVersion:(NSString *)currentApplicationVersion
{
    if ((self = [super init])) {
        _currentApplicationVersion = currentApplicationVersion;
        _isFirstRun = [DTFUpgraderVersion firstUpgraderRun];
        _currentVersion = [DTFUpgraderVersion currentVersion];
        _classImplementations = [NSMutableArray array];
    }
    return self;
}

# pragma mark - Public instance methods (PUBLIC)

- (void)manageApplicationUpgrade:(void (^)(void))complete failure:(void (^)(DTFUpgraderError *))failure
{
    NSCParameterAssert(self.currentApplicationVersion);
    self.completionHandler = complete;
    self.failureHandler = failure;
    
    if (self.isFirstRun) {
        [self runCompletionHandler];
        return;
    }

    NSArray *implementingClasses = [self upgraderImplementingClasses];
    if ([implementingClasses count] > 0) {
        [self sortImplementingClasses:implementingClasses];
        [self runApplicationUpgrades];
        return;
    }
    [self runCompletionHandler];
}

- (BOOL)shouldRunUpgrades
{
    if (self.isFirstRun) {
        [DTFUpgraderVersion setCurrentVersion:self.currentApplicationVersion];
        return NO;
    }
    
    NSArray *implementingClasses = [self upgraderImplementingClasses];
    if ([implementingClasses count] > 0) {
        [self sortImplementingClasses:implementingClasses];
        return [self.classImplementations count] > 0;
    }
    return NO;
}

# pragma mark - DTFUpgraderDelegate instance methods (DTFUPGRADERDELEGATE)

- (void)dtfUpgraderVersionSuccess:(id<DTFUpgrader>)upgrader
{
    [DTFUpgraderVersion setCurrentVersion:[[upgrader class] upgradeVersion]];
    [self.classImplementations removeObject:upgrader];
    upgrader = nil;
    
    if ([self.classImplementations count] > 0) {
        [self runApplicationUpgrades];
        return;
    }
    [self runCompletionHandler];
}

- (void)dtfUpgraderVersionFailure:(id<DTFUpgrader>)upgrader failure:(DTFUpgraderError *)failure
{
    [self runFailureHandler:failure];
}

# pragma mark - Private instance methods (PRIVATE)

- (void)runApplicationUpgrades
{
    if ([self.classImplementations count] > 0) {
        id<DTFUpgrader>upgraderClass = [self.classImplementations firstObject];
        upgraderClass.upgraderDelegate = self;
        [upgraderClass runUpgrade];
        return;
    }
    [self runCompletionHandler];
}

- (void)sortImplementingClasses:(NSArray*)implementingClasses
{
    // Run through the upgrader class instances and determine which need to be run based off the previous version
    for (NSString *className in implementingClasses) {
        Class cls = NSClassFromString(className);
        NSString *upgraderClassVersion = [cls upgradeVersion];
        if ([upgraderClassVersion compare:self.currentVersion options:NSNumericSearch] == NSOrderedDescending) {
            id<DTFUpgrader>upgraderClass = [[cls alloc] init];
            [self.classImplementations addObject:upgraderClass];
        }
    }
    
    if ([self.classImplementations count] > 0) {
        // Sort the upgrader class instances based on their version so we can process in order
        [self.classImplementations sortUsingComparator:^NSComparisonResult(id<DTFUpgrader> obj1, id<DTFUpgrader> obj2) {
            NSString *obj1Version = [[obj1 class] upgradeVersion];
            NSString *obj2Version = [[obj2 class] upgradeVersion];
            return [obj1Version compare:obj2Version options:NSNumericSearch] == NSOrderedDescending;
        }];
    }
}

- (NSArray*)upgraderImplementingClasses
{
    NSMutableArray *implementingClasses = [NSMutableArray array];
    
    unsigned int numClasses = 0;
    Class *classes = objc_copyClassList(&numClasses);
    for (int i = 0; i < numClasses; i++) {
        Class cls = classes[i];
        if (class_conformsToProtocol(cls, @protocol(DTFUpgrader))) {
            [implementingClasses addObject:NSStringFromClass(cls)];
        }
    }
    free(classes);
    return [NSArray arrayWithArray:implementingClasses];
}

- (void)runCompletionHandler
{
    [DTFUpgraderVersion setCurrentVersion:self.currentApplicationVersion];
    if (self.completionHandler) {
        self.completionHandler();
        self.completionHandler = nil;
    }
}

- (void)runFailureHandler:(DTFUpgraderError*)failure
{
    if (self.failureHandler) {
        self.failureHandler(failure);
        self.failureHandler = nil;
    }
}

@end
