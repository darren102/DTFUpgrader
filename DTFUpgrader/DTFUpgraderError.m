//
//  DTFUpgraderError.m
//  
//
//  Created by Darren Ferguson on 2/18/15.
//
//

#import "DTFUpgraderError.h"

@interface DTFUpgraderError()

@property (nonatomic, assign, readwrite) DTFUpgraderFailureCode code;
@property (nonatomic, copy, readwrite) NSString *message;

@end

@implementation DTFUpgraderError

- (instancetype)initWithCode:(DTFUpgraderFailureCode)code message:(NSString *)message
{
    if ((self = [super init])) {
        _code = code;
        _message = message;
    }
    return self;
}

- (NSString*)description
{
    NSMutableString *str = [NSMutableString string];
    [str appendFormat:@"Code: %@\r\n", [self codeToString]];
    [str appendFormat:@"Message: %@\r\n", self.message];
    return [NSString stringWithString:str];
}

- (NSString*)debugDescription
{
    return [self description];
}

# pragma mark - Private instance methods (PRIVATE)

- (NSString*)codeToString
{
    switch (self.code) {
        case DTFUpgraderFailureCodeData:
            return NSLocalizedString(@"Data Upgrade Failure", nil);
        case DTFUpgraderFailureCodeNetwork:
            return NSLocalizedString(@"Network Connection Unavailable", nil);
    }
}

@end
