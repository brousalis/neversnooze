//
//  NeverSnoozeAppDelegate.m
//  NeverSnooze
//
//  Created by pete on 10/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import "NeverSnoozeAppDelegate.h"
#import "NeverSnoozeViewController.h"

@implementation NeverSnoozeAppDelegate

@synthesize window, viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
    wasEnterForeground = NO;
	didEnterBackground = NO;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application { }
- (void)applicationDidBecomeActive:(UIApplication *)application { }
- (void)applicationDidEnterBackground:(UIApplication *)application {
	didEnterBackground = YES;
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
	wasEnterForeground = YES;
}
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
	if (wasEnterForeground || didEnterBackground) {
		wasEnterForeground = NO;
		didEnterBackground = NO;
	}
	else {
		[viewController endTimer];
		didEnterBackground = NO;
	}
}

- (void)applicationWillTerminate:(UIApplication *)application {	
	
}

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

@end
