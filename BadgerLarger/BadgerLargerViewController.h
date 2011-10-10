//
//  BadgerLargerViewController.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChooserViewController.h"
#import "GameEngine.h"
#import "Badger.h"
#import "Polygon.h"
#import "PolygonView.h"
#import "WinFailLabel.h"

@interface BadgerLargerViewController : UIViewController<UIScrollViewDelegate, BadgerChooseDelegate> 
{
    PolygonView *_polygonView;
    NSString *winLabelText;
    GameEngine *gameEngine;
    NSMutableArray *badgers;
    Badger *currentBadger;
    BOOL zoomed;
    BOOL didWin;
    UIView *winFailView;
    UIView *gameOverView;
    UILabel *winLabel;
    UILabel *scoreLabel;
    UILabel *finalScoreLabel;
    UIScrollView *badgerScrollView;
    UIImageView *badgerImageView;
    UINavigationBar *navigationBar;
    UIToolbar *toolBar;
    WinFailLabel *_winFailLabel;
    UIButton *_largerButton;
}

@property (nonatomic, retain) IBOutlet UIButton *largerButton;
@property (nonatomic, retain) WinFailLabel *winFailLabel;
@property (nonatomic, retain) NSString *winLabelText;
@property (nonatomic, retain) IBOutlet UIView *winFailView;
@property (nonatomic, retain) NSMutableArray *badgers;
@property (nonatomic, retain) Badger *currentBadger;
@property (nonatomic, retain) UIView *gameOverView;
@property (nonatomic, retain) GameEngine *gameEngine;
@property (nonatomic, retain) IBOutlet UILabel *winLabel;
@property (nonatomic, retain) IBOutlet UILabel *finalScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *badgerScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *badgerImageView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;
@property (nonatomic, retain) PolygonView *polygonView;

- (IBAction)showBadgerChooser:(id)sender;
- (void)resetZoom;
- (void)showWinFailScreen;
- (IBAction)largerAction:(id)sender;

@end
