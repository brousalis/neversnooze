//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "AlarmListController.h"
#import "AlarmEditController.h"
#import "EquationViewController.h"
#import "Alarm.h"

@implementation AlarmListController

@synthesize displayedObjects = _displayedObjects;
@synthesize temptitle = _temptitle;
@synthesize tempdatetime = _tempdatetime;
@synthesize tempindex = _tempindex;

#pragma mark -

- (void)dealloc
{
    [_displayedObjects release];
    [super dealloc];
}

+ (NSString *)pathForDocumentWithName:(NSString *)documentName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, 
                                                         YES);
    NSString *path = [paths objectAtIndex:0];
    return [path stringByAppendingPathComponent:documentName];
}

- (NSMutableArray *)displayedObjects
{
    if (_displayedObjects == nil)
    {
        NSString *path = [[self class] pathForDocumentWithName:@"Alarms.plist"];
        NSArray *alarmDicts = [NSMutableArray arrayWithContentsOfFile:path];
        
        if (alarmDicts == nil)
        {
            NSLog(@"Unable to read plist file: %@", path);
            path = [[NSBundle mainBundle] pathForResource:@"Alarms"
                                                   ofType:@"plist"];
            alarmDicts = [NSMutableArray arrayWithContentsOfFile:path];
        }
        
        _displayedObjects = [[NSMutableArray alloc]
                             initWithCapacity:[alarmDicts count]];
        
        for (NSDictionary *currDict in alarmDicts)
        {
            Alarm *alarm = [[Alarm alloc] initWithDictionary:currDict];
            [_displayedObjects addObject:alarm];
        }
    }
    
    return _displayedObjects;
}

- (void)addObject:(id)anObject
{
    if (anObject != nil)
    {
        [[self displayedObjects] addObject:anObject];
    }
}

- (void)save
{
    NSString *path = [[self class] pathForDocumentWithName:@"Alarms.plist"];
    NSString *plist = [[self displayedObjects] description];
    
    NSError *error = nil;
    [plist writeToFile:path
            atomically:YES
              encoding:NSUTF8StringEncoding
                 error:&error];
    if (error)
    {
        NSLog(@"Error writing file at path: %@; error was %@", path, error);
    }
}

#pragma mark -
#pragma mark UIViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Alarms"];
    [[self tableView] setRowHeight:90.0];
    [[self tableView] setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"alarmbg.png"]]];

    [[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];

    //  Configure the Edit button
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    //  Configure the Add button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                  target:self
                                  action:@selector(add)];
    
    [[self navigationItem] setRightBarButtonItem:addButton];
    [addButton release];
}


- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing
             animated:animated];
    
    UIBarButtonItem *editButton = [[self navigationItem] rightBarButtonItem];
    [editButton setEnabled:!editing];
}

#pragma mark -
#pragma mark Action Methods

- (void)add
{
    AlarmEditController *controller = [[AlarmEditController alloc]
                                      initWithStyle:UITableViewStyleGrouped];
    
    id alarm = [[Alarm alloc] init];
    
    //Set the alarm object in view controller
    [controller setAlarm:alarm];
    [controller setListController:self];
    
    UINavigationController *newNavController = [[UINavigationController alloc]
                                                initWithRootViewController:controller];
    
    [[self navigationController] presentModalViewController:newNavController
                                                   animated:YES];
    
    [alarm release];
    [controller release];
}

#pragma mark -
#pragma mark UITableViewDelegate Protocol

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //Edit
//    AlarmEditController *controller = [[AlarmEditController alloc]
//                                      initWithStyle:UITableViewStyleGrouped];
//    
//    NSUInteger index = [indexPath row];
//    id alarm = [[self displayedObjects] objectAtIndex:index];
//    
//    //Set the alarm object in view controller
//    [controller setAlarm:alarm];
//    [controller setListController:self];
//    
//    [[self navigationController] pushViewController:controller
//                                           animated:YES];
//	[controller release];
    
    EquationViewController *controller = [[EquationViewController alloc] init];
    
    [self presentModalViewController:controller
                                             animated:YES];
    
    [controller release];

}

