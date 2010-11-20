//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alarm : NSObject 
{
    NSString *_title;
    BOOL _enabled;
    NSDate *_datetime;
    NSNumber *_difficulty;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, readwrite) BOOL enabled;
@property (nonatomic, retain) NSDate *datetime;
@property (nonatomic, retain) NSNumber *difficulty;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
