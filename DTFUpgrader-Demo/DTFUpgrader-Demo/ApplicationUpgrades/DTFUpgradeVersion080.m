//
//  DTFUpgradeVersion080.m
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/18/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

#import "DTFUpgradeVersion080.h"
#import "DTFUpgrader.h"

@interface DTFUpgradeVersion080()<DTFUpgrader>

@end

@implementation DTFUpgradeVersion080

# pragma mark - DTFUpgrader instance methods (DTFUPGRADER)

+ (NSString*)upgradeVersion
{
    return @"0.8.0";
}

- (void)runUpgrade
{
    NSLog(@"Running upgrade version: %@", [[self class] upgradeVersion]);
    [self.upgraderDelegate dtfUpgraderVersionSuccess:self];
}

@end
