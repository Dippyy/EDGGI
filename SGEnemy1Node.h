//
//  SGEnemy1Node.h
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-14.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SGEnemy1Node : SKSpriteNode

+(instancetype) startingPlayerAtPosition: (CGPoint) position;
-(void) fadeOut;

@end
