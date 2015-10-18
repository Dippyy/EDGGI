//
//  SGEnemy2Node.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGEnemy2Node.h"
#import "UTIL.h"

@implementation SGEnemy2Node

+(instancetype) startingEnemy2AtPosition:(CGPoint)position{
    
    SGEnemy2Node *enemy2 = [self spriteNodeWithImageNamed:@"Enemy2"];
    enemy2.size = CGSizeMake(30.0, 175.0);
    enemy2.position = position;
    enemy2.name = @"Enemy2";
    [enemy2 walkingAnimation];
    [enemy2 setupPhysicsBody];
    
    return  enemy2;
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

-(void) walkingAnimation {
    
    SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-6.0f) duration:0.1],[SKAction rotateByAngle:0.0 duration:0.1],[SKAction rotateByAngle:degToRad(6.0f) duration:0.1]]];
    
    [self runAction:[SKAction repeatActionForever:sequence]];
    
    
}

float degToRad(float degree){
    
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
