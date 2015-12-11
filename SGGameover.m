//
//  SGGameover.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGGameover.h"
#import "HUDNode.h"


@implementation SGGameover

+(instancetype) gameOverAtPosition:(CGPoint)position{
    
    SGGameover *gameOver = [self node];
    
    NSUserDefaults *playerScore = [NSUserDefaults standardUserDefaults];
    NSInteger *scoreValue = [playerScore integerForKey:@"PlayerScore"];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    gameOver.name = @"GameOver";
    gameOverLabel.text = [NSString stringWithFormat:@"Your Score was %d",scoreValue];
    
    gameOverLabel.fontSize = 28;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
    
}

@end
