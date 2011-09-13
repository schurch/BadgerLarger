//
//  Polygon.h
//  BadgerLarger
//
//  Created by Stefan Church on 13/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "gpc.h"


@interface Polygon : NSObject {
    NSArray *_vertices;
}

+ (gpc_polygon *)generateGpcPoly:(NSArray *)vertices;

@property (nonatomic, readonly) NSArray *vertices;

- (id)initWithRect:(CGRect)zoomArea;
- (id)initWithVertices:(NSArray *)vertices;
- (BOOL)doesIntersect:(Polygon *)polygon;


@end
