//
//  RectangleUtils.m
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RectangleUtils.h"


@implementation RectangleUtils

+ (CGRect)randomZoomAreaInRect:(CGRect)rect maxZoom:(float)zoom 
{
    float randomX = (float)(arc4random() % (int)rect.size.width);
    float randomY = (float)(arc4random() % (int)rect.size.height);
    float randomScale = (float)(arc4random() % (int)zoom);
    
    randomScale = randomScale < 2.0 ? 2.0 : randomScale;
    
    CGPoint zoomPoint;
    zoomPoint.x = randomX;
    zoomPoint.y = randomY;
    
    CGRect zoomArea = [RectangleUtils zoomAreaForOrginalRect:rect withScale:randomScale withCenter:zoomPoint];
    
    return zoomArea;
}

+ (CGRect)zoomAreaForOrginalRect:(CGRect)rect withScale:(float)scale withCenter:(CGPoint)center 
{    
    CGRect zoomRect;
    
    zoomRect.size.height = rect.size.height / scale;
    zoomRect.size.width  = rect.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

+ (BOOL)doesRectIntersect:(CGRect)rectA rectB:(CGRect)rectB 
{
    float rectAx1 = rectA.origin.x;
    float rectAx2 = rectA.origin.x + rectA.size.width;
    float rectBx1 = rectB.origin.x;
    float rectBx2 = rectB.origin.x + rectB.size.width;
    
    float rectAy1 = rectA.origin.y;
    float rectAy2 = rectA.origin.y + rectA.size.height;
    float rectBy1 = rectB.origin.y;
    float rectBy2 = rectB.origin.y + rectB.size.height;
    
    if (rectAx1 < rectBx2 && rectAx2 > rectBx1 &&
        rectAy1 < rectBy2 && rectAy2 > rectBy1)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

@end
