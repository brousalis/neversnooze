#import <Foundation/Foundation.h>

@interface RandomEquation : NSObject {
    NSInteger _level;
    NSString *_equation;
    NSInteger _answer;
    NSMutableArray  *_numArray;
    NSDictionary *_signDict;
}

@property (nonatomic, readwrite) NSInteger level;
@property (nonatomic, readwrite) NSInteger answer;
@property (nonatomic, retain) NSString *equation;
@property (nonatomic, retain) NSMutableArray *numArray;
@property (nonatomic, retain) NSDictionary *signDict;

- (void) generateRandomEquation;
- (int) randomNumber;
- (int) solve;

- (id) initWithLevel:(NSInteger) level;

@end
