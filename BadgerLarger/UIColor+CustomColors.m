//
//  UIColor+CustomColors.m
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "UIColor+CustomColors.h"


@implementation UIColor(CustomColors)

+ (UIColor *)navigationGreenColor 
{    
    static UIColor *color = nil;
    
    if(!color) {
        color = [[UIColor alloc] initWithRed:0.0/255.0 green:150.0/255.0 blue:0.0/255.0  alpha:1.0];
    }
    
    return color;
}

@end
