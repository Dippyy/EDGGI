//
//  playAgainButton.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2015-05-31.
//  Copyright (c) 2015 Robert D'Ippolito. All rights reserved.
//

#import "playAgainButton.h"

@implementation playAgainButton

+(instancetype) playAgainButtonPosition: (CGPoint) position{
    
    playAgainButton *buttonTapped = [self spriteNodeWithImageNamed:(@"PlayAgainButton")];
    buttonTapped.size = CGSizeMake(130.0, 35.0);
    buttonTapped.position = position;
    buttonTapped.alpha = 1.0;
    buttonTapped.name = @"playAgainButton";
    
    return  buttonTapped;
    
}

@end
