//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "NeverSnoozeAppDelegate.h"
#import "ClockViewController.h"
#import "AlarmListController.h"
#import "EquationViewController.h"
#import "Alarm.h"

@implementation NeverSnoozeAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;
@synthesize listController = _listController;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    CGRect rect = [[UIScreen mainScreen] bounds];
    UIWindow *window = [[UIWindow alloc] initWithFrame:rect];
    [self setWindow:window];
    
    AlarmListController *tableViewController = [[AlarmListController alloc] 
                                                initWithStyle:UITableViewStylePlain];
    [self setListController:tableViewController];
    
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:tableViewController];
    
    [self setNavigationController:navController];
    
    [window addSubview:[navController view]];
    [window makeKeyAndVisible];
	
    [window release];
    [navController release];
}

- (void)applicationWillResignActive:(UIApplication *)application { }
- (void)applicationDidBecomeActive:(UIApplication *)application { }
- (void)applicationDidEnterBackground:(UIApplication *)application { }
- (void)applicationWillEnterForeground:(UIApplication *)application { }
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    EquationViewController *controller = [[EquationViewController alloc] init];
    
    UINavigationController *newNavController = [[UINavigationController alloc]
                                                initWithRootViewController:controller];
    
    newNavController.navigationBarHidden = YES;
    [_navigationController presentModalViewController:newNavController
                                                   animated:YES];
    
    [controller release];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [_listController save];
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [_navigationController release];
    [_window release];
    [super dealloc];
}

@end
