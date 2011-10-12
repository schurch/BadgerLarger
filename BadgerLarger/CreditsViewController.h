//
//  CreditsViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 08/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CreditsViewController : UIViewController {
    id delegate;
    UINavigationBar *_navigationBar;
}

@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;

- (id)delegate;
- (void)setDelegate:(id)newDelegate;
- (IBAction)done:(id)sender;

@end

@protocol CreditsDoneDelegate <NSObject>
- (void)creditsViewController:(CreditsViewController *)creditsViewController;
@end
