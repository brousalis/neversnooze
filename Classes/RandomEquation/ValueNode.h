#import <Foundation/Foundation.h>
#import "EquationNode.h"

@interface ValueNode : NSObject <EquationNode> {
    NSDecimalNumber * _value;
}

@property(nonatomic, retain) NSDecimalNumber * value;

- (id)initWithValue:(NSDecimalNumber *)value;

@end
