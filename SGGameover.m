//
//  SGGameover.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGGameover.h"

@implementation SGGameover

+(instancetype) gameOverAtPosition:(CGPoint)position{
    
    SGGameover *gameOver = [self node];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    gameOver.name = @"GameOver";
    gameOverLabel.text =@"Game Over";
    gameOverLabel.fontSize = 48;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    
    return gameOver;
    
}

@end
