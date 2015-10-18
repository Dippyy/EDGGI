//
//  HUDNode.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-21.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "HUDNode.h"

@implementation HUDNode

+(instancetype) hudAtPosition: (CGPoint)position inFrame:(CGRect)frame{
    
    HUDNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    hud.name = @"Hud";

    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 30;
    scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    scoreLabel.position = CGPointMake(frame.size.width-30, -25);
    
    SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    highScoreLabel.name = @"Highscore";
    highScoreLabel.text = [NSString stringWithFormat:@"%ld",[[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"]];
    highScoreLabel.fontSize = 30;
    highScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    highScoreLabel.position = CGPointMake(+30, -25);
    
                           
    [hud addChild:highScoreLabel];
    [hud addChild:scoreLabel];
    
    return hud;
    
}

-(void) addPoints:(NSInteger)addPoints{
    
    self.score += addPoints;

    SKLabelNode *scoreLabel = (SKLabelNode *)[self childNodeWithName:@"Score"];
    scoreLabel.text = [NSString stringWithFormat:@"%ld",(long)self.score];
    
//    self.items = [NSMutableArray arrayWithObjects:@"one","two", nil];
    
}




@end
