//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Alarm;
@class AlarmListController;
@class EditableDetailCell;

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

enum {
    AlarmTitle
};

enum {
    TitleSection
};

typedef NSUInteger AlarmAttribute;

@interface AlarmEditController : UITableViewController <UITextFieldDelegate>
{
    Alarm *_alarm;
    AlarmListController *_listController;
    EditableDetailCell *_titleCell;
    UIDatePicker *_datePicker;
    UILabel *_difficultyLabel;
    UISlider *_difficultySlider;
}

@property (nonatomic, retain) Alarm *alarm;
@property (nonatomic, retain) AlarmListController *listController;
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) EditableDetailCell *titleCell;
@property (nonatomic, retain) UILabel *difficultyLabel;
@property (nonatomic, retain) UISlider *difficultySlider;

- (void)sliderAction:(UISlider*)sender;

- (BOOL)isModal;
-(IBAction)dateChanged;
- (EditableDetailCell *)newDetailCellWithTag:(NSInteger)tag;

- (void)save;
- (void)cancel;

@end
