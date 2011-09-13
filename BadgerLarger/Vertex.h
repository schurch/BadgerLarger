//
//  Coord.h
//  BadgerLarger
//
//  Created by Stefan Church on 12/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Vertex : NSObject {
    float x;
    float y;
}

- (id)initWithX:(float)theX y:(float)theY;

@property (nonatomic) float x;
@property (nonatomic) float y;

@end
