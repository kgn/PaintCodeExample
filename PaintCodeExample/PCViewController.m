//
//  PCViewController.m
//  PaintCodeExample
//
//  Created by David Keegan on 3/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "PCViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation PCViewController{
    CGRect _popupBaseRect;
}

@synthesize debutsButton;
@synthesize popupContainerView;

- (IBAction)showPopup:(id)sender{
    NSTimeInterval time = 0.25;
    [UIView 
     animateWithDuration:time
     delay:0.0
     options:UIViewAnimationOptionCurveEaseInOut
     animations:^{
         self.popupContainerView.alpha = 1.0;
         CGRect newRect = _popupBaseRect;
         newRect.origin.y -= 10;
         self.popupContainerView.frame = newRect;
     }
     completion:^(BOOL finished){
         [UIView 
          animateWithDuration:time
          delay:2.0
          options:UIViewAnimationOptionCurveEaseInOut
          animations:^{
              self.popupContainerView.alpha = 0.0;
              self.popupContainerView.frame = _popupBaseRect;
          }
          completion:nil];            
     }];    
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.popupContainerView.alpha = 0.0f;
    _popupBaseRect = self.popupContainerView.frame;
    self.popupContainerView.layer.contents = (id)[[self popupImage] CGImage];
    
    [self.debutsButton setImage:[self debutsImage] forState:UIControlStateNormal];
    [self.debutsButton setImage:[self debutsHighlightedImage] forState:UIControlStateHighlighted];    
}

- (void)viewDidUnload {
    [self setPopupContainerView:nil];
    [super viewDidUnload];
}

@end
