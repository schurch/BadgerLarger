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
#define FAIL_TEXT @"FAIL"

@implementation BadgerLargerViewController

@synthesize currentBadger;
@synthesize badgers;
@synthesize winFailView;
@synthesize gameOverView;
@synthesize gameEngine;
@synthesize winLabel;
@synthesize scoreLabel;
@synthesize finalScoreLabel;
@synthesize attemptsLabel;
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
    switch (gameEngine.gameStatus) {
        case GameEngineFinished:
            winLabel.text = FAIL_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineWonAndFinished:
            scoreLabel.text = gameEngine.scoreText;
            winLabel.text = WIN_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineWon:
            scoreLabel.text = gameEngine.scoreText;
            winLabel.text = WIN_TEXT;
            [self showWinFailScreen];
            break;
        case GameEngineLost:
            winLabel.text = FAIL_TEXT;
            [self showWinFailScreen];
            break;
        default:
            break;
    }
    
    self.attemptsLabel.text = gameEngine.attemptsText;
}

- (void)showWinFailScreen
{
    if(!self.winFailView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"WinFailView" owner:self options:nil];
        winFailView.frame = CGRectMake(0, 75, winFailView.frame.size.width, winFailView.frame.size.height);  
        [self.view addSubview:winFailView];
    }
    else
    {
        winFailView.hidden = FALSE;
    }
    
    [self shrinkanimate];
}

- (void)showGameOverScreen 
{
    if(!self.gameOverView)
    {
        [[NSBundle mainBundle] loadNibNamed:@"GameOverView" owner:self options:nil];
        gameOverView.frame = CGRectMake(0, 75, gameOverView.frame.size.width, gameOverView.frame.size.height);  
        [self.view addSubview:gameOverView];
    }
    
    winFailView.hidden = TRUE;    
    gameOverView.hidden = FALSE;
    finalScoreLabel.text = gameEngine.scoreText;
}

- (void)shrinkanimate
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(growanimate)];
    winLabel.transform = CGAffineTransformMakeScale(0.5f, 0.5f);
    [UIView commitAnimations];
}

- (void)growanimate
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    
    if (gameEngine.gameFinished) 
    {
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(showGameOverScreen)];
    }

    winLabel.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
    [UIView commitAnimations];
}

- (IBAction)unlargerAction:(id)sender 
{
    [self resetZoom];
}

- (IBAction)largerAction:(id)sender 
{    
    if (zoomed) 
    {
        return;
    }
    
    CGRect zoomArea = [RectangleUtils randomZoomAreaInRect:badgerScrollView.frame maxZoom:badgerScrollView.maximumZoomScale];
    [badgerScrollView zoomToRect:zoomArea animated:YES];
    zoomed = TRUE;
    
    Polygon *zoomPolygon = [[Polygon alloc] initWithRect:zoomArea];
    Polygon *badgerPolygon = [[Polygon alloc] initWithVertices:currentBadger.badgerOutlinePolygon];
    
    didWin = [zoomPolygon doesIntersect:badgerPolygon];
    
    [zoomPolygon release];
    [badgerPolygon release];
    
    [gameEngine didWin:didWin];
}

- (void)resetZoom 
{    
    if (gameEngine.gameFinished) 
    {
        [gameEngine reset];
        self.scoreLabel.text = gameEngine.scoreText;
        self.attemptsLabel.text = gameEngine.attemptsText;
        gameOverView.hidden = TRUE;
    }
    else
    {
        winFailView.hidden = TRUE;
    }
    
    [badgerScrollView setZoomScale:1.0 animated:NO];
    zoomed = FALSE;
}

- (void)dealloc
{
    [badgerImageView release];
    [badgerScrollView release];
    [navigationBar release];
    [toolBar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gameEngine = [[GameEngine alloc] init];
    
    navigationBar.tintColor = [UIColor navigationGreenColor];
    toolBar.tintColor = [UIColor navigationGreenColor];
    attemptsLabel.text = gameEngine.attemptsText;
    
    self.currentBadger = [self.badgers objectAtIndex:0];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
