//
//  RectangleUtils.m
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
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
    
    if(zoomRect.origin.x < 0) {
        NSLog(@"Zoom rect orgin.x < 0");
        zoomRect.origin.x = 0;
        NSLog(@"Zoom rect orgin.x = 0");
    }
    
    if((zoomRect.origin.x + zoomRect.size.width) > rect.size.width) {
        NSLog(@"Zoom rect orgin.x + width > %f", rect.size.width);
        zoomRect.origin.x = rect.size.width - zoomRect.size.width;
        NSLog(@"Zoom rect orgin.x = %f", zoomRect.origin.x);
    }
    
    if(zoomRect.origin.y < 0) {
        NSLog(@"Zoom rect orgin.y < 0");
        zoomRect.origin.y = 0;
        NSLog(@"Zoom rect orgin.y = 0");
    }
    
    if((zoomRect.origin.y + zoomRect.size.height) > rect.size.height) {
        NSLog(@"Zoom rect orgin.y + height > %f", rect.size.height);
        zoomRect.origin.y = rect.size.height - zoomRect.size.height;
        NSLog(@"Zoom rect orgin.y = %f", zoomRect.origin.y);
    }
    
    return zoomRect;
}

@end
