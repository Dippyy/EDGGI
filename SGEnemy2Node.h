//
//  SGEnemy2Node.h
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-20.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SGEnemy2Node : SKSpriteNode

+(instancetype) startingEnemy2AtPosition: (CGPoint) position;
-(void) fadeOut;

@end
