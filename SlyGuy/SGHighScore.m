//
//  SGHighScore.m
//  SlyGuy
//
//  Created by Alex on 2015-08-29.
//  Copyright (c) 2015 Robert D'Ippolito. All rights reserved.
//

#import "SGHighScore.h"
#import "UTIL.h"
#import <Parse/Parse.h>
#import "SGGameplayScene.h"
#import "SGTitleScreenScene.h"

@implementation SGHighScore

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

        
        //Hall of Fame Title
        SKLabelNode *titleScreen = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        titleScreen.name = @"Hall of Fame";
        titleScreen.text =@"Hall of Fame";
        titleScreen.fontSize = 38;
        titleScreen.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+3*(CGRectGetMidY(self.frame)/4));
        [self addChild:titleScreen];
        
        //Name of Player
        
        SKLabelNode *playerName = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        playerName.name = @"playerName";
        playerName.fontSize = 25;
        playerName.alpha = 0.8;
        playerName.position = CGPointMake(CGRectGetMidX(self.frame)*4/3, CGRectGetMidY(self.frame)+2*(CGRectGetMidY(self.frame)/4));
        [self addChild:playerName];
        
        NSUserDefaults *playerNameDisplay = [NSUserDefaults standardUserDefaults];
        NSString *playerFBName = [playerNameDisplay valueForKey:@"PlayerFirstName"];
        
        SKLabelNode *playerNameText = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        playerNameText.name = @"playerName";
        playerNameText.text = playerFBName;
        playerNameText.fontSize = 25;
        playerNameText.alpha = 0.8;
        playerNameText.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+2*(CGRectGetMidY(self.frame)/4));
        [self addChild:playerNameText];

        //Highscore
        
        SKLabelNode *titlehighScore = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        titlehighScore.name = @"titleHighScore";
        titlehighScore.fontSize = 25;
        titlehighScore.alpha = 0.7;
        titlehighScore.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+1*(CGRectGetMidY(self.frame)/3.5));
        titlehighScore.text = [NSString stringWithFormat:@"Your High Score: %ld",(long)[[NSUserDefaults standardUserDefaults] integerForKey:@"HighscoreSaved"]];
        [self addChild:titlehighScore];
        
        //Edit Name of Player
        SKLabelNode *editName = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        editName.name = @"nameEdit";
        editName.text =@"";
        editName.fontSize = 10;
        editName.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+1*(CGRectGetMidY(self.frame)/10));
        [self addChild:editName];
        
        //Top 5 Scores

        PFQuery *queryHighScore = [PFQuery queryWithClassName:@"Highscore"];
        [queryHighScore selectKeys:@[@"Name",@"scoreValue"]];
         queryHighScore.limit = 5;
        [queryHighScore orderByDescending:@"scoreValue"];

        [queryHighScore findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
                int counter = 0;
                for (PFObject *object in objects) {

                    counter = counter + 1 ;
                    int fontSize;
                    if (counter == 1) {
                        fontSize = 30;
                    } else {
                        fontSize = 20;
                    }
                    
                    SKLabelNode *Name = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
                    NSString *fullName = [object objectForKey:@"Name"];
                    NSArray *fullNameSeparated = [fullName componentsSeparatedByString:@" "];
                    NSString *lastName = [fullNameSeparated[1] substringToIndex:1];
                    
//                  NSArray *rankName = [NSArray arrayWithObjects: @"Champ", @"Master", @"Pro", @"Pro", @"Pro", nil];
                    NSString *fbhighScoreName = [NSString stringWithFormat: @"%@  %@", fullNameSeparated[0], lastName];
                    Name.text = fbhighScoreName;
                    Name.fontSize = fontSize;
                    
                    if (counter == 1) {
                        Name.position = CGPointMake(CGRectGetMidX(self.frame)*9/10, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/11));
                    } else {
                        Name.position = CGPointMake(CGRectGetMidX(self.frame)*9/10, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/9));
                    }
                    [self addChild:Name];
                    
                    NSString *counterString = [NSString stringWithFormat:@"%i", counter];
                   
                    
                    SKLabelNode *Rank = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
                    Rank.text = counterString;
                    Rank.fontSize = fontSize;
                    if (counter == 1) {
                    Rank.position = CGPointMake(CGRectGetMidX(self.frame)*4/10, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/11));
                    } else {
                        Rank.position = CGPointMake(CGRectGetMidX(self.frame)*4/10, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/9));
                    }
                    [self addChild:Rank];
                    
                    SKLabelNode *scoreValue = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
                    scoreValue.text = [NSString stringWithFormat:@"%@", [object objectForKey:@"scoreValue"]];
                    scoreValue.fontSize = fontSize;
                    if (counter == 1 ) {
                    scoreValue.position = CGPointMake(CGRectGetMidX(self.frame)*3/2, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/11));
                    } else { scoreValue.position = CGPointMake(CGRectGetMidX(self.frame)*3/2, CGRectGetMidY(self.frame)*7/8-(CGRectGetMidY(self.frame)*counter/9));
                    }
                    [self addChild:scoreValue];

                    if (counter > 4) {
                        break;
                    }
                }
        }];
        
        SKLabelNode *homeButton = [SKLabelNode labelNodeWithFontNamed:@"Nexa Bold"];
        homeButton.name = @"homeButton";
        homeButton.text =@"Home";
        homeButton.fontSize = 30;
        homeButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-(CGRectGetMidY(self.frame)*12/13));
        [self addChild:homeButton];
        
        
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];


    if([node.name isEqualToString:@"homeButton"]){
        SGTitleScreenScene *titleScene = [SGTitleScreenScene sceneWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:titleScene transition:transition];
    }
    
}

@end


