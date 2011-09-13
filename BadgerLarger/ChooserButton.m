//
//  ChooserButton.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "ChooserButton.h"
#import <QuartzCore/QuartzCore.h>


@implementation ChooserButton

@synthesize badger = _badger;

- (id)initWithBadger:(Badger *)badger
{
    self = [super init];
    if(self) {
        [badger retain];
        _badger = badger;
        
        [self setImage:[UIImage imageWithContentsOfFile:badger.badgetThumbPath] forState:UIControlStateNormal];
        [self.layer setBorderWidth:1.5];
        [self.layer setCornerRadius:5.0];
        [self.layer setBorderColor:[[UIColor colorWithWhite:0.3 alpha:0.7] CGColor]];
    }
    
    return self;
}

- (void)dealloc
{
    [_badger release];
    [super dealloc];
}

@end
