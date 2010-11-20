//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@class RandomEquation;

@interface EquationViewController : UIViewController {
    UITextField *_equationField;
    bool _clearField;
    AVAudioPlayer *_audioPlayer;
    RandomEquation *_equation;
    NSNumber *_level;
}

- (IBAction) pressedButton:(id)sender; 
- (IBAction) pressedDelete:(id)sender;
- (IBAction) pressedNew:(id)sender;
- (IBAction) pressedSolve:(id)sender;
- (IBAction) pressedView:(id)sender;

@property (nonatomic, retain) IBOutlet UITextField *equationField;
@property (nonatomic) bool clearField;
@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) RandomEquation *equation;
@property (nonatomic, retain) NSNumber *level;

- (void) randomEquation;
- (void)playSound:(NSString *) name;

@end
