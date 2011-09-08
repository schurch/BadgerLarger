//
//  ChooserButton.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ChooserButton : UIButton {
    NSString *badgerImagePath;
}

@property (nonatomic, retain) NSString *badgerImagePath;

- (UIImage *)badgerImage;
- (id)initWithBadgerThumbImagePath:(NSString *)thumb badgerImagePath:(NSString *)image;

@end
