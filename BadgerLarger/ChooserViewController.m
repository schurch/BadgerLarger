//
//  ChooserViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChooserViewController.h"
#import "ChooserButton.h"
#include <math.h>


@implementation ChooserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Badgers";
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(close:)];
        self.navigationItem.rightBarButtonItem = doneButton;
        [doneButton release];
    
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
    
    float x = 12.5;
    float y = 12.5;
    
    for (ChooserButton *badgerButton in badgerButtons) {
        [badgerButton setFrame:CGRectMake(x, y, 90, 90)];
        [badgerButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:badgerButton];
        
        x+= 102.5;
        
        if((fmod(x, 320)) == 0.0) {
            x = 12.5;
            y += 102.5;
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
