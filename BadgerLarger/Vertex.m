//
//  Coord.m
//  BadgerLarger
//
//  Created by Stefan Church on 12/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "Vertex.h"


@implementation Vertex

@synthesize x = _x;
@synthesize y = _y;

- (id)initWithX:(float)x y:(float)y 
{
    self = [super init];
    if (self) 
    {
        self.x = x;
        self.y = y;
    }
    
    return self;
}

@end
