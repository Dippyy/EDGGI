//
//  SGEnemy1Node.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-14.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGEnemy1Node.h"
#import "UTIL.h"

@implementation SGEnemy1Node

+(instancetype) startingPlayerAtPosition: (CGPoint) position{
    
    SGEnemy1Node *enemy1 = [self spriteNodeWithImageNamed:@"Enemy1"];
    enemy1.size = CGSizeMake(120.0, 100.0);
    enemy1.position = position;
    enemy1.name = @"Enemy1";
    [enemy1 walkingAnimationEnemy1];
    [enemy1 setupPhysicsBody];
    
    return  enemy1;
}

-(void) fadeOut {
    
    float time = [UTIL randomWithMin:4 max:5];
    float timeToFade = 0.75*time;
    
    SKAction *fadeTimer = [SKAction waitForDuration:timeToFade];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:time-timeToFade];
    
    NSArray *arrayOfActions = @[fadeTimer,fadeOut];
    
    SKAction *sequence = [SKAction sequence:arrayOfActions];
    
    [self runAction:sequence];
    
}

-(void)walkingAnimationEnemy1 {
    
        SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad2(-6.0f) duration:0.1],[SKAction rotateByAngle:0.0 duration:0.1],[SKAction rotateByAngle:degToRad2(6.0f) duration:0.1]]];
        
        [self runAction:[SKAction repeatActionForever:sequence]];
        
        
}

    float degToRad2(float degree){
        
        return degree / 180.0f * M_PI;
        
    }

-(void) setupPhysicsBody {
    
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = collisionCategoryEnemy1;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = collisionCategoryPlayer;
    
}

@end
