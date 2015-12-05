//
//  UTIL.h
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-14.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//  THIS IS TESTING GITHUB COLLABORATION_1

#import <Foundation/Foundation.h>

static const int pointsPerHit = 10;

typedef NS_OPTIONS(uint32_t, collisionCategory) {
    
    collisionCategoryPlayer                 = 1 << 0,
    collisionCategoryTreasure               = 1 << 1,
    collisionCategoryEnemy1                 = 1 << 2

};

@interface UTIL : NSObject

+ (NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max;

@end
