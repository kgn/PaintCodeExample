//
//  PCViewController.h
//  PaintCodeExample
//
//  Created by David Keegan on 3/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *debutsButton;
@property (weak, nonatomic) IBOutlet UIView *popupContainerView;

- (IBAction)showPopup:(id)sender;

@end


@interface PCViewController(PaintCode)
- (UIImage *)popupImage;
- (UIImage *)debutsImage;
- (UIImage *)debutsHighlightedImage;
@end
