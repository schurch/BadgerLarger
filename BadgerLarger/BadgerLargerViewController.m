//
//  BadgerLargerViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BadgerLargerViewController.h"
#import "ChooserViewController.h"

@implementation BadgerLargerViewController

@synthesize badgerImageView;
@synthesize badgerScrollView;

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return badgerImageView;
}

- (IBAction)showBadgerChooser:(id)sender {
    // Create the root view controller for the navigation controller
    // The new view controller configures a Cancel and Done button for the
    // navigation bar.
    ChooserViewController *chooserViewController = [[ChooserViewController alloc]
                                                          initWithNibName:@"ChooserViewController" bundle:nil];
    
    // Configure the RecipeAddViewController. In this case, it reports any
    // changes to a custom delegate object.
    chooserViewController.delegate = self;
    
    // Create the navigation controller and present it modally.
    UINavigationController *navigationController = [[UINavigationController alloc]
                                                    initWithRootViewController:chooserViewController];
    
    navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.0/255.0 green:150.0/255.0 blue:0.0/255.0 alpha:1.0];
    //navigationController.title = @"Badger Chooser";
    
    [self presentModalViewController:navigationController animated:YES];
    
    
    // The navigation controller is now owned by the current view controller
    // and the root view controller is owned by the navigation controller,
    // so both objects should be released to prevent over-retention.
    [navigationController release];
    [chooserViewController release]; 
}

- (void)chooserViewController:(ChooserViewController *)chooserViewController
                    didChangeBadger:(UIImage *)badgerImage {
    
    if(badgerImage != nil) {
        [badgerImageView setImage:badgerImage];
        [self resetZoom];
    }
    
    [self dismissModalViewControllerAnimated:TRUE];
}

- (IBAction)unlargerAction:(id)sender {
    
    [self resetZoom];
}

- (IBAction)largerAction:(id)sender {
    
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

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)resetZoom {
    
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
