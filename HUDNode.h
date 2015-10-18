//
//  HUDNode.h
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-21.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HUDNode : SKNode

@property(nonatomic) NSInteger score;
@property(nonatomic) NSInteger highScore;
@property(nonatomic, strong) NSMutableArray* items;



+(instancetype) hudAtPosition: (CGPoint)position inFrame:(CGRect)frame;

-(void) addPoints:(NSInteger)addPoints;

@end
