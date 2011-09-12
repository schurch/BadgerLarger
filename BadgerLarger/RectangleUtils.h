//
//  RectangleUtils.h
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RectangleUtils : NSObject {
    
}

+ (CGRect)randomZoomAreaInRect:(CGRect)rect maxZoom:(float)zoom;
+ (CGRect)zoomAreaForOrginalRect:(CGRect)rect withScale:(float)scale withCenter:(CGPoint)center;
+ (BOOL)doesRectIntersect:(CGRect)rectA rectB:(CGRect)rectB;

@end
