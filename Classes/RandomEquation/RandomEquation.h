#import <Foundation/Foundation.h>
#import "EquationNode.h"

@interface RandomEquation : NSObject {
    NSInteger _level;
    id<EquationNode> _equation;
}

@property (nonatomic, readwrite) NSInteger level;
@property (nonatomic, retain) id<EquationNode> equation;

- (void) generateRandomEquation:(NSInteger) level;
- (int) randomNumber:(NSInteger)level;
- (int) solve;

- (id) initWithLevel:(NSInteger) level;
- (BOOL) randomBool;

@end
