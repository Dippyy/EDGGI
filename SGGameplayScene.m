//
//  SGGameplayScene.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-12.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "SGGameplayScene.h"
#import "SGPlayerNode.h"
#import "UTIL.h"
#import "SGEnemy1Node.h"
#import "SGEnemy2Node.h"
#import "SGTreasureNode.h"
#import "SGGameover.h"
#import "HUDNode.h"
#import "SGTitleScreenScene.h"
#import "playAgainButton.h"
#import "SGupgradeButton.h"
#import "SGUpgradeScreen.h"
#import "SGHighScore.h"
#import <Parse/Parse.h>

@interface SGGameplayScene ()

@property(nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property(nonatomic) NSTimeInterval timeSinceEnemyAdded;
@property(nonatomic) NSTimeInterval totalGameTime;

@property(nonatomic) NSInteger highScoreNumber;

@property(nonatomic) BOOL gameOver;
@property(nonatomic) BOOL gameOverDisplayed;
@property(nonatomic) BOOL restart;

@property(nonatomic) BOOL treasurePresent;


@end

@implementation SGGameplayScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        NSArray *colorArray = [[NSArray alloc] initWithObjects:
                               [UIColor colorWithRed:90/255.0 green:187/255.0 blue:181/255.0 alpha:1.0],
                               [UIColor colorWithRed:222/255.0 green:171/255.0 blue:66/255.0 alpha:1.0],
                               [UIColor colorWithRed:223/255.0 green:86/255.0 blue:94/255.0 alpha:1.0],
                               [UIColor colorWithRed:239/255.0 green:130/255.0 blue:100/255.0 alpha:1.0],
                               [UIColor colorWithRed:77/255.0 green:75/255.0 blue:82/255.0 alpha:1.0],
                               [UIColor colorWithRed:105/255.0 green:94/255.0 blue:133/255.0 alpha:1.0],
                               [UIColor colorWithRed:85/255.0 green:176/255.0 blue:112/255.0 alpha:1.0], nil];
        
        
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:colorArray[[UTIL randomWithMin:0 max:colorArray.count]] size:size];
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
        
        self.highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"];
        
        self.physicsWorld.contactDelegate = self;
        
        self.gameOver = NO;
        self.gameOverDisplayed = NO;
        self.restart = NO;

        self.treasurePresent = YES;
        
        NSString *currentCharacter = [[NSUserDefaults standardUserDefaults] stringForKey:@"currentCharacter"];
        
        SGPlayerNode *player  = [SGPlayerNode startingPlayerAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))asCharacter:currentCharacter];
        [self addChild:player];
        
        HUDNode *hud = [HUDNode hudAtPosition:CGPointMake(0, self.frame.size.height-20)inFrame:self.frame];
        [self addChild:hud];
        
    }
    return  self;
}

