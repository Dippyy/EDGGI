//
//  SGUpgradeScreen.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2015-05-31.
//  Copyright (c) 2015 Robert D'Ippolito. All rights reserved.
//

#import "SGUpgradeScreen.h"
#import "UTIL.h"
#import "HUDNode.h"
#import "SGPlayerNode.h"
#import "playAgainButton.h"
#import "SGTitleScreenScene.h"
#import "SGMysteryNode.h"

@implementation SGUpgradeScreen


-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {

        NSInteger highScore = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"];
        
        NSArray *colorArray = [[NSArray alloc] initWithObjects:
                           [UIColor colorWithRed:90/255.0 green:187/255.0 blue:181/255.0 alpha:1.0],
                           [UIColor colorWithRed:222/255.0 green:171/255.0 blue:66/255.0 alpha:1.0],
                           [UIColor colorWithRed:223/255.0 green:86/255.0 blue:94/255.0 alpha:1.0],
                           [UIColor colorWithRed:239/255.0 green:130/255.0 blue:100/255.0 alpha:1.0],
                           [UIColor colorWithRed:77/255.0 green:75/255.0 blue:82/255.0 alpha:1.0],
                           [UIColor colorWithRed:105/255.0 green:94/255.0 blue:133/255.0 alpha:1.0],
                           [UIColor colorWithRed:85/255.0 green:176/255.0 blue:112/255.0 alpha:1.0], nil];
        
        playAgainButton *returnHome = [playAgainButton playAgainButtonPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/3)];
        returnHome.alpha = 1.0;
    
        SKLabelNode *titleScreen = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        titleScreen.name = @"UpgradeTitle";
        titleScreen.text =@"Select";
        titleScreen.fontSize = 38;
        titleScreen.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+3*(CGRectGetMidY(self.frame)/4));
        
        SKLabelNode *homeButton = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        homeButton.name = @"homeButton";
        homeButton.text =@"Home";
        homeButton.fontSize = 30;
        homeButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-(CGRectGetMidY(self.frame)*12/13));
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:colorArray[[UTIL randomWithMin:0 max:colorArray.count]] size:size];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        
        // ======================================================================== //
        
        SGPlayerNode *playerOne = [SGPlayerNode startingPlayerAtPosition:CGPointMake(CGRectGetMidX(self.frame)/3, CGRectGetMidY(self.frame)) asCharacter:@"EDDGI"];
        playerOne.name = @"playerOne";
        
        
        
        SKLabelNode *playerOneName = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        playerOneName.name = @"playerOneName";
        playerOneName.text =@"EDDGI";
        playerOneName.fontSize = 24;
        playerOneName.position = CGPointMake(CGRectGetMidX(self.frame)/3, CGRectGetMidY(self.frame)-playerOne.size.height);
        
        SKLabelNode *highScoreReq1 = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        highScoreReq1.name = @"playerOneName2";
        highScoreReq1.text =@"0";
        highScoreReq1.fontSize = 24;
        highScoreReq1.position = CGPointMake(CGRectGetMidX(self.frame)/3, CGRectGetMidY(self.frame)-playerOne.size.height-30);

        // ======================================================================== //
        
        SGPlayerNode *playerTwo = [SGPlayerNode startingPlayerAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))asCharacter:@"REGGI"];
        playerTwo.name = @"playerTwo";
        
        SGMysteryNode *mystery2 = [SGMysteryNode mysteryNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-15)];
        
        SKLabelNode *playerTwoName = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        playerTwoName.name = @"playerTwoName";
        playerTwoName.text =@"REGGI";
        playerTwoName.fontSize = 24;
        playerTwoName.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-playerOne.size.height);
        
        SKLabelNode *highScoreReq2 = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        highScoreReq2.name = @"playerTwoName";
        highScoreReq2.text =@"100";
        highScoreReq2.fontSize = 24;
        highScoreReq2.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-playerOne.size.height-30);
        
       // ======================================================================== //
        
        SGPlayerNode *playerThree = [SGPlayerNode startingPlayerAtPosition:CGPointMake(CGRectGetMidX(self.frame)*1.67, CGRectGetMidY(self.frame))asCharacter:@"BOBBI"];
        playerThree.name = @"playerThree";
        
        SGMysteryNode *mystery3 = [SGMysteryNode mysteryNodeAtPosition:CGPointMake(CGRectGetMidX(self.frame)*1.67, CGRectGetMidY(self.frame)-15)];
        
        SKLabelNode *playerThreeName = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        playerThreeName.name = @"playerThreeName";
        playerThreeName.text =@"BOBBI";
        playerThreeName.fontSize = 24;
        playerThreeName.position = CGPointMake(CGRectGetMidX(self.frame)*1.67, CGRectGetMidY(self.frame)-playerOne.size.height);
        
        SKLabelNode *highScoreReq3 = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        highScoreReq3.name = @"playerTwoName";
        highScoreReq3.text =@"200";
        highScoreReq3.fontSize = 24;
        highScoreReq3.position = CGPointMake(CGRectGetMidX(self.frame)*1.67, CGRectGetMidY(self.frame)-playerOne.size.height-30);
        
        // ======================================================================== //
        
        if(highScore < 100){
            playerTwo.hidden = YES;
            playerTwoName.hidden = YES;
           
            
        } else{

            playerTwo.hidden = NO;
            playerTwoName.hidden = NO;
            mystery2.hidden = YES;
        }
        
        if (highScore < 200){
          
            playerThree.hidden = YES;
            playerThreeName.hidden = YES;
            
        } else {
            playerThree.hidden = NO;
            playerTwo.hidden = NO;
            playerThreeName.hidden = NO;
            mystery3.hidden = YES;
        }

        [self addChild:background];
        [self addChild:titleScreen];
        [self addChild:playerOne];
        [self addChild:playerOneName];
        [self addChild:highScoreReq1];
        [self addChild:playerTwo];
        [self addChild:playerTwoName];
        [self addChild:highScoreReq2];
        [self addChild:mystery2];
        [self addChild:playerThree];
        [self addChild:playerThreeName];
        [self addChild:highScoreReq3];
        [self addChild:mystery3];
        [self addChild:homeButton];
        
        
        if(highScore>100&&highScore<200){
          [mystery2 removeFromParent];
        } else if (highScore > 200){
            [mystery3 removeFromParent];
            [mystery2 removeFromParent];
            
        }



    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"playAgainButton"]){
        
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
        
    }
    
    if([node.name isEqualToString:@"playerOne"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"EDDGI" forKey:@"currentCharacter"];
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
        NSLog(@"Player 1 Tapped");
    }
    
    if([node.name isEqualToString:@"playerTwo"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"REGGI" forKey:@"currentCharacter"];
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
        NSLog(@"Player 2 Tapped");
    }
    
    if ([node.name isEqualToString:@"playerThree"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"BOBBI" forKey:@"currentCharacter"];
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
        NSLog(@"Player 3 Tapped");
    }
    
    if([node.name isEqualToString:@"homeButton"]){
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
    }
    
}

@end
