//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLIST_FILENAME @"Alarms.plist"

@class AlarmEditController;

@interface AlarmListController : UITableViewController 
{
    NSMutableArray *_displayedObjects;
    NSString *_temptitle;
    NSDate *_tempdatetime;
    NSUInteger _tempindex;
}

- (void)scheduleAlarmForDate:(NSDate*)date withMessage:(NSString *)message;
-(void)cancelAlarm:(NSUInteger) index;
-(void) toggleAlarmStatus:(id)sender;

@property (nonatomic, retain) NSMutableArray *displayedObjects;
@property (nonatomic, retain) NSString *temptitle;
@property (nonatomic, retain) NSDate *tempdatetime;
@property (nonatomic, readwrite) NSUInteger tempindex;
- (void)add;
- (void)save;
- (void)addObject:(id)anObject;

@end
