//
//  SGTitleScreenScene.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-12.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGTitleScreenScene.h"
#import "SGGameplayScene.h"
#import "SGUpgradeScreen.h"
#import "SGupgradeButton.h"
#import "SGHighScore.h"
#import "HUDNode.h"
#import "ViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UTIL.h"

#import <Parse/Parse.h>

@implementation SGTitleScreenScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSInteger highScorevalue = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"];
                
        if (highScorevalue < 100) {
            [[NSUserDefaults standardUserDefaults] setObject:@"EDDGI" forKey:@"currentCharacter"];
             [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
        NSString *currentCharacter = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentCharacter"];
        NSString *homeScreenName;
        
//        NSArray *colorArray = [[NSArray alloc] initWithObjects:
//                               [UIColor colorWithRed:90/255.0 green:187/255.0 blue:181/255.0 alpha:1.0],
//                                [UIColor colorWithRed:222/255.0 green:171/255.0 blue:66/255.0 alpha:1.0],
//                                [UIColor colorWithRed:223/255.0 green:86/255.0 blue:94/255.0 alpha:1.0],
//                                [UIColor colorWithRed:239/255.0 green:130/255.0 blue:100/255.0 alpha:1.0],
//                                [UIColor colorWithRed:77/255.0 green:75/255.0 blue:82/255.0 alpha:1.0],
//                                [UIColor colorWithRed:105/255.0 green:94/255.0 blue:133/255.0 alpha:1.0],
//                                [UIColor colorWithRed:85/255.0 green:176/255.0 blue:112/255.0 alpha:1.0],
//                                [UIColor colorWithRed:96/255.0 green:142/255.0 blue:213/255.0 alpha:1.0],nil];
        
        //SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:colorArray[[UTIL randomWithMin:0 max:colorArray.count]] size:size];
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Homescreen_Background"];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        background.zPosition = 0;
        
        
        if ([currentCharacter  isEqual: @"EDDGI"]) {
            homeScreenName = @"homescreen1";
        } else if ([currentCharacter  isEqual: @"REGGI"]) {
            homeScreenName = @"homescreen2";
        } else if ([currentCharacter  isEqual: @"BOBBI"]) {
            homeScreenName = @"homescreen3";
        }
        
        SKSpriteNode *titleImages = [SKSpriteNode spriteNodeWithImageNamed:(homeScreenName)];
        titleImages.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        titleImages.zPosition = 0;
        titleImages.size =CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        
        SKLabelNode *titleScreen = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        titleScreen.name = @"Title";
        titleScreen.zPosition = 0;
        titleScreen.text = currentCharacter;
        titleScreen.fontSize = 48;
        titleScreen.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+3*(CGRectGetMidY(self.frame)/4));
        
        SKLabelNode *instructionTitle = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Regular"];
        instructionTitle.name = @"Title";
        instructionTitle.zPosition = 0;
        instructionTitle.text = @"CLICK SCREEN to move", currentCharacter;
        instructionTitle.fontSize = 20;
        instructionTitle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+2.6*(CGRectGetMidY(self.frame)/5));
        
//        SKLabelNode *instruction = [SKLabelNode labelNodeWithFontNamed:@"AvenirNext-Regular"];
//        instruction.name = @"instruction";
//        instruction.zPosition = 0;
//        instruction.text =@"Dogde Monsters";
//        instruction.fontSize = 20;
//        instruction.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+2.8*(CGRectGetMidY(self.frame)/5));

        
        SKLabelNode *highscoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        highscoreLabel.name = @"HS";
        highscoreLabel.zPosition = 0;
        highscoreLabel.text = @"HIGHSCORE";
        highscoreLabel.fontSize = 25;
        highscoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-3*(CGRectGetMidY(self.frame)/4.75));
        
        SKLabelNode *highScore = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        highScore.name = @"titleHighScore";
        highScore.zPosition = 0;
        highScore.fontSize = 30;
        highScore.alpha = 0.7;
        highScore.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-3*(CGRectGetMidY(self.frame)/4));
        highScore.text = [NSString stringWithFormat:@"%ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"]];
        
        SKLabelNode *loginWithFB = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        loginWithFB.name = @"LoginWithFB";
        loginWithFB.text = @"Go Back";
        loginWithFB.zPosition = 0;
        loginWithFB.fontSize = 30;
        loginWithFB.alpha = 1.0;
        loginWithFB.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-2.5*(CGRectGetMidY(self.frame)/2.75));

        SKLabelNode *upgradeButton = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        upgradeButton.name = @"upgradeTapped";
        upgradeButton.zPosition = 0;
        upgradeButton.text =@"Upgrade";
        upgradeButton.fontSize = 30;
        upgradeButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)/1.5);

        
        
        [self addChild:background];
        [self addChild:titleImages];
        [self addChild:titleScreen];
        [self addChild:instructionTitle];
        //[self addChild:instruction];
        [self addChild:highScore];
        //[self addChild:upgradeButton];
        [self addChild:highscoreLabel];
        [self addChild:loginWithFB];
    }
    return  self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    SGGameplayScene *gamePlayScene = [SGGameplayScene sceneWithSize:self.frame.size];
    gamePlayScene.name = @"gameScreen";
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];

    [self.view presentScene:gamePlayScene transition:transition];
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"upgradeTapped"]){
        SGUpgradeScreen *upgradeScene = [SGUpgradeScreen sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:upgradeScene transition:transition];
    }
    
    if([node.name isEqualToString:@"LoginWithFB"]){
        
        [self.view presentScene:nil];
        NSUserDefaults *loginToken = [NSUserDefaults standardUserDefaults];
        [loginToken setObject:@"Scenario2" forKey:@"AccessToken"];

    }
    
    if([node.name isEqualToString:@"HS"]){
    SGHighScore *highScoreScene = [SGHighScore sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition fadeWithDuration:1.0];
    [self.view presentScene:highScoreScene transition:transition];
    }
    
    if([node.name isEqualToString:@"titleHighScore"]){
        SGHighScore *highScoreScene = [SGHighScore sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:highScoreScene transition:transition];
    }
    
}

@end
