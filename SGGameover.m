//
//  SGGameover.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGGameover.h"
#import "HUDNode.h"
#import "UTIL.h"


@implementation SGGameover

+(instancetype) gameOverAtPosition:(CGPoint)position{
    
    SGGameover *gameOver = [self node];
    
    NSUserDefaults *playerScore = [NSUserDefaults standardUserDefaults];
    int scoreValue = [playerScore integerForKey:@"PlayerScore"];
    
    SKLabelNode *gameOverLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    gameOver.name = @"GameOver";
    
    float randomNumber = [UTIL randomWithMin:0 max:2];
    
    if (scoreValue < 260) {
        gameOverLabel.text = [NSString stringWithFormat:@"Only %i?",scoreValue];
    } else if (scoreValue < 500) {
        gameOverLabel.text = [NSString stringWithFormat:@"Nice %i",scoreValue];
    } else {
        gameOverLabel.text = [NSString stringWithFormat:@"Wow %i",scoreValue];
    }
    
    gameOverLabel.fontSize = 43;
    gameOverLabel.position = position;
    [gameOver addChild:gameOverLabel];
    
    return gameOver;
    
}

@end
