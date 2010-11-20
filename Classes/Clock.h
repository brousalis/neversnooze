//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ClockDelegate.h"

@interface Clock : NSObject {
    id<ClockDelegate> delegate;
}

@property (nonatomic, assign) id<ClockDelegate> delegate;

+ (Clock *)sharedClock;

- (void) startTimer:(int)seconds;
- (void) endTimer;
- (void) scheduleAlarm:(int)seconds;
//- (void) scheduleAlarmAtDate:(NSDate *)date;
- (void) cancelAlarms;

- (void) runTimer;

@end
