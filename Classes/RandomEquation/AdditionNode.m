#import "AdditionNode.h"
#import "ValueNode.h"

@implementation AdditionNode

@synthesize left = _left;
@synthesize right = _right;

#pragma mark -
#pragma mark Initializers

- (id)init {
    if((self = [super init])) {
        self.left = [[[ValueNode alloc] init] autorelease];
        self.right = [[[ValueNode alloc] init] autorelease];
    }
    return self;
}

- (id)initWithLeftNode:(id<EquationNode>)left rightNode:(id<EquationNode>)right {
    if((self = [super init])) {
        self.left = left;
        self.right = right;
    }
    return self;
}

#pragma mark -
#pragma mark EquationNode methods

- (NSNumber *)evaluate {
    return [[self.left evaluate] decimalNumberByAdding:[self.right evaluate]];
}

#pragma mark -
#pragma mark String methods

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ + %@", self.left, self.right];
}

@end
