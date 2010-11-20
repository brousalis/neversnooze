//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "AlarmEditController.h"
#import "EditableDetailCell.h"
#import "Alarm.h"

@implementation AlarmEditController

@synthesize alarm = _alarm;
@synthesize listController = _listController;
@synthesize datePicker = _datePicker;
@synthesize titleCell = _titleCell;
@synthesize difficultyLabel = _difficultyLabel;
@synthesize difficultySlider = _difficultySlider;

- (BOOL)isModal
{
    NSArray *viewControllers = [[self navigationController] viewControllers];
    UIViewController *rootViewController = [viewControllers objectAtIndex:0];
    return rootViewController == self;
}

- (EditableDetailCell *)newDetailCellWithTag:(NSInteger)tag
{
    EditableDetailCell *cell = [[EditableDetailCell alloc] initWithFrame:CGRectZero reuseIdentifier:nil];
    [[cell textField] setDelegate:self];
    [[cell textField] setTag:tag];
    return cell;
}

#pragma mark -
#pragma mark Action Methods

- (void)save
{
    [_alarm setEnabled:YES];
    [_alarm setDifficulty:[NSNumber numberWithFloat:[_difficultySlider value]]];
    [[self listController] addObject:[self alarm]];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)cancel
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)dateChanged
{
    [_alarm setDatetime:[_datePicker date]];
    NSLog(@"%@",[_datePicker date]);
}


#pragma mark -
#pragma mark UIViewController Methods
- (void)loadView
{
    NSLog(@"%@",[NSDate date]);
    [super loadView];
    
    UIDatePicker *theDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0.0, 200.0, 320.0, 216.0)];
    theDatePicker.datePickerMode = UIDatePickerModeTime;
    theDatePicker.timeZone = [NSTimeZone localTimeZone];
    self.datePicker = theDatePicker;
    [theDatePicker release];
    [_datePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    NSLog(@"%@", [_datePicker date]);
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)sliderAction:(UISlider*)sender
{
    [_difficultyLabel setText:[NSString stringWithFormat:@"Math Difficulty: %0.0f", [sender value]]];
    [_alarm setDifficulty:[NSNumber numberWithFloat:round([sender value])]];
}

- (void)viewDidLoad
{
    [[self view] setScrollingEnabled:NO];
    
    if ([self isModal])
    {
        UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                       target:self
                                       action:@selector(save)];
        
        [[self navigationItem] setRightBarButtonItem:saveButton];
        [saveButton release];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] 
                                         initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                         target:self
                                         action:@selector(cancel)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [cancelButton release];
    }
    
    
    _difficultyLabel = [[UILabel alloc] initWithFrame: CGRectMake(18.0, 120.0, 300.0, 20.0)];
    _difficultyLabel.text = [NSString stringWithFormat:@"Math Difficulty: 1"];
    _difficultyLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    _difficultyLabel.textColor = UIColorFromRGB(0x4c566c);
    _difficultyLabel.shadowColor = [UIColor whiteColor];
    _difficultyLabel.shadowOffset =  CGSizeMake(0, 1.0);
    _difficultyLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_difficultyLabel];
    [_difficultyLabel release];
    
    _difficultySlider = [[UISlider alloc] initWithFrame: CGRectMake(8.0, 150.0, 300.0, 20.0)];
    _difficultySlider.minimumValue = 1.0;
    _difficultySlider.maximumValue = 10.0;
    _difficultySlider.tag = 1;
    _difficultySlider.value = 1;
    _difficultySlider.continuous = YES;
    [_difficultySlider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_difficultySlider];
    [_difficultySlider release]; 
    
    [self setTitleCell: [self newDetailCellWithTag:AlarmTitle]];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([_alarm datetime] != nil) {
        [_datePicker setDate:[_alarm datetime] animated:YES];
    } else {
        [_datePicker setDate:[NSDate date] animated:YES];
        [_alarm setDatetime:[NSDate date]];
    }
    
    if ([_alarm title] != nil) 
        [self setTitle:[_alarm title]];
    
    if ([_alarm difficulty] != nil) {
        [_difficultyLabel setText:[NSString stringWithFormat:@"Math Difficulty: %@", [_alarm difficulty]]];
        [_difficultySlider setValue:[[_alarm difficulty] floatValue]];
    }
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark -
#pragma mark UITextFieldDelegate Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{   
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    static NSNumberFormatter *_formatter;
    
    if (_formatter == nil) {
        _formatter = [[NSNumberFormatter alloc] init];
    }
    
    NSString *text = [textField text];
    switch ([textField tag]) {
        case AlarmTitle:     
            [_alarm setTitle:text];          
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField returnKeyType] != UIReturnKeyDone) {
        [textField resignFirstResponder];
    }
    else if ([self isModal]) {
        [self save];
    }
    else {
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
    return YES;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return section == 1 ? 2 : 1;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case TitleSection:  
            return @"Alarm Title";
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EditableDetailCell *cell = nil;
    NSInteger tag = INT_MIN;
    NSString *text = nil;
    NSString *placeholder = nil;
    NSUInteger section = [indexPath section];
    switch (section) 
    {
        case TitleSection:
        {
            cell = [self titleCell];
            text = [_alarm title];
            tag = AlarmTitle;
            placeholder = @"Alarm title";
            break;
        }
    }
    
    UITextField *textField = [cell textField];
    [textField setTag:tag];
    [textField setText:text];
    [textField setPlaceholder:placeholder];
    
    return cell;
}

#pragma mark -

- (void)dealloc
{
    [_datePicker release];
    [_listController release];
    [_alarm release];    
    [_titleCell release];
    [super dealloc];
}

@end
