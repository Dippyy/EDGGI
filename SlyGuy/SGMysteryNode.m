//
//  SGMysteryNode.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2015-05-31.
//  Copyright (c) 2015 Robert D'Ippolito. All rights reserved.
//

#import "SGMysteryNode.h"

@implementation SGMysteryNode

+(instancetype) mysteryNodeAtPosition: (CGPoint) position{
    
    SGMysteryNode *mysteryNode = [self spriteNodeWithImageNamed:(@"MysteryBox")];
    mysteryNode.size=CGSizeMake(50.0, 55.0);
    
    mysteryNode.position = position;
    mysteryNode.name = @"MysteryNode";
    
    return  mysteryNode;
}


@end
