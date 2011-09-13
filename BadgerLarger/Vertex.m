//
//  Coord.m
//  BadgerLarger
//
//  Created by Stefan Church on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Vertex.h"


@implementation Vertex

@synthesize x;
@synthesize y;

- (id)initWithX:(float)theX y:(float)theY 
{
    self = [super init];
    if (self) 
    {
        self.x = theX;
        self.y = theY;
    }
    
    return self;
}

@end