#pragma mark -
#pragma mark UITableViewDataSource Protocol
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self displayedObjects] count];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)targetIndexPath
{
    NSUInteger sourceIndex = [sourceIndexPath row];
    NSUInteger targetIndex = [targetIndexPath row];
    
    if (sourceIndex != targetIndex)
    {
        [[self displayedObjects] exchangeObjectAtIndex:sourceIndex
                                     withObjectAtIndex:targetIndex];
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [[self displayedObjects] removeObjectAtIndex:[indexPath row]];
        
        //  Animate deletion
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [[self tableView] deleteRowsAtIndexPaths:indexPaths
                                withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:@"MyCell"];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        
        // Detail Text    
        UIFont *titleFont = [UIFont fontWithName:@"Helvetica-Bold" size:24.0];
        [[cell textLabel] setFont:titleFont];
        
        [cell autorelease];
    }
    
    UIView* backgroundView = [ [ [ UIView alloc ] initWithFrame:CGRectZero ] autorelease ];
    backgroundView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed: @"bg.png"]];
    cell.backgroundView = backgroundView;
    for (UIView *view in cell.contentView.subviews) {
        view.backgroundColor = [UIColor clearColor];
    }

    NSUInteger index = [indexPath row];
    _tempindex = index;
    id alarm = [[self displayedObjects] objectAtIndex:index];
    
    NSString *title = [alarm title];
    _temptitle = title;
    [[cell detailTextLabel] setText:[NSString stringWithFormat:@"%@ - Difficulty %@", (title == nil || [title length] < 1 ? @"?" : title), [alarm difficulty]]];
    [cell detailTextLabel].backgroundColor = [UIColor clearColor];
    
    // Datetime
    NSDate *datetime = [alarm datetime];    
    _tempdatetime = datetime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a"];
    [[cell textLabel] setText:[formatter stringFromDate:datetime]];
    [cell textLabel].backgroundColor = [UIColor clearColor];
    [formatter release];

    // Switch
    UISwitch *enabledSwitch = [[[UISwitch alloc] initWithFrame:CGRectZero] autorelease];
    [cell addSubview:enabledSwitch];
    cell.accessoryView = enabledSwitch;
    if([alarm enabled]) {
        [self scheduleAlarmForDate:datetime withMessage:title];
        [enabledSwitch setOn:YES];
    } else {
        [enabledSwitch setOn:NO];
    }
    
    [(UISwitch *)cell.accessoryView addTarget:self 
                                       action:@selector(toggleAlarmStatus:)
                             forControlEvents:UIControlEventValueChanged];
    
    return cell;
}

-(void)cancelAlarm:(NSUInteger) index
{
    // Delete the row from the data source
    UIApplication* app = [UIApplication sharedApplication];
    NSArray *oldNotifs = [app scheduledLocalNotifications];
    [app cancelLocalNotification:[oldNotifs objectAtIndex:index]];
    NSLog(@"%d alarm canceled", index);
}

- (void)scheduleAlarmForDate:(NSDate*)date withMessage:(NSString *)message
{
    UIApplication* app = [UIApplication sharedApplication];
	
    // Create a new notification
    UILocalNotification* alarm = [[[UILocalNotification alloc] init] autorelease];
    if (alarm)
    {
        alarm.fireDate = date;
        alarm.timeZone = [NSTimeZone localTimeZone];
        alarm.repeatInterval = 0;
        alarm.soundName = @"alarm_clock_2.wav";
        alarm.alertBody = message;
        [app scheduleLocalNotification:alarm];
    }
}

-(void) toggleAlarmStatus:(id)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    NSComparisonResult result = [_tempdatetime compare:[NSDate date]];
    if(result == NSOrderedDescending && result != NSOrderedSame) {
        if(tempSwitch.on) {
            NSLog(@"ON: %@", _tempdatetime);
            [self scheduleAlarmForDate:_tempdatetime withMessage:_temptitle];
        } else {
            NSLog(@"OFF");
            [self cancelAlarm:_tempindex];
        }
    }
}

@end
