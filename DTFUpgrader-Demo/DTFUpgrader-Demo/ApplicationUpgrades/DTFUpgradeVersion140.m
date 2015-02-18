//
//  DTFUpgradeVersion140.m
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/17/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

#import "DTFUpgradeVersion140.h"
#import "DTFUpgrader.h"

@interface DTFUpgradeVersion140()<DTFUpgrader>

@end

@implementation DTFUpgradeVersion140

# pragma mark - DTFUpgrader instance methods (DTFUPGRADER)

+ (NSString*)upgradeVersion
{
    return @"1.4.0";
}

- (void)runUpgrade
{
    NSLog(@"Running upgrade version: %@", [[self class] upgradeVersion]);
    [self.upgraderDelegate dtfUpgraderVersionSuccess:self];
}

@end
