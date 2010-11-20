//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClockDelegate.h"

@interface ClockViewController : UIViewController <ClockDelegate> {
    UILabel *clockLabel;
    NSTimer *myTimer;
}

@property (nonatomic, retain) NSTimer *myTimer;
@property (nonatomic, retain) IBOutlet UILabel *clockLabel;

- (void) showActivity;

@end