#import <Foundation/Foundation.h>

#import "EquationNode.h"

@interface AdditionNode : NSObject <EquationNode> {
    id<EquationNode> _left;
    id<EquationNode> _right;
}

@property(nonatomic, retain) id<EquationNode> left;
@property(nonatomic, retain) id<EquationNode> right;

- (id)initWithLeftNode:(id<EquationNode>)left rightNode:(id<EquationNode>)right;

@end
