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

@interface BadgerLargerViewController : UIViewController<UIScrollViewDelegate, BadgerChooseDelegate> {
    GameEngine *gameEngine;
    NSArray *badgers;
    BOOL zoomed;
    BOOL didWin;
    IBOutlet UIView *winFailView;
    IBOutlet UIView *gameOverView;
    IBOutlet UILabel *winLabel;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UILabel *finalScoreLabel;
    IBOutlet UILabel *attemptsLabel;
    IBOutlet UIScrollView *badgerScrollView;
    IBOutlet UIImageView *badgerImageView;
    IBOutlet UINavigationBar *navigationBar;
    IBOutlet UIToolbar *toolBar;
}

@property (nonatomic, retain) NSArray *badgers;
@property (nonatomic, retain) UIView *winFailView;
@property (nonatomic, retain) UIView *gameOverView;
@property (nonatomic, retain) GameEngine *gameEngine;
@property (nonatomic, retain) IBOutlet UILabel *winLabel;
@property (nonatomic, retain) IBOutlet UILabel *finalScoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *scoreLabel;
@property (nonatomic, retain) IBOutlet UILabel *attemptsLabel;
@property (nonatomic, retain) IBOutlet UIScrollView *badgerScrollView;
@property (nonatomic, retain) IBOutlet UIImageView *badgerImageView;
@property (nonatomic, retain) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, retain) IBOutlet UIToolbar *toolBar;

- (void)growanimate;
- (void)shrinkanimate;
- (IBAction)showBadgerChooser:(id)sender;
- (void)resetZoom;
- (void)showWinFailScreen;
- (void)showGameOverScreen;
- (IBAction)unlargerAction:(id)sender;
- (IBAction)largerAction:(id)sender;

@end
