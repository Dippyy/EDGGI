//
//  SGPlayerNode.h
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-12.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SGPlayerNode : SKSpriteNode

+(instancetype) startingPlayerAtPosition: (CGPoint) position asCharacter:(NSString*)characterName;


@end
