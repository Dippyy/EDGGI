//
//  SGTreasureNode.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGTreasureNode.h"
#import "UTIL.h"

@implementation SGTreasureNode

+(instancetype) startingTreasureAtPosition: (CGPoint) position : (int) level{
   
    
    NSArray *treasureImageName = [[NSArray alloc] initWithObjects: @"Treasure2", @"Treasure_red", nil];
    SGTreasureNode *treasure = [self spriteNodeWithImageNamed:(treasureImageName[level])];
    if (level == 1) {
        treasure.size = CGSizeMake(40.0, 40.0);
        
    } else {
        treasure.size = CGSizeMake(30.0, 30.0);
    }

    treasure.position = position;
    [treasure setupPhysicsBody];
    treasure.name = @"Treasure";
    [treasure performAnimation];
    
    return  treasure;
}

-(void) performAnimation{
    
    SKAction *scaleUp = [SKAction scaleTo:1.2f duration:0.75f];
    SKAction *scaleDown = [SKAction scaleTo:0.9f duration:0.25f];
    
    SKAction *scaleSequence = [SKAction sequence:@[scaleUp,scaleDown]];
    
    [self runAction:scaleSequence];
    
}

-(void) setupPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = collisionCategoryTreasure;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = collisionCategoryPlayer;
    
}

@end
