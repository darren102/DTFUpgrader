//
//  ViewController.m
//  DTFUpgrader-Demo
//
//  Created by Darren Ferguson on 2/17/15.
//  Copyright (c) 2015 Darren Ferguson. All rights reserved.
//

#import "ViewController.h"
#import "DTFUpgraderManager.h"

@interface ViewController ()

@property (nonatomic, strong) DTFUpgraderManager *upgradeManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];

    self.upgradeManager = [[DTFUpgraderManager alloc] initWithCurrentApplicationVersion:appVersion];
    if ([self.upgradeManager shouldRunUpgrades]) {
        [self.upgradeManager manageApplicationUpgrade:^{
            NSLog(@"Application upgrade completed successfully");
            self.upgradeManager = nil;
        } failure:^(DTFUpgraderError *failureDetails) {
            NSLog(@"Application upgrade failed");
        }];
    }
}

@end
