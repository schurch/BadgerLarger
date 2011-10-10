//
//  BadgerImageView.m
//  BadgerLarger
//
//  Created by Stefan Church on 02/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PolygonView.h"


@implementation PolygonView

@synthesize polygons = _polygons;

+ (NSArray *)colors {
    static NSArray *polygonColors;
    
    @synchronized(self)
    {
        if (!polygonColors)
            polygonColors = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor yellowColor], [UIColor greenColor], [UIColor blueColor], nil];
        
        return polygonColors;
    }
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)clearPolygons {
    self.polygons = nil;
    [self setNeedsDisplay];
}

- (void)drawPolygons:(NSArray *)polyonsToDraw {
    self.polygons = polyonsToDraw;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    int fillColorIndex = 0;
    for (Polygon *polygon in self.polygons) {
        CGContextBeginPath(contextRef);
        
        Vertex *firstVertex = (Vertex *)[polygon.vertices objectAtIndex:0];
        CGContextMoveToPoint(contextRef, firstVertex.x, firstVertex.y);
        
        for (int i = 1; i < [polygon.vertices count]; i++) {
            Vertex *vertex = (Vertex *)[polygon.vertices objectAtIndex:i];
            CGContextAddLineToPoint(contextRef, vertex.x, vertex.y);
        }
        
        CGContextClosePath(contextRef);
        UIColor *fillColor = [[PolygonView colors] objectAtIndex:(fillColorIndex % [[PolygonView colors] count])];
        [fillColor set];
        CGContextDrawPath(contextRef, kCGPathFill);
        
        fillColorIndex++;
    }
}

- (void)dealloc {
    [_polygons release];
    [super dealloc];
}

@end
