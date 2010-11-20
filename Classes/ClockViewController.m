//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "ClockViewController.h"
#import "Clock.h"

@implementation ClockViewController

@synthesize clockLabel;
@synthesize myTimer;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark -
#pragma mark Class methods

- (void)registerTimer {
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0 
                                               target:self 
                                             selector:@selector(showActivity) 
                                             userInfo:nil 
                                              repeats:YES];
}

- (void) showActivity {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
    NSDate *date = [NSDate date]; //
    [formatter setTimeStyle:NSDateFormatterMediumStyle]; //00:00:00 AM/PM
    [clockLabel setText:[formatter stringFromDate:date]];
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
