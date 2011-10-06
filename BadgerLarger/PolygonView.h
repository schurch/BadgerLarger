//
//  BadgerImageView.h
//  BadgerLarger
//
//  Created by Stefan Church on 02/10/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Polygon.h"
#import "Vertex.h"

@interface PolygonView : UIView {
    NSArray *_polygons;
}

@property (nonatomic, retain) NSArray *polygons;

- (void)clearPolygons;
- (void)drawPolygons:(NSArray *)polyonsToDraw;
    
+ (NSArray *)colors;

@end
