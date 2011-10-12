//
//  ChooserViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "ChooserViewController.h"
#import "ChooserButton.h"
#import "CreditsViewController.h"
#include <math.h>

#define SCREEN_WIDTH 320
#define THUMBNAIL_SIZE 90
#define THUMBNAIL_MARGIN 12.5

@implementation ChooserViewController

@synthesize badgers = _badgers;
@synthesize scrollView = _scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Badgers";
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
        self.navigationItem.rightBarButtonItem = cancelButton;
        [cancelButton release];
    
    }
    return self;
}

- (id)delegate 
{
    return delegate;
}

- (void)setDelegate:(id)newDelegate 
{
    delegate = newDelegate;
}

- (IBAction)showCredits:(id)sender 
{
    CreditsViewController *creditsViewController = [[CreditsViewController alloc]
                                                    initWithNibName:@"CreditsView" bundle:nil];
    
    creditsViewController.delegate = self;
    creditsViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:creditsViewController animated:YES];
    [creditsViewController release];
}

- (void)creditsViewController:(CreditsViewController *)creditsViewController
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)close:(id)sender 
{    
    if([[self delegate] respondsToSelector:@selector(chooserViewController: didChangeBadger:)]) {
        if([sender isKindOfClass:[ChooserButton class]]) {
            ChooserButton *button = (ChooserButton *)sender;
            [[self delegate] chooserViewController:self didChangeBadger:button
             .badger];
        } else {
            [[self delegate] chooserViewController:self didChangeBadger:nil];
        }
	}
    
}

- (int)layoutBadgerButtons:(NSArray *)badgerButtons 
{    
    int rows = 0;
    
    float x = THUMBNAIL_MARGIN;
    float y = THUMBNAIL_MARGIN;
    
    for (ChooserButton *badgerButton in badgerButtons) {
        [badgerButton setFrame:CGRectMake(x, y, THUMBNAIL_SIZE, THUMBNAIL_SIZE)];
        [badgerButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:badgerButton];
        
        x+= THUMBNAIL_SIZE + THUMBNAIL_MARGIN;
        
        if((fmod(x, SCREEN_WIDTH)) == 0.0) {
            x = THUMBNAIL_MARGIN;
            y += THUMBNAIL_SIZE + THUMBNAIL_MARGIN;
            rows++;
        }
    }
    
    return rows;
}


- (void)dealloc
{
    [_scrollView release];
    
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
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *badgerButtons = [[NSMutableArray alloc] init];
    
    for (Badger *badger in self.badgers) {
        ChooserButton *button = [[ChooserButton alloc] initWithBadger:badger];
        [badgerButtons addObject:button];
        [button release];
    }

    int badgerButtonRows = [self layoutBadgerButtons:badgerButtons];
    
    CGFloat scrollViewHeight = (badgerButtonRows * THUMBNAIL_SIZE) + (badgerButtonRows * THUMBNAIL_MARGIN) + THUMBNAIL_MARGIN;
    
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, scrollViewHeight); 
    
    [badgerButtons release];
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
