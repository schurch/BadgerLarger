//
//  BadgerChooserViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 24/08/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface BadgerChooserViewController : UIViewController {
    id delegate;
}

- (id)delegate;
- (void)setDelegate:(id)newDelegate;
- (IBAction)close:(id)sender;

@end

@protocol BadgerChangeDelegate <NSObject>
// badgerImage  == nil on cancel
- (void)badgerChooserViewController:(BadgerChooserViewController *)badgerChooserViewController
                    didChangeBadger:(NSString *)badgerImage;
@end
