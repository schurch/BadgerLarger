//
//  BadgerLargerViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooserViewController.h"
#import "Badger.h"
#import "Polygon.h"
#import "PolygonView.h"
#import "WinFailLabel.h"

@interface BadgerLargerViewController : UIViewController<UIScrollViewDelegate, BadgerChooseDelegate> 
{
    BOOL _zoomed;
    BOOL _didWin;
    PolygonView *_polygonView;
    WinFailLabel *_winFailLabel;
    NSMutableArray *_badgers;
    Badger *_currentBadger;
    UIScrollView *_badgerScrollView;
    UIImageView *_badgerImageView;
    UINavigationBar *_navigationBar;
    UIToolbar *_toolBar;
    UIBarButtonItem *_largerButton;
}

@property (nonatomic, retain) PolygonView *polygonView;
@property (nonatomic, retain) WinFailLabel *winFailLabel;
@property (nonatomic, retain) NSMutableArray *badgers;
@property (nonatomic, retain) Badger *currentBadger;
@property (nonatomic, retain) IBOutlet UIScrollView *badgerScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *badgerImageView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *largerButton;

- (IBAction)showBadgerChooser:(id)sender;
- (IBAction)largerAction:(id)sender;
- (void)resetZoom;

@end
