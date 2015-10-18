//
//  UTIL.m
//  SlyGuy
//
//  Created by Robert D'Ippolito on 2014-09-14.
//  Copyright (c) 2014 Robert D'Ippolito. All rights reserved.
//

#import "UTIL.h"

@implementation UTIL

+ (NSInteger)randomWithMin:(NSInteger)min max:(NSInteger)max{
    return arc4random()%(max-min) + min;
}

@end
