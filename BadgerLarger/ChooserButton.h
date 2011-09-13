//
//  ChooserButton.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Badger.h"


@interface ChooserButton : UIButton {
    Badger *_badger;
}

@property (nonatomic, retain) Badger *badger;

- (id)initWithBadger:(Badger *)badger;

@end
