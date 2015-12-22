//
//  SGInstructionsNode.m
//  SlyGuy
//
//  Created by Alex on 2015-12-22.
//  Copyright © 2015 Robert D'Ippolito. All rights reserved.
//

#import "SGInstructionsNode.h"

@implementation SGInstructionsNode


+(instancetype) createInstructionNode:(CGPoint)position {
    
    SGInstructionsNode *instruction = [self spriteNodeWithImageNamed:(@"Treasure2")];
    instruction.size = CGSizeMake(30.0, 30.0);
    
//    treasure.position = position;
//    [treasure setupPhysicsBody];
//    instruction.name = @"instruction";
//    [treasure performAnimation];
//    
     return  nil;
}


@end
