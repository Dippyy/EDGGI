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

//------------------------------------- TIME INTERVALS ----------------------------------------//

int shortTimeInterval = 9;
int mediumTimeInterval = 18;
int longTimeInterval = 28;
int startTimeInterval = 4;
int specialTimeInterval = 4;
int pauseTimeInterval = 4;



-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        NSArray *colorArray = [[NSArray alloc] initWithObjects:
                               [UIColor colorWithRed:90/255.0 green:187/255.0 blue:181/255.0 alpha:1.0],
                               [UIColor colorWithRed:222/255.0 green:171/255.0 blue:66/255.0 alpha:1.0],
                               [UIColor colorWithRed:223/255.0 green:86/255.0 blue:94/255.0 alpha:1.0],
                               [UIColor colorWithRed:239/255.0 green:130/255.0 blue:100/255.0 alpha:1.0],
                               [UIColor colorWithRed:77/255.0 green:75/255.0 blue:82/255.0 alpha:1.0],
                               [UIColor colorWithRed:105/255.0 green:94/255.0 blue:133/255.0 alpha:1.0],
                               [UIColor colorWithRed:85/255.0 green:176/255.0 blue:112/255.0 alpha:1.0],
                               [UIColor colorWithRed:96/255.0 green:142/255.0 blue:213/255.0 alpha:1.0],nil];
        
        
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithColor:colorArray[[UTIL randomWithMin:0 max:colorArray.count]] size:size];
        background.name = @"background";
        background.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
        [self addChild:background];
//        background.color = colorArray[7];
        
//        [self changeBackground:1];
        
        
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

-(void)changeBackground:(NSInteger)counter {
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Phase A-B"];
    if (counter == 1) {
        [self addChild:bgImage];
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    } if (counter == 2) {
        SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"Phase C-D"];
        [self addChild:bgImage];
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    }
}

