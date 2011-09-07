//
//  ChooserViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "ChooserViewController.h"
#import "ChooserButton.h"
#include <math.h>

#define SCREEN_WIDTH 320
#define THUMBNAIL_SIZE 90
#define THUMBNAIL_MARGIN 12.5

@implementation ChooserViewController

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

- (id)delegate {
    return delegate;
}

- (void)setDelegate:(id)newDelegate {
    delegate = newDelegate;
}

- (void)close:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(chooserViewController: didChangeBadger:)]) {
        if([sender isKindOfClass:[ChooserButton class]]) {
            ChooserButton *button = (ChooserButton *)sender;
            [[self delegate] chooserViewController:self didChangeBadger:button.imageView.image];
        } else {
            [[self delegate] chooserViewController:self didChangeBadger:nil];
        }
	}
    
}

- (void)layoutBadgerButtons:(NSArray *)badgerButtons {
    
    float x = THUMBNAIL_MARGIN;
    float y = THUMBNAIL_MARGIN;
    
    for (ChooserButton *badgerButton in badgerButtons) {
        [badgerButton setFrame:CGRectMake(x, y, THUMBNAIL_SIZE, THUMBNAIL_SIZE)];
        [badgerButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:badgerButton];
        
        x+= THUMBNAIL_SIZE + THUMBNAIL_MARGIN;
        
        if((fmod(x, SCREEN_WIDTH)) == 0.0) {
            x = THUMBNAIL_MARGIN;
            y += THUMBNAIL_SIZE + THUMBNAIL_MARGIN;
        }
    }
    
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSMutableArray *badgerButtons = [[NSMutableArray alloc] init];
    
    NSArray *badgerImagePaths = [[NSBundle mainBundle] pathsForResourcesOfType: @"jpg" inDirectory:@"Badgers"];
    
    for (NSString *imagePath in badgerImagePaths) {
        NSLog(@"%@", imagePath);
        ChooserButton *button = [[ChooserButton alloc] initWithBadgerImage:[UIImage imageWithContentsOfFile:imagePath]];
        [badgerButtons addObject:button];
        [button release];
    }
    
    [self layoutBadgerButtons:badgerButtons];
    [badgerButtons release];
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
