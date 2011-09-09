//
//  ChooserViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreditsViewController.h"

@interface ChooserViewController : UIViewController <CreditsDoneDelegate>  {
    id delegate;
    IBOutlet UIScrollView *scrollView;
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

- (id)delegate;
- (void)setDelegate:(id)newDelegate;

- (IBAction)showCredits:(id)sender;
- (void)close:(id)sender;
- (int)layoutBadgerButtons:(NSArray *)badgerButtons;

@end

@protocol BadgerChooseDelegate <NSObject>
// badgerImage  == nil on cancel
- (void)chooserViewController:(ChooserViewController *)chooserViewController
                    didChangeBadger:(UIImage *)badgerImage;
@end