// TIME INTERVAL, # OF MONSTERS AND SPEED
-(void)update:(NSTimeInterval)currentTime {
    
    if(self.lastUpdateTimeInterval){
        self.timeSinceEnemyAdded += currentTime - self.lastUpdateTimeInterval;
        //COUNTER THAT STARTS AT 0 FROM GAME START
        self.totalGameTime += currentTime - self.lastUpdateTimeInterval;
    }
    
    float deploy = [UTIL randomWithMin:0 max:2];
    
    
    
    //-------------------------------------- GAME PHASES -------------------------------------------//
    
    int timeInterval_A = startTimeInterval;
    int timeInterval_B = timeInterval_A + specialTimeInterval;
    int timeInterval_C = timeInterval_B + specialTimeInterval;
    int timeInterval_D = timeInterval_C + shortTimeInterval;
    int timeInterval_E = timeInterval_D + pauseTimeInterval;
    int timeInterval_F = timeInterval_E + longTimeInterval;
    int timeInterval_G = timeInterval_F + mediumTimeInterval;
    int timeInterval_H = timeInterval_G + shortTimeInterval;
    int timeInterval_I = timeInterval_H + mediumTimeInterval;
    int timeInterval_J = timeInterval_I + pauseTimeInterval;
    int timeInterval_K = timeInterval_J + shortTimeInterval;
    int timeInterval_L = timeInterval_K + longTimeInterval;
    int timeInterval_M = timeInterval_L + mediumTimeInterval;
    int timeInterval_N = timeInterval_M + pauseTimeInterval;
    int timeInterval_O = timeInterval_N + mediumTimeInterval;
    int timeInterval_P = timeInterval_O + longTimeInterval;
    int timeInterval_Q = timeInterval_P + mediumTimeInterval;
    int timeInterval_R = timeInterval_Q + longTimeInterval;
    int timeInterval_S = timeInterval_R + longTimeInterval;
    
    //-------------------------------------- GAME INSTRUCTIONS -------------------------------------//
   



    
    //--------------------------------------------------------------------------------------------------//
    
    if        (self.totalGameTime<timeInterval_A) {
        if(self.timeSinceEnemyAdded > 10000 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy2]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_B) {
        if(self.timeSinceEnemyAdded > 1.3 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy2]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_C) {
        if(self.timeSinceEnemyAdded > 1.3 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_D) {
        if(self.timeSinceEnemyAdded > 1.6 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy2];  }else{ [self placeEnemy2];}
        self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_E) {
        if(self.timeSinceEnemyAdded > 10000 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy2]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_F) {
        if(self.timeSinceEnemyAdded > 2.0 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_G) {
        if(self.timeSinceEnemyAdded > 1.9 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_H) {
        if(self.timeSinceEnemyAdded > 1.4 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_I) {
        if(self.timeSinceEnemyAdded > 1.2 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_J) {
        if(self.timeSinceEnemyAdded > 10000 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_K) {
        if(self.timeSinceEnemyAdded > 1.1 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    } else if (self.totalGameTime<timeInterval_L) {
        if(self.timeSinceEnemyAdded > 0.9 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_M) {
        if(self.timeSinceEnemyAdded > 0.87 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_N) {
        if(self.timeSinceEnemyAdded > 10000 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_O) {
        if(self.timeSinceEnemyAdded > 0.85 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_P) {
        if(self.timeSinceEnemyAdded > 0.83 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_Q) {
        if(self.timeSinceEnemyAdded > 0.82 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_R) {
        if(self.timeSinceEnemyAdded > 0.80 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else if (self.totalGameTime<timeInterval_S) {
        if(self.timeSinceEnemyAdded > 0.76 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }else {
        if(self.timeSinceEnemyAdded > 0.70 && !self.gameOver){
            if(deploy == 1){ [self placeEnemy1]; }else{ [self placeEnemy2];}
            self.timeSinceEnemyAdded = 0; }
    }
        
    
    
//----------------------------------------------------------------------///
    
    self.lastUpdateTimeInterval = currentTime;
    
    if(self.gameOver  && !self.gameOverDisplayed){
        [self performGameOver];
    }
    
    if(self.treasurePresent && self.totalGameTime > timeInterval_C){
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
    
    //Enemy 1 is the fat one
    
    [self addPoints:5];
    
    SGEnemy2Node *enemy1 = (SGEnemy2Node *)[self childNodeWithName:@"Enemy1"];
    
    //Left
    float y1 = [UTIL randomWithMin:-enemy1.self.size.height max:self.frame.size.height];
    float x1 = self.frame.size.width/10;
    
    //Top
    float y2 = self.frame.size.height+enemy1.size.height*2;
    float x2 = [UTIL randomWithMin:enemy1.size.width*5/10 max:self.frame.size.width-enemy1.size.width*5/10];
    
    //Right
    float y3 = [UTIL randomWithMin:-enemy1.size.height max:self.frame.size.height];
    float x3 = self.frame.size.width*5/6;
    
    //Bottom
    float y4 = -enemy1.size.height*2;
    float x4 = [UTIL randomWithMin:enemy1.size.width*5/10 max:self.frame.size.width-enemy1.size.width*5/10];
    
    NSArray *array = @[@"Left",@"Right",@"Top",@"Bottom"];
    NSInteger i = [UTIL randomWithMin:2 max:4];
    
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
    
    //Enemy 2 is the skinny one
    [self addPoints:3];
    
    SGEnemy2Node *enemy2 = (SGEnemy2Node *)[self childNodeWithName:@"Enemy2"];
    
    //Left
    float y1 = [UTIL randomWithMin:-enemy2.self.size.height max:self.frame.size.height];
    float x1 = self.frame.size.width/10;
    
    //Top
    float y2 = self.frame.size.height+enemy2.size.height;
    float x2 = [UTIL randomWithMin:enemy2.size.width*5/10 max:self.frame.size.width-enemy2.size.width*5/10];
    
    //Right
    float y3 = [UTIL randomWithMin:-enemy2.size.height max:self.frame.size.height];
    float x3 = self.frame.size.width*5/6;
    
    //Bottom
    float y4 = -enemy2.size.height;
    float x4 = [UTIL randomWithMin:enemy2.size.width*5/10 max:self.frame.size.width-enemy2.size.width*5/10];
    
    NSArray *array = @[@"Left",@"Right",@"Top",@"Bottom"];
    NSInteger i = [UTIL randomWithMin:2 max:4];
    
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


//-(void) placeEnemy3 {
//    
//    //Enemy 3 is the new one
//    
//    [self addPoints:10];
//    
//    SGEnemy3Node *enemy3 = (SGEnemy3Node *)[self childNodeWithName:@"Enemy3"];
//    
//    //Left
//    float y1 = [UTIL randomWithMin:-enemy3.self.size.height max:self.frame.size.height];
//    float x1 = self.frame.size.width/10;
//    
//    //Top
//    float y2 = self.frame.size.height*41/40;
//    float x2 = [UTIL randomWithMin:enemy3.size.width*5/10 max:self.frame.size.width-enemy3.size.width*5/10];
//    
//    //Right
//    float y3 = [UTIL randomWithMin:-enemy3.size.height max:self.frame.size.height];
//    float x3 = self.frame.size.width*5/6;
//    
//    //Bottom
//    float y4 = -self.frame.size.height*1/40;
//    float x4 = [UTIL randomWithMin:enemy3.size.width*5/10 max:self.frame.size.width-enemy3.size.width*5/10];
//    
//    NSArray *array = @[@"Left",@"Right",@"Top",@"Bottom"];
//    NSInteger i = [UTIL randomWithMin:2 max:4];
//    
//    if([array[i] isEqualToString:@"Left"]){
//        SGEnemy3Node *enemy3 = [SGEnemy3Node startingEnemy3AtPosition:CGPointMake(x1,y1)];
//        [self addChild:enemy3];
//        [enemy3 runAction:[SKAction rotateByAngle:4.71 duration:0]];
//        float dy = [UTIL randomWithMin:200 max:250];
//        enemy3.physicsBody.velocity = CGVectorMake(dy, 0);
//        [enemy3 fadeOut];
//        
//        
//    }else if([array[i] isEqualToString:@"Top"]){
//        SGEnemy3Node *enemy3= [SGEnemy3Node startingEnemy3AtPosition:CGPointMake(x2,y2)];
//        [self addChild:enemy3];
//        [enemy3 runAction:[SKAction rotateByAngle:3.14 duration:0]];
//        float dy = [UTIL randomWithMin:200 max:250];
//        enemy3.physicsBody.velocity = CGVectorMake(0, -dy);
//        [enemy3 fadeOut];
//        
//    }else if([array[i] isEqualToString:@"Right"]){
//        SGEnemy3Node *enemy3 = [SGEnemy3Node startingEnemy3AtPosition:CGPointMake(x3,y3)];
//        [self addChild:enemy3];
//        [enemy3 runAction:[SKAction rotateByAngle:1.57 duration:0]];
//        float dy = [UTIL randomWithMin:200 max:250];
//        enemy3.physicsBody.velocity = CGVectorMake(-dy, 0);
//        [enemy3 fadeOut];
//        
//    }else if([array[i] isEqualToString:@"Bottom"]){
//        SGEnemy3Node *enemy3 = [SGEnemy3Node startingEnemy3AtPosition:CGPointMake(x4,y4)];
//        [self addChild:enemy3];
//        float dy = [UTIL randomWithMin:200 max:250];
//        enemy3.physicsBody.velocity = CGVectorMake(0, dy);
//        [enemy3 fadeOut];
//        
//    }
//    
//}
//

-(void) placeTreasure {
    
   
    float x = [UTIL randomWithMin:20 max:self.frame.size.width-20];
    float y = [UTIL randomWithMin:20+ self.frame.size.height*1/14 max:self.frame.size.height*13/14-20];
    
    float counter = [UTIL randomWithMin:0 max:2];
    SGTreasureNode *treasure = [SGTreasureNode startingTreasureAtPosition:CGPointMake(x, y) :counter];
    
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
        
        NSUserDefaults *scoreValue = [NSUserDefaults standardUserDefaults];
        [scoreValue setInteger:highScore.score forKey:@"PlayerScore"];

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
    
    SGGameover *gameOver = [SGGameover gameOverAtPosition:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*1.35)];
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
    upgradeCharacter.text =@"Upgrade Character" ;
    upgradeCharacter.fontSize = 24;
    upgradeCharacter.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.9);
    
    SKLabelNode *viewHighScore = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
    viewHighScore.name = @"viewHighScore";
    viewHighScore.text =@"Online HighScore";
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
