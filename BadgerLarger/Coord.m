//
//  Coord.m
//  BadgerLarger
//
//  Created by Stefan Church on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Coord.h"


@implementation Coord

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
