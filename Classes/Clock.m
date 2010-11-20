//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "Clock.h"

static Clock * _sharedClock = nil;

@implementation Clock

@synthesize delegate;

#pragma mark -
#pragma mark Clock methods

- (void) startTimer:(int) seconds {
	[self scheduleAlarm:seconds];
}

- (void) endTimer {
	[self cancelAlarms];
}

#pragma mark -
#pragma mark Message

- (void) scheduleAlarm:(int)seconds {
	[self cancelAlarms];
    
	if (NSClassFromString(@"UILocalNotification")) {	
		UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
		if (alarm) {
			alarm.fireDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
			alarm.timeZone = [NSTimeZone defaultTimeZone];
			alarm.repeatInterval = 0;
			alarm.alertBody = @"Time is up";
			[[UIApplication sharedApplication] scheduleLocalNotification:alarm];
		}
	}
	else {
		[self performSelector:@selector(endTimer) withObject:nil afterDelay:seconds];
	}
}

/*- (void) scheduleAlarmAtDate:(NSDate *)date {
	[self cancelAlarms];
    
	if (NSClassFromString(@"UILocalNotification")) {	
		UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
		if (alarm) {
			alarm.fireDate = date;
			alarm.timeZone = [NSTimeZone defaultTimeZone];
			alarm.repeatInterval = 0;
			alarm.alertBody = @"Time is up";
			[[UIApplication sharedApplication] scheduleLocalNotification:alarm];
		}
	}
	else {
		[self performSelector:@selector(endTimer) withObject:nil afterDelay:seconds];
	}    
}*/

- (void) cancelAlarms {
	if (NSClassFromString(@"UILocalNotification")) {	
		UIApplication *app = [UIApplication sharedApplication];
		NSArray *oldNotifications = [app scheduledLocalNotifications];
		if ([oldNotifications count] > 0)
			[app cancelAllLocalNotifications];	
	}
	else  {
		[NSTimer cancelPreviousPerformRequestsWithTarget:self selector:@selector(endTimer) object:nil];
	}
	
}

#pragma mark -
#pragma mark Singleton methods - Thanks Tim!

+ (Clock *)sharedClock {
    @synchronized(self) {
        if(_sharedClock == nil) {
            _sharedClock = [[Clock alloc] init];
        }
    }
    return _sharedClock;
}

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if(_sharedClock == nil) {
            _sharedClock = [super allocWithZone:zone];
            return _sharedClock;
        }
    }
    return nil;
}

- (id)retain {
    return self;
}

- (unsigned int)retainCount {
    return UINT_MAX;
}

- (void)release {
    // nothing
}

- (id)autorelease {
    return self;
}

@end
