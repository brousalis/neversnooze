//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "Alarm.h"

@implementation Alarm

@synthesize title = _title;
@synthesize enabled = _enabled;
@synthesize datetime = _datetime;
@synthesize difficulty = _difficulty;

- (void)dealloc
{
    [_title release];
    [_datetime release];
    [_difficulty release];
    [super dealloc];
}

#pragma mark -
#pragma mark Message

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    [self setValuesForKeysWithDictionary:dictionary];
    return self;
}

- (NSString *)description
{
    NSArray *keys = [NSArray arrayWithObjects:
                     @"title",
                     @"enabled",
                     @"datetime",
                     @"difficulty",
                     nil];
    return [[self dictionaryWithValuesForKeys:keys] description];
}

@end
