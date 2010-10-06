//
//  NeverSnoozeViewController.m
//  NeverSnooze
//
//  Created by pete on 10/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "NeverSnoozeViewController.h"

@implementation NeverSnoozeViewController

@synthesize clockLabel;
@synthesize myTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self runTimer];
    [self scheduleAlarm:3];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Class methods

- (void) runTimer {
    myTimer = [NSTimer scheduledTimerWithTimeInterval: 0.5 target: self selector: @selector(showActivity) userInfo: nil repeats: YES];
}

- (void) showActivity {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = [NSDate date];
    [formatter setTimeStyle:NSDateFormatterMediumStyle]; //fullstyle
    [clockLabel setText:[formatter stringFromDate:date]];
}

- (void) showAlert:(NSString*)message { 
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (void) startTimer:(int) seconds {
	[self scheduleAlarm:seconds];
	[self disableAutoLock:YES];
    [self enableDim:YES];
}

- (void) endTimer
{
	[[UIDevice currentDevice] setProximityMonitoringEnabled:NO];	
	[self cancelAlarms];
	[self showAlert:@"Alarm!"];
}

- (void) disableAutoLock: (BOOL) disabled {
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES]; 
}

- (void) enableDim:(BOOL) enabled {
    [[UIDevice currentDevice] setProximityMonitoringEnabled:enabled];
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
			alarm.alertBody = @"Time is up!";
			[[UIApplication sharedApplication] scheduleLocalNotification:alarm];
		}
	}
	else {
		[self performSelector:@selector(endTimer) withObject:nil afterDelay:seconds];
	}
}

- (void) cancelAlarms {
	if (NSClassFromString(@"UILocalNotification")) {	
		UIApplication *app = [UIApplication sharedApplication];
		NSArray *oldNotifications = [app scheduledLocalNotifications];
		
		if ([oldNotifications count] > 0)
			[app cancelAllLocalNotifications];	
	}
	else  {
		// unschedule timers
		[NSTimer cancelPreviousPerformRequestsWithTarget:self selector:@selector(EndTimer) object:nil];
	}
	
}

#pragma mark -
#pragma mark Unload the application

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)dealloc {
    [super dealloc];
}


@end
