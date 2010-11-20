#import "RandomEquation.h"
#import "ValueNode.h"
#import "AdditionNode.h"
#import "SubtractionNode.h"

@implementation RandomEquation

@synthesize level = _level;
@synthesize equation = _equation;

#pragma mark -
#pragma mark Init
- (id) initWithLevel:(NSInteger) level
{    
    if((self = [super init]))
    {
        _level = level;
        [self generateRandomEquation:level];
    }
    return self;
}

#pragma mark -
#pragma mark Random Generation
- (void) generateRandomEquation:(NSInteger) level 
{
    // Initialize the equation
    id<EquationNode> eqn = [[[ValueNode alloc] initWithValue:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d", [self randomNumber:level]]]] autorelease];
    
    // Build on the equation
    for(int i = 0; i < (1 + arc4random() % 3); i++) {
        id<EquationNode> val = [[[ValueNode alloc] initWithValue:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d", [self randomNumber:level]]]] autorelease];
        if([self randomBool]) {
            eqn = [[[AdditionNode alloc] initWithLeftNode:eqn rightNode:val] autorelease];
        } else {
            eqn = [[[SubtractionNode alloc] initWithLeftNode:eqn rightNode:val] autorelease];
        }
    }
    
    // Save it
    self.equation = eqn;
}

- (int) randomNumber:(NSInteger)level 
{
    srandom(time(NULL));
    int random_number = 1 + arc4random() % (level * 10);
    return random_number;
}

- (int) solve
{
    return [[self.equation evaluate] intValue];
}

- (BOOL) randomBool 
{
    return (arc4random() % 2 ? YES : NO);
}

#pragma mark -
#pragma mark NSObject overrides
- (NSString *) description
{
    return [NSString stringWithFormat:@"%@", _equation];
}

@end
