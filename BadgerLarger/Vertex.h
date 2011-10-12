//
//  Coord.h
//  BadgerLarger
//
//  Created by Stefan Church on 12/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vertex : NSObject {
    float _x;
    float _y;
}

@property (nonatomic) float x;
@property (nonatomic) float y;

- (id)initWithX:(float)x y:(float)y;

@end