-(void)update:(NSTimeInterval)currentTime {
    
    if(self.lastUpdateTimeInterval){
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
        // at the first 10 seconds, enemy is added every 3 seconds
        // between 10 and 35sec, enemy is added every 2 seconds
        // between 35- 80sec, enemy is added every 1.5 seconds
        // after 80 seconds, enemy is added every 1.2 seconds
    
    
    if (self.totalGameTime<10) {
        if(self.timeSinceEnemyAdded > 3 && !self.gameOver){
            
            float deploy = [UTIL randomWithMin:0 max:2];
            
            if(deploy == 1){
                [self placeEnemy1];
            }else{
                [self placeEnemy2];
            }
            
            self.timeSinceEnemyAdded = 0;
        }

    } else if (self.totalGameTime<35) {
        if(self.timeSinceEnemyAdded > 2 && !self.gameOver){
            
            float deploy = [UTIL randomWithMin:0 max:2];
            
            if(deploy == 1){
                [self placeEnemy1];
            }else{
                [self placeEnemy2];
            }
            
            self.timeSinceEnemyAdded = 0;
        }

    } else if (self.totalGameTime<80) {
        if(self.timeSinceEnemyAdded > 1.5 && !self.gameOver){
            
            float deploy = [UTIL randomWithMin:0 max:2];
            
            if(deploy == 1){
                [self placeEnemy1];
            }else{
                [self placeEnemy2];
            }
            
            self.timeSinceEnemyAdded = 0;
        }
        
    } else {
    
    if(self.timeSinceEnemyAdded > 1.2 && !self.gameOver){

        float deploy = [UTIL randomWithMin:0 max:2];
        
        if(deploy == 1){
            [self placeEnemy1];
        }else{
            [self placeEnemy2];
        }

        self.timeSinceEnemyAdded = 0;
    }
    }
    
    self.lastUpdateTimeInterval = currentTime;
    
    if(self.gameOver  && !self.gameOverDisplayed){
        [self performGameOver];
    }
    
    if(self.treasurePresent){
        [self placeTreasure];
        self.treasurePresent = NO;
    }
    
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if([node.name isEqualToString:@"playAgainButton"]){
        self.restart = YES;
    } else if([node.name isEqualToString:@"upgradeButton"]){
        SGUpgradeScreen *scene = [SGUpgradeScreen sceneWithSize:self.view.bounds.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:scene transition:transition];
    }
    
    if([node.name isEqualToString:@"Play Again"]){
        
        SGGameplayScene *gamePlayScene = [SGGameplayScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:gamePlayScene transition:transition];
        
    }
    
    if([node.name isEqualToString:@"Upgrade Character"]){
        
        SGUpgradeScreen *upgradeScene = [SGUpgradeScreen sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:upgradeScene transition:transition];
        
    }
    
    if([node.name isEqualToString:@"viewHighScore"]){
        
        SGHighScore *highScoreScene = [SGHighScore sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:highScoreScene transition:transition];
        
    }
    
    if([node.name isEqualToString:@"Home"]){
        
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
        
    }
    
    if(!self.gameOver){
    
    SKNode *player = [self childNodeWithName:@"Player"];
    
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
        
    float actualDuration = 0.5;
    
    SKAction *actionMove = [SKAction moveTo:CGPointMake(positionInScene.x, positionInScene.y) duration:actualDuration];
    [player runAction:actionMove];
        
    } else if(self.restart) {
        
        for(SKNode *node in [self children]){
            [node removeFromParent];
        }
        
        SGTitleScreenScene *scene = [SGTitleScreenScene sceneWithSize:self.view.bounds.size];
        SKTransition *transition = [SKTransition fadeWithDuration:0.5];
        [self.view presentScene:scene transition:transition];
    
    }
 
}

-(void) addPoints:(NSInteger)points{
    HUDNode *hud = (HUDNode *)[self childNodeWithName:@"Hud"];
    [hud addPoints:points];

}


-(void) placeEnemy1 {
    
    SGEnemy2Node *enemy1 = (SGEnemy2Node *)[self childNodeWithName:@"Enemy1"];
    
    float y1 = [UTIL randomWithMin:-enemy1.self.size.height max:self.frame.size.height];
    float x1 = self.frame.size.width/10;
    
    float y2 = self.frame.size.height*5/6;
    float x2 = [UTIL randomWithMin:-enemy1.size.width max:self.frame.size.width];
    
    float y3 = [UTIL randomWithMin:-enemy1.size.height max:self.frame.size.height];
    float x3 = self.frame.size.width*5/6;
    
    float y4 = self.frame.size.height/10;
    float x4 = [UTIL randomWithMin:-enemy1.size.width max:self.frame.size.width];
    
    NSArray *array = @[@"Left",@"Top",@"Right",@"Bottom"];
    NSInteger i = [UTIL randomWithMin:0 max:4];
    
    if([array[i] isEqualToString:@"Left"]){
        SGEnemy1Node *enemy1 = [SGEnemy1Node startingPlayerAtPosition:CGPointMake(x1,y1)];
        [self addChild:enemy1];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy1.physicsBody.velocity = CGVectorMake(dy, 0);
        [enemy1 runAction:[SKAction rotateByAngle:4.71 duration:0]];
        [enemy1 fadeOut];
        
        
    }else if([array[i] isEqualToString:@"Top"]){
        SGEnemy1Node *enemy1 = [SGEnemy1Node startingPlayerAtPosition:CGPointMake(x2,y2)];
        [self addChild:enemy1];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy1.physicsBody.velocity = CGVectorMake(0, -dy);
        [enemy1 runAction:[SKAction rotateByAngle:3.14 duration:0]];
        [enemy1 fadeOut];
        
    }else if([array[i] isEqualToString:@"Right"]){
        SGEnemy1Node *enemy1 = [SGEnemy1Node startingPlayerAtPosition:CGPointMake(x3,y3)];
        [self addChild:enemy1];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy1.physicsBody.velocity = CGVectorMake(-dy, 0);
        [enemy1 runAction:[SKAction rotateByAngle:1.57 duration:0]];
        [enemy1 fadeOut];

    }else if([array[i] isEqualToString:@"Bottom"]){
        SGEnemy1Node *enemy1 = [SGEnemy1Node startingPlayerAtPosition:CGPointMake(x4,y4)];
        [self addChild:enemy1];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy1.physicsBody.velocity = CGVectorMake(0, dy);
        [enemy1 fadeOut];

    }
    
}

-(void) placeEnemy2 {
    
    SGEnemy2Node *enemy2 = (SGEnemy2Node *)[self childNodeWithName:@"Enemy2"];
    
    float y1 = [UTIL randomWithMin:-enemy2.self.size.height max:self.frame.size.height];
    float x1 = self.frame.size.width/10;
    
    float y2 = self.frame.size.height*5/6;
    float x2 = [UTIL randomWithMin:-enemy2.size.width max:self.frame.size.width];
    
    float y3 = [UTIL randomWithMin:-enemy2.size.height max:self.frame.size.height];
    float x3 = self.frame.size.width*5/6;
    
    float y4 = self.frame.size.height/10;
    float x4 = [UTIL randomWithMin:-enemy2.size.width max:self.frame.size.width];
    
    NSArray *array = @[@"Left",@"Top",@"Right",@"Bottom"];
    NSInteger i = [UTIL randomWithMin:0 max:4];
    
    if([array[i] isEqualToString:@"Left"]){
        SGEnemy2Node *enemy2 = [SGEnemy2Node startingEnemy2AtPosition:CGPointMake(x1,y1)];
        [self addChild:enemy2];
        [enemy2 runAction:[SKAction rotateByAngle:4.71 duration:0]];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy2.physicsBody.velocity = CGVectorMake(dy, 0);
        [enemy2 fadeOut];
        
        
    }else if([array[i] isEqualToString:@"Top"]){
        SGEnemy2Node *enemy2 = [SGEnemy2Node startingEnemy2AtPosition:CGPointMake(x2,y2)];
        [self addChild:enemy2];
        [enemy2 runAction:[SKAction rotateByAngle:3.14 duration:0]];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy2.physicsBody.velocity = CGVectorMake(0, -dy);
        [enemy2 fadeOut];
        
    }else if([array[i] isEqualToString:@"Right"]){
        SGEnemy2Node *enemy2 = [SGEnemy2Node startingEnemy2AtPosition:CGPointMake(x3,y3)];
        [self addChild:enemy2];
        [enemy2 runAction:[SKAction rotateByAngle:1.57 duration:0]];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy2.physicsBody.velocity = CGVectorMake(-dy, 0);
        [enemy2 fadeOut];
        
    }else if([array[i] isEqualToString:@"Bottom"]){
        SGEnemy2Node *enemy2 = [SGEnemy2Node startingEnemy2AtPosition:CGPointMake(x4,y4)];
        [self addChild:enemy2];
        float dy = [UTIL randomWithMin:200 max:250];
        enemy2.physicsBody.velocity = CGVectorMake(0, dy);
        [enemy2 fadeOut];
        
    }
    
}

-(void) placeTreasure {
    
    float x = [UTIL randomWithMin:20 max:self.frame.size.width-20];
    float y = [UTIL randomWithMin:20 max:self.frame.size.height-20];
    
    SGTreasureNode *treasure = [SGTreasureNode startingTreasureAtPosition:CGPointMake(x, y)];
    [self addChild:treasure];
    
}

-(void) didBeginContact:(SKPhysicsContact *)contact{
    
    SKPhysicsBody *firstBody;
    SKPhysicsBody *secondBody;
    SGPlayerNode *player = (SGPlayerNode *)[self childNodeWithName:@"Player"];
    
    if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
        
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    } else {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    if(firstBody.categoryBitMask == collisionCategoryPlayer && secondBody.categoryBitMask == collisionCategoryEnemy1){
        NSLog(@"Found1!");
        self.gameOver = YES;
        SGTreasureNode *treasure = (SGTreasureNode *)[self childNodeWithName:@"Treasure"];
        
        
        [self createExplosionAtPosition:contact.contactPoint];
        [player removeFromParent];
        [treasure removeFromParent];
        
        
        HUDNode *highScore = (HUDNode *)[self childNodeWithName:@"Hud"];

        if(highScore.score > self.highScoreNumber){
            NSLog(@"score is %ld and highscore is %ld",(long)highScore.score, (long)highScore.highScore);
            [[NSUserDefaults standardUserDefaults] setInteger:highScore.score forKey:@"HighscoreSaved"];
            
      // --- Saves highscore to Parse --- //
            
            NSString *userID = [[NSUserDefaults standardUserDefaults] valueForKey:@"userID"];
            
            if(userID) {

                PFQuery *query = [PFQuery queryWithClassName:@"Highscore"];
                [query whereKey:@"userId" equalTo:userID];
                [query getFirstObjectInBackgroundWithBlock:^(PFObject * userStats, NSError *error) {
                if (!error) {
                    // Found UserStats
                    [userStats setObject:@(highScore.score) forKey:@"scoreValue"];
                    // Save
                    [userStats saveInBackground];
                } else {
                    // Did not find any UserStats for the current user
                    NSLog(@"Error: %@", error);
                }
                }];
            } else {
                NSLog(@"No login session");
            }
        }
        
    }
    
    if(firstBody.categoryBitMask == collisionCategoryPlayer && secondBody.categoryBitMask == collisionCategoryTreasure){
        SGTreasureNode *treasure = (SGTreasureNode *)[self childNodeWithName:@"Treasure"];
        [treasure removeFromParent];
        [self addPoints: pointsPerHit];
        self.treasurePresent = YES;
        NSLog(@"Treasure");
        
    }

}

-(void) performGameOver{
    
    SKSpriteNode *gameOverDisplay = [SKSpriteNode spriteNodeWithImageNamed:@"EDDGI GameOver"];
    gameOverDisplay.size = CGSizeMake(self.frame.size.width*0.9, self.frame.size.height*0.7);
    gameOverDisplay.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    gameOverDisplay.alpha = 0.8;
    [self addChild:gameOverDisplay];
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.1];
    
    [gameOverDisplay runAction:fadeIn];
    
    SGGameover *gameOver = [SGGameover gameOverAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*1.4)];
    gameOver.alpha=0.0;
    [self addChild:gameOver];
    self.gameOverDisplayed = YES;
    
    [gameOver runAction:fadeIn];
    
    SKLabelNode *playAgain = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    playAgain.name = @"Play Again";
    playAgain.text =@"Play Again";
    playAgain.fontSize = 24;
    playAgain.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*1.1);
    
    SKLabelNode *upgradeCharacter = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    upgradeCharacter.name = @"Upgrade Character";
    upgradeCharacter.text =@"Upgrade Character";
    upgradeCharacter.fontSize = 24;
    upgradeCharacter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.9);
    
    SKLabelNode *viewHighScore = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    viewHighScore.name = @"viewHighScore";
    viewHighScore.text =@"View Highscore";
    viewHighScore.fontSize = 24;
    viewHighScore.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.7);
    
    SKLabelNode *home = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    home.name = @"Home";
    home.text =@"Home";
    home.fontSize = 24;
    home.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.5);

    
    [self addChild:playAgain];
    [self addChild:upgradeCharacter];
    [self addChild:viewHighScore];
    [self addChild:home];
    
}

-(void) createExplosionAtPosition:(CGPoint)position {
    
    NSString *explosionPath = [[NSBundle mainBundle] pathForResource:@"explosion" ofType:@"sks"];
    SKEmitterNode *explosion = [NSKeyedUnarchiver unarchiveObjectWithFile:explosionPath];
    
    explosion.position = position;
    [self addChild:explosion];
    [explosion runAction:[SKAction waitForDuration:1.0] completion:^{
        [explosion removeFromParent];
    }];
    
}



@end
