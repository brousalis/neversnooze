//
//  NeverSnoozeAppDelegate.h
//  NeverSnooze
//
//  Created by pete on 10/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NeverSnoozeViewController;

@interface NeverSnoozeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    NeverSnoozeViewController *viewController;
    
    BOOL idleTimerDisabled;
	BOOL didEnterBackground;
	BOOL wasEnterForeground;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet NeverSnoozeViewController *viewController;

@end
