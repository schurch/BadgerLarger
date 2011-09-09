//
//  BadgerLargerViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "BadgerLargerViewController.h"
#import "ChooserViewController.h"
#import "UIColor+CustomColors.h"

@implementation BadgerLargerViewController

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
    
    chooserViewController.delegate = self;
    
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:chooserViewController];
    
    navigationController.navigationBar.tintColor = [UIColor navigationGreenColor];
    
    [self presentModalViewController:navigationController animated:YES];
    
    [navigationController release];
    [chooserViewController release]; 
}

- (void)chooserViewController:(ChooserViewController *)chooserViewController
                    didChangeBadger:(UIImage *)badgerImage 
{    
    if(badgerImage != nil) {
        [badgerImageView setImage:badgerImage];
        [self resetZoom];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)unlargerAction:(id)sender 
{
    [self resetZoom];
}

- (IBAction)largerAction:(id)sender 
{    
    if (zoomed) {
        return;
    }
    
    float randomX = (float)(arc4random() % (int)self.badgerScrollView.frame.size.width);
    float randomY = (float)(arc4random() % (int)self.badgerScrollView.frame.size.height);
    float randomScale = (float)(arc4random() % (int)self.badgerScrollView.maximumZoomScale);
    
    randomScale = randomScale < 2.0 ? 2.0 : randomScale;
    
    CGPoint zoomPoint;
    zoomPoint.x = randomX;
    zoomPoint.y = randomY;
    
    CGRect zoomArea = [self zoomRectForScrollView:badgerScrollView withScale:randomScale withCenter:zoomPoint];
    
    [badgerScrollView zoomToRect:zoomArea animated:YES];
    
    zoomed = TRUE;
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center 
{    
    CGRect zoomRect;
    
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)resetZoom 
{    
    [badgerScrollView setZoomScale:1.0 animated:NO];
    zoomed = FALSE;
}

- (void)dealloc
{
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
    
    navigationBar.tintColor = [UIColor navigationGreenColor];
    toolBar.tintColor = [UIColor navigationGreenColor];
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
