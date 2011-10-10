//
//  BadgerLargerViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "BadgerLargerViewController.h"
#import "ChooserViewController.h"
#import "RectangleUtils.h"
#import "UIColor+CustomColors.h"
#import "Polygon.h"

#define WIN_TEXT @"WIN"
#define FAIL_TEXT @"LOSE"

@implementation BadgerLargerViewController

@synthesize polygonView = _polygonView;
@synthesize largerButton = _largerButton;
@synthesize winFailLabel = _winFailLabel;
@synthesize winLabelText;
@synthesize currentBadger;
@synthesize badgers;
@synthesize winFailView;
@synthesize gameOverView;
@synthesize gameEngine;
@synthesize winLabel;
@synthesize scoreLabel;
@synthesize finalScoreLabel;
@synthesize badgerImageView;
@synthesize badgerScrollView;
@synthesize navigationBar;
@synthesize toolBar;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
    return badgerImageView;
}

- (IBAction)showBadgerChooser:(id)sender 
{
    ChooserViewController *chooserViewController = [[ChooserViewController alloc]
                                                          initWithNibName:@"ChooserView" bundle:nil];
    
    chooserViewController.badgers = self.badgers;
    chooserViewController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:chooserViewController];
    
    navigationController.navigationBar.tintColor = [UIColor navigationGreenColor];
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [chooserViewController release]; 
}

- (void)chooserViewController:(ChooserViewController *)chooserViewController
                    didChangeBadger:(Badger *)badger 
{    
    if(badger) 
    {
        self.currentBadger = badger; 
        [badgerImageView setImage:[UIImage imageWithContentsOfFile:badger.badgerImagePath]];
        [self resetZoom];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{    
    if(scale == 1){
        return;
    }
    
    switch (gameEngine.gameStatus) {
        case GameEngineFinished:
            winLabelText = FAIL_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineWonAndFinished:
            scoreLabel.text = gameEngine.scoreText;
            winLabelText = WIN_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineWon:
            scoreLabel.text = gameEngine.scoreText;
            winLabelText = WIN_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineLost:
            winLabelText = FAIL_TEXT;
            [self showWinFailScreen];
            break;
        default:
            break;
    }
}

- (void)showWinFailScreen
{
    self.winFailLabel.text = winLabelText;
    self.winFailLabel.hidden = NO;
}

- (IBAction)largerAction:(id)sender 
{
    NSLog(@"largerAction called.");    
    self.largerButton.enabled = NO;
    
    CGRect zoomArea = [RectangleUtils randomZoomAreaInRect:badgerScrollView.frame maxZoom:badgerScrollView.maximumZoomScale];

    Polygon *zoomPolygon = [[Polygon alloc] initWithRect:zoomArea];
    Polygon *badgerPolygon = [[Polygon alloc] initWithVertices:currentBadger.badgerOutlinePolygon];

    didWin = [zoomPolygon doesIntersect:badgerPolygon];
    
#ifdef DEBUG
    NSArray *polygons = [[NSArray alloc] initWithObjects:badgerPolygon, zoomPolygon, nil];
    [self.polygonView drawPolygons:polygons];
    [polygons release];
    self.winFailLabel.text = didWin ? WIN_TEXT :FAIL_TEXT;
#endif
    
    [zoomPolygon release];
    [badgerPolygon release];

#ifndef DEBUG
    [badgerScrollView zoomToRect:zoomArea animated:YES];
#endif
    
    [gameEngine didWin:didWin];
    [self performSelector:@selector(resetZoom) withObject:nil afterDelay:2];
}

- (void)resetZoom 
{        
#ifdef DEBUG
    [self.polygonView clearPolygons];
    self.winFailLabel.text = @"";
#endif

    self.winFailLabel.hidden = YES;
    
    if (gameEngine.gameFinished) 
    {
        [gameEngine reset];
        self.scoreLabel.text = gameEngine.scoreText;
    }
    
    [badgerScrollView setZoomScale:1.0 animated:YES];
    self.largerButton.enabled = YES;
}

- (void)dealloc
{
    [badgerImageView release];
    [badgerScrollView release];
    [navigationBar release];
    [toolBar release];
    [_winFailLabel release];
    [_largerButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameEngine = [[GameEngine alloc] init];
    
    navigationBar.tintColor = [UIColor navigationGreenColor];
    toolBar.tintColor = [UIColor navigationGreenColor];
    self.currentBadger = [self.badgers objectAtIndex:0];
    
    WinFailLabel *winFailLabel = [[WinFailLabel alloc] initWithFrame:CGRectMake(66, 167, 200, 73)];
    winFailLabel.backgroundColor = [UIColor clearColor];
    winFailLabel.textColor = [UIColor whiteColor];
    winFailLabel.highlightedTextColor = [UIColor blackColor];
    winFailLabel.textAlignment =  UITextAlignmentCenter;
    winFailLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(90.0)];
    winFailLabel.text = @"";
    winFailLabel.hidden = YES;
    self.winFailLabel = winFailLabel;
    [self.view addSubview:winFailLabel];
    [winFailLabel release];
    
    
#ifdef DEBUG
    PolygonView *polygonView = [[PolygonView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [self.badgerImageView addSubview:polygonView];
    self.polygonView = polygonView;
    [polygonView release];
#endif
}


- (void)viewDidUnload
{
    [self setWinFailLabel:nil];
    [self setLargerButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
