//
//  SGPlayerNode.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-12.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//    [@"EDDGI",@"REGGI",@"BOBBI"]

#import "SGPlayerNode.h"
#import "UTIL.h"

@implementation SGPlayerNode

+(instancetype) startingPlayerAtPosition: (CGPoint) position asCharacter:(NSString*)characterName{
    
    SGPlayerNode *playerNode = [self spriteNodeWithImageNamed:characterName];
    
    if ([characterName  isEqual: @"REGGI"]) {
        playerNode.size = CGSizeMake(50,55);
    } else {
    playerNode.size = CGSizeMake(50, 50);
    }
    
    
    playerNode.position = position;
    playerNode.name = @"Player";
    [playerNode setupPhysicsBody];
    
    return  playerNode;
}

-(void) setupPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = collisionCategoryPlayer;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = collisionCategoryEnemy1 | collisionCategoryTreasure;
    
}


@end
