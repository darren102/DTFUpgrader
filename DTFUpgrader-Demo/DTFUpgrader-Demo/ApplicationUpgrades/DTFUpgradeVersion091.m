//
//  DTFUpgradeVersion091.m
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/18/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

#import "DTFUpgradeVersion091.h"
#import "DTFUpgrader.h"

@interface DTFUpgradeVersion091()<DTFUpgrader>

@end

@implementation DTFUpgradeVersion091

# pragma mark - DTFUpgrader instance methods (DTFUPGRADER)

+ (NSString*)upgradeVersion
{
    return @"0.9.1";
}

- (void)runUpgrade
{
    NSLog(@"Running upgrade version: %@", [[self class] upgradeVersion]);
    [self.upgraderDelegate dtfUpgraderVersionSuccess:self];
}

@end
