#import "RandomEquation.h"

@implementation RandomEquation

@synthesize level = _level;
@synthesize equation = _equation;
@synthesize numArray = _numArray;
@synthesize signDict = _signDict;
@synthesize answer = _answer;

#pragma mark -
#pragma mark Init
- (id) initWithLevel:(NSInteger) level
{    
    if(self = [super init])
    {
        _level = level;
        [self generateRandomEquation];
    }
    return self;
}

#pragma mark -
#pragma mark Random Generation
- (void) generateRandomEquation
{
    NSMutableArray *equationString = [[NSMutableArray alloc] init];
    _numArray = [[NSMutableArray alloc] init];
    _signDict = [[NSMutableDictionary alloc] init];
    
    int numOfNumbers = 2 + (arc4random() % 3);
    
    for(int i = 0; i < numOfNumbers; i++) {
        // Numbers
        int random = [self randomNumber];
        [_numArray insertObject:[NSString stringWithFormat:@"%i", random] atIndex:(MIN([_numArray count], 0))];
        [equationString addObject:[NSNumber numberWithInt:random]];
        
        // Signs
        int signRandom = 1 + (arc4random() % 2);
        NSString *sign = [[NSString alloc] init];
        switch(signRandom) {
            case 1: sign = @"+"; break;
            case 2: sign = @"-"; break;
        }
        
        if(i != numOfNumbers - 1) {
            [_signDict setValue:[NSString stringWithFormat:@"%@", sign] 
                         forKey:[NSString stringWithFormat:@"%i", random]];
            [equationString addObject:sign];
        }
        
        [sign release];
    }
    
    _equation = [equationString componentsJoinedByString:@" "];   
    NSLog(@"EQUATION: %@", _equation);
    _answer = [self solve];
    
    [equationString release];
}

- (int) randomNumber
{
    srandom(time(NULL));
    int random_number = 1 + (arc4random() % (_level * 10));
    return random_number;
}

- (int) solve
{
    int result = 0;
    
    NSString *nilsign = [[NSString alloc] init];
    NSString *tempsign = [[NSString alloc] init];
    NSString *sign = [[NSString alloc] init];
    NSString *key = [[NSString alloc] init];
    bool mer = NO;
    for(id obj in [_numArray reverseObjectEnumerator]) {
        key = [NSString stringWithFormat:@"%i", [(NSNumber *)obj intValue]];
        if(key != nil) {
            int number = [(NSNumber *)obj intValue];
            sign = [_signDict valueForKey:key];
            if(mer == YES) {
                if([tempsign isEqualToString:@"+"]) {
                    result += number;
                    tempsign = sign;
                } else if([tempsign isEqualToString:@"-"]) {
                    result -= number;
                    tempsign = sign;
                } else {
                    if([nilsign isEqualToString:@"+"]) {
                        result += number;
                    } else if([nilsign isEqualToString:@"+"]) {
                        result -= number;                
                    }
                }
            } else {
                result += number;
                tempsign = sign;
                mer = YES;
            }
        } 
    }
    
    NSLog(@"ANSWER: %i", result);
    
    return result;
}

#pragma mark -
#pragma mark NSObject overrides
- (NSString *) description
{
    return [NSString stringWithFormat:@"%@", _equation];
}

@end
