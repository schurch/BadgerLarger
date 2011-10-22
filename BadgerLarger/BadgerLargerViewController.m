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

@synthesize polygonView = _polygonView;
@synthesize largerButton = _largerButton;
@synthesize winFailLabel = _winFailLabel;
@synthesize currentBadger = _currentBadger;
@synthesize badgers = _badgers;
@synthesize badgerImageView = _badgerImageView;
@synthesize badgerScrollView = _badgerScrollView;
@synthesize navigationBar = _navigationBar;
@synthesize toolBar = _toolBar;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView 
{
    return self.badgerImageView;
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
    if(badger) {
        self.currentBadger = badger; 
        [self.badgerImageView setImage:[UIImage imageWithContentsOfFile:badger.badgerImagePath]];
        [self resetZoom];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{    
    if(scale == 1){
        return;
    }
    
    self.winFailLabel.text = _didWin ? WIN_TEXT : FAIL_TEXT;
    self.winFailLabel.hidden = NO;
}

- (IBAction)largerAction:(id)sender 
{ 
    self.largerButton.enabled = NO;
    
    CGRect zoomArea = [RectangleUtils randomZoomAreaInRect:self.badgerScrollView.frame maxZoom:self.badgerScrollView.maximumZoomScale];

    Polygon *zoomPolygon = [[Polygon alloc] initWithRect:zoomArea];
    Polygon *badgerPolygon = [[Polygon alloc] initWithVertices:self.currentBadger.badgerOutlinePolygon];

    _didWin = [zoomPolygon doesIntersect:badgerPolygon];
    
#ifdef DEBUG
    NSArray *polygons = [[NSArray alloc] initWithObjects:badgerPolygon, zoomPolygon, nil];
    [self.polygonView drawPolygons:polygons];
    [polygons release];
    self.winFailLabel.text = didWin ? WIN_TEXT :FAIL_TEXT;
#endif
    
    [zoomPolygon release];
    [badgerPolygon release];

#ifndef DEBUG
    [self.badgerScrollView zoomToRect:zoomArea animated:YES];
#endif
    
    [self performSelector:@selector(resetZoom) withObject:nil afterDelay:2];
}

- (void)resetZoom 
{        
#ifdef DEBUG
    [self.polygonView clearPolygons];
    self.winFailLabel.text = @"";
#endif
    
    self.winFailLabel.hidden = YES;    
    self.largerButton.enabled = YES;

    [self.badgerScrollView setZoomScale:1.0 animated:YES];
}

- (void)handleSingleTap:(UIGestureRecognizer *)sender {
    CGPoint tapPoint = [sender locationInView:sender.view];
    
    int x = (int)tapPoint.x;
    int y = (int)tapPoint.y - 46;
    
    static NSMutableString *_coordsString;
    
    if (!_coordsString) {
        _coordsString = [[NSMutableString alloc] init];
        [_coordsString appendFormat:@"(%i,%i)", x, y];
    }else{
        [_coordsString appendFormat:@",(%i,%i)", x, y];
    }
    
    NSLog(@"%@", _coordsString);
}

- (void)dealloc
{
    [_polygonView release];
    [_winFailLabel release];
    [_badgers release];
    [_currentBadger release];
    [_badgerScrollView release];
    [_badgerImageView release];
    [_navigationBar release];
    [_toolBar release];
    [_largerButton release];

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor navigationGreenColor];
    self.toolBar.tintColor = [UIColor navigationGreenColor];
    
    self.currentBadger = [self.badgers objectAtIndex:0];
    [self.badgerImageView setImage:[UIImage imageWithContentsOfFile:self.currentBadger.badgerImagePath]];
    
    CGFloat labelHeight = 100;
    CGFloat labelWidth = 250;
    CGFloat labelX = (self.view.frame.size.width / 2) - (labelWidth / 2);
    CGFloat labelY = (self.view.frame.size.height / 2) - (labelHeight / 2);
    WinFailLabel *winFailLabel = [[WinFailLabel alloc] initWithFrame:CGRectMake(labelX, labelY, labelWidth, labelHeight)];
    winFailLabel.backgroundColor = [UIColor clearColor];
    winFailLabel.textColor = [UIColor whiteColor];
    winFailLabel.highlightedTextColor = [UIColor blackColor];
    winFailLabel.textAlignment =  UITextAlignmentCenter;
    winFailLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:(80.0)];
    winFailLabel.adjustsFontSizeToFitWidth = YES;
    winFailLabel.text = @"";
    winFailLabel.hidden = YES;
    self.winFailLabel = winFailLabel;
    [self.view addSubview:winFailLabel];
    [winFailLabel release];
    
    
//    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
//    tapRecognizer.numberOfTapsRequired = 1;
//    [self.view addGestureRecognizer:tapRecognizer];
//    [tapRecognizer release];
    
#ifdef DEBUG
    PolygonView *polygonView = [[PolygonView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [self.badgerImageView addSubview:polygonView];
    self.polygonView = polygonView;
    [polygonView release];
#endif
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
