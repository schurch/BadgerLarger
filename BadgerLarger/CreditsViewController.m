//
//  CreditsViewController.m
//  BadgerLarger
//
//  Created by Stefan Church on 08/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "CreditsViewController.h"
#import "UIColor+CustomColors.h"


@implementation CreditsViewController

@synthesize navigationBar = _navigationBar;

- (id)delegate 
{
    return delegate;
}

- (void)setDelegate:(id)newDelegate 
{
    delegate = newDelegate;
}

- (IBAction)done:(id)sender 
{
    if([[self delegate] respondsToSelector:@selector(creditsViewController:)]) {
        [[self delegate] creditsViewController:self];
    }
}

- (void)dealloc
{
    [_navigationBar release];
    
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
