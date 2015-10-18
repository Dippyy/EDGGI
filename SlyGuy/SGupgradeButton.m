//
//  SGupgradeButton.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2015-05-31.
//  Copyright (c) 2015 Robert D'Ippolito. All rights reserved.
//

#import "SGupgradeButton.h"

@implementation SGupgradeButton

+(instancetype) upgradeButtonPosition: (CGPoint) position{
    
  //  SGupgradeButton *buttonTapped = [self spriteNodeWithColor:[UIColor redColor] size:CGSizeMake(100.0, 50.0)];
    
    SGupgradeButton *buttonTapped = [self spriteNodeWithImageNamed:(@"Upgrade")];
    buttonTapped.size = CGSizeMake(100.0, 30.0);

    buttonTapped.position = position;
    buttonTapped.alpha = 1.0;
    buttonTapped.name = @"upgradeButton";
    
    return  buttonTapped;
    
}

@end
