//
//  BadgerLargerViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooserViewController.h"

@interface BadgerLargerViewController : UIViewController<UIScrollViewDelegate, BadgerChooseDelegate> {
    BOOL zoomed;
    IBOutlet UIScrollView *badgerScrollView;
    IBOutlet UIImageView *badgerImageView;
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIToolbar *toolBar;
}

@property (nonatomic, retain) IBOutlet UIScrollView *badgerScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *badgerImageView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

- (IBAction)showBadgerChooser:(id)sender;
- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center;
- (void)resetZoom;
- (IBAction)unlargerAction:(id)sender;
- (IBAction)largerAction:(id)sender;

@end
