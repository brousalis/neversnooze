//
//  NeverSnoozeViewController.h
//  NeverSnooze
//
//  Created by pete on 10/5/10.
//  Copyright (c) 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NeverSnoozeViewController : UIViewController {
    UILabel *clockLabel;
    NSTimer *myTimer;
}

@property (nonatomic, retain) IBOutlet UILabel *clockLabel;
@property (nonatomic, retain) NSTimer *myTimer;

- (void) runTimer;
- (void) showActivity;

- (void) startTimer:(int)seconds;
- (void) endTimer;
- (void) scheduleAlarm:(int)seconds;
- (void) cancelAlarms;

- (void) showAlert:(NSString *) message;

@end
