//
//    ___ ___ _ _ ___ ___ ___ ___ ___ ___ ___ ___ 
//   |   | -_| | | -_|  _|_ -|   | . | . |- _| -_|
//   |_|_|___|\_/|___|_| |___|_|_|___|___|___|___|
//
//  Created by pete on 10/11/10.
//  Copyright (c) 2010 Brousalis Enterprises, LLC. All rights reserved.
//

#import "EquationViewController.h"
#import "RandomEquation.h"

@implementation EquationViewController

@synthesize equationField = _equationField;
@synthesize clearField = _clearField;
@synthesize audioPlayer = _audioPlayer;
@synthesize equation = _equation;
@synthesize level = _level;

- (void)playSound:(NSString *) name {
    NSString *spath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:name];
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:spath] error:nil];
    _audioPlayer.numberOfLoops = -1; // set to -1 to loop repeated
    _audioPlayer.volume = 1.0; // value is from 0 to 1.0 (float)
    [_audioPlayer play]; // play
}

- (void)viewDidLoad 
{
    [super viewDidLoad];
    [self randomEquation];
    [self playSound:@"alarm_clock_2.wav"];
}

- (void) randomEquation {
    _equation = [[RandomEquation alloc] initWithLevel:1];
    [_equationField setText:[_equation description]];
    [self setClearField:NO];
}

#pragma mark -
#pragma mark Actions

- (IBAction) pressedSolve:(id)sender
{
    if([_equationField.text isEqualToString:[NSString stringWithFormat:@"%d",[_equation solve]]]) {
        [_audioPlayer stop];
        [self dismissModalViewControllerAnimated:YES];
    } else {
        _equationField.textColor = [UIColor redColor];
        _equationField.text = @"WRONG";
        [self performSelector:@selector(randomEquation:) withObject:nil afterDelay:2];
    }
}

- (IBAction) pressedView:(id)sender
{
    _equationField.text = [NSString stringWithFormat:@"%d",[_equation solve]];
    _equationField.textColor = [UIColor redColor];
}

- (IBAction) pressedNew:(id)sender
{
    [self randomEquation];
    _equationField.textColor = UIColorFromRGB(0x5e502c);
}

- (IBAction) pressedButton:(id)sender 
{
    UIButton *clickedButton = (UIButton *) sender;
    NSInteger buttonNumber = clickedButton.tag;
    
    _equationField.textColor = UIColorFromRGB(0x5e502c);
    
    if(_clearField == NO) {
        [self setClearField:YES];
        _equationField.text = @"";
    }
    
    NSMutableString *textFieldString = [[NSMutableString alloc] init];
    [textFieldString appendString:_equationField.text];
    [textFieldString appendString:[NSString stringWithFormat:@"%i", buttonNumber]];
    _equationField.text = textFieldString;
    [textFieldString release];
}

- (IBAction) pressedDelete:(id)sender
{
    NSMutableString *textFieldString = [[NSMutableString alloc] initWithString:_equationField.text];

    if([textFieldString length] > 0) {
        NSMutableString *textFieldReplaceString = [[NSMutableString alloc] initWithString:[textFieldString substringWithRange:NSMakeRange([textFieldString length]-1,1)]];
        if ([textFieldReplaceString isEqualToString:@" "]) { 
        _equationField.text = [textFieldString substringToIndex:[textFieldString length] - 2];
        } else {
            _equationField.text = [textFieldString substringToIndex:[textFieldString length] - 1];
        }
        [textFieldReplaceString release];
    }

    [_audioPlayer stop];
    [textFieldString release];
}

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
