//
//  PCViewController+PaintCode.m
//  PaintCodeExample
//
//  Created by David Keegan on 3/21/12.
//  Copyright (c) 2012 David Keegan. All rights reserved.
//

#import "PCViewController.h"
#import "UIImage+BBlock.h"

@implementation PCViewController (PaintCode)

- (UIImage *)popupImage{
    return [UIImage imageForSize:CGSizeMake(120, 60) withDrawingBlock:^{
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Gradient Declarations
        NSArray* highlightColors = [NSArray arrayWithObjects: 
                                    (id)[UIColor blackColor].CGColor, 
                                    (id)[UIColor colorWithRed: 0.17 green: 0.17 blue: 0.17 alpha: 1].CGColor, 
                                    (id)[UIColor darkGrayColor].CGColor, nil];
        CGFloat highlightLocations[] = {0.5, 0.79, 1};
        CGGradientRef highlight = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)highlightColors, highlightLocations);
        
        //// Shadow Declarations
        CGColorRef outer = [UIColor blackColor].CGColor;
        CGSize outerOffset = CGSizeMake(0, 1);
        CGFloat outerBlurRadius = 3;
        CGColorRef inner = [UIColor whiteColor].CGColor;
        CGSize innerOffset = CGSizeMake(0, -0);
        CGFloat innerBlurRadius = 2;
        
        
        //// popup Drawing
        UIBezierPath* popupPath = [UIBezierPath bezierPath];
        [popupPath moveToPoint: CGPointMake(53.53, 44.52)];
        [popupPath addLineToPoint: CGPointMake(20.5, 44.5)];
        [popupPath addCurveToPoint: CGPointMake(16.5, 40.5) controlPoint1: CGPointMake(18.29, 44.5) controlPoint2: CGPointMake(16.5, 42.71)];
        [popupPath addLineToPoint: CGPointMake(16.5, 14.5)];
        [popupPath addCurveToPoint: CGPointMake(20.5, 10.5) controlPoint1: CGPointMake(16.5, 12.29) controlPoint2: CGPointMake(18.29, 10.5)];
        [popupPath addLineToPoint: CGPointMake(98.5, 10.5)];
        [popupPath addCurveToPoint: CGPointMake(102.5, 14.5) controlPoint1: CGPointMake(100.71, 10.5) controlPoint2: CGPointMake(102.5, 12.29)];
        [popupPath addLineToPoint: CGPointMake(102.5, 40.5)];
        [popupPath addCurveToPoint: CGPointMake(98.5, 44.5) controlPoint1: CGPointMake(102.5, 42.71) controlPoint2: CGPointMake(100.71, 44.5)];
        [popupPath addLineToPoint: CGPointMake(64.55, 44.5)];
        [popupPath addLineToPoint: CGPointMake(59, 48.5)];
        [popupPath addLineToPoint: CGPointMake(53.53, 44.52)];
        [popupPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerOffset, outerBlurRadius, outer);
        CGContextSetFillColorWithColor(context, outer);
        [popupPath fill];
        [popupPath addClip];
        CGContextDrawLinearGradient(context, highlight, CGPointMake(59.5, 48.5), CGPointMake(59.5, 10.5), 0);
        
        ////// popup Inner Shadow
        CGRect popupBorderRect = CGRectInset([popupPath bounds], -innerBlurRadius, -innerBlurRadius);
        popupBorderRect = CGRectOffset(popupBorderRect, -innerOffset.width, -innerOffset.height);
        popupBorderRect = CGRectInset(CGRectUnion(popupBorderRect, [popupPath bounds]), -1, -1);
        
        UIBezierPath* popupNegativePath = [UIBezierPath bezierPathWithRect: popupBorderRect];
        [popupNegativePath appendPath: popupPath];
        popupNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerOffset.width + round(popupBorderRect.size.width);
            CGFloat yOffset = innerOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerBlurRadius,
                                        inner);
            
            [popupPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(popupBorderRect.size.width), 0);
            [popupNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [popupNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        [[UIColor blackColor] setStroke];
        popupPath.lineWidth = 1;
        [popupPath stroke];
        
        //// Cleanup
        CGGradientRelease(highlight);
        CGColorSpaceRelease(colorSpace);    
    }];
}

- (UIImage *)debutsImage{
    return [UIImage imageForSize:CGSizeMake(42, 42) withDrawingBlock:^{
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* dropShadow = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.36];
        UIColor* gradientTop = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.91 alpha: 1];
        UIColor* gradientBottom = [UIColor colorWithRed: 0.76 green: 0.76 blue: 0.76 alpha: 1];
        
        //// Gradient Declarations
        NSArray* mainGradientColors = [NSArray arrayWithObjects: 
                                       (id)gradientTop.CGColor, 
                                       (id)gradientBottom.CGColor, nil];
        CGFloat mainGradientLocations[] = {0, 1};
        CGGradientRef mainGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)mainGradientColors, mainGradientLocations);
        
        //// Shadow Declarations
        CGColorRef outerShadow = dropShadow.CGColor;
        CGSize outerShadowOffset = CGSizeMake(0, 1);
        CGFloat outerShadowBlurRadius = 0;
        CGColorRef innerShadow = [UIColor whiteColor].CGColor;
        CGSize innerShadowOffset = CGSizeMake(0, 1);
        CGFloat innerShadowBlurRadius = 0;
        
        
        //// Inner Drawing
        UIBezierPath* innerPath = [UIBezierPath bezierPath];
        [innerPath moveToPoint: CGPointMake(22, 18)];
        [innerPath addLineToPoint: CGPointMake(20, 18)];
        [innerPath addLineToPoint: CGPointMake(20, 19)];
        [innerPath addLineToPoint: CGPointMake(19, 19)];
        [innerPath addLineToPoint: CGPointMake(19, 20)];
        [innerPath addLineToPoint: CGPointMake(20, 20)];
        [innerPath addLineToPoint: CGPointMake(20, 23)];
        [innerPath addLineToPoint: CGPointMake(19, 23)];
        [innerPath addLineToPoint: CGPointMake(19, 24)];
        [innerPath addLineToPoint: CGPointMake(23, 24)];
        [innerPath addLineToPoint: CGPointMake(23, 23)];
        [innerPath addLineToPoint: CGPointMake(22, 23)];
        [innerPath addLineToPoint: CGPointMake(22, 18)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(30, 17)];
        [innerPath addLineToPoint: CGPointMake(29, 17)];
        [innerPath addLineToPoint: CGPointMake(29, 25)];
        [innerPath addLineToPoint: CGPointMake(30, 25)];
        [innerPath addLineToPoint: CGPointMake(30, 17)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(13, 17)];
        [innerPath addLineToPoint: CGPointMake(12, 17)];
        [innerPath addLineToPoint: CGPointMake(12, 25)];
        [innerPath addLineToPoint: CGPointMake(13, 25)];
        [innerPath addLineToPoint: CGPointMake(13, 17)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(24.54, 17.46)];
        [innerPath addCurveToPoint: CGPointMake(24.54, 24.54) controlPoint1: CGPointMake(26.49, 19.42) controlPoint2: CGPointMake(26.49, 22.58)];
        [innerPath addCurveToPoint: CGPointMake(17.46, 24.54) controlPoint1: CGPointMake(22.58, 26.49) controlPoint2: CGPointMake(19.42, 26.49)];
        [innerPath addCurveToPoint: CGPointMake(17.46, 17.46) controlPoint1: CGPointMake(15.51, 22.58) controlPoint2: CGPointMake(15.51, 19.42)];
        [innerPath addCurveToPoint: CGPointMake(24.54, 17.46) controlPoint1: CGPointMake(19.42, 15.51) controlPoint2: CGPointMake(22.58, 15.51)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(16.76, 16.76)];
        [innerPath addCurveToPoint: CGPointMake(16.76, 25.24) controlPoint1: CGPointMake(14.41, 19.1) controlPoint2: CGPointMake(14.41, 22.9)];
        [innerPath addCurveToPoint: CGPointMake(25.24, 25.24) controlPoint1: CGPointMake(19.1, 27.59) controlPoint2: CGPointMake(22.9, 27.59)];
        [innerPath addCurveToPoint: CGPointMake(25.24, 16.76) controlPoint1: CGPointMake(27.59, 22.9) controlPoint2: CGPointMake(27.59, 19.1)];
        [innerPath addCurveToPoint: CGPointMake(16.76, 16.76) controlPoint1: CGPointMake(22.9, 14.41) controlPoint2: CGPointMake(19.1, 14.41)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(30, 15.97)];
        [innerPath addCurveToPoint: CGPointMake(32, 16.96) controlPoint1: CGPointMake(30.56, 16.53) controlPoint2: CGPointMake(31.28, 16.86)];
        [innerPath addLineToPoint: CGPointMake(32, 25.04)];
        [innerPath addCurveToPoint: CGPointMake(30.03, 26.03) controlPoint1: CGPointMake(31.28, 25.14) controlPoint2: CGPointMake(30.58, 25.47)];
        [innerPath addCurveToPoint: CGPointMake(29.04, 28) controlPoint1: CGPointMake(29.47, 26.58) controlPoint2: CGPointMake(29.14, 27.28)];
        [innerPath addLineToPoint: CGPointMake(12.96, 28)];
        [innerPath addCurveToPoint: CGPointMake(11.97, 26.03) controlPoint1: CGPointMake(12.86, 27.28) controlPoint2: CGPointMake(12.53, 26.58)];
        [innerPath addCurveToPoint: CGPointMake(10, 25.04) controlPoint1: CGPointMake(11.42, 25.47) controlPoint2: CGPointMake(10.72, 25.14)];
        [innerPath addLineToPoint: CGPointMake(10, 16.96)];
        [innerPath addCurveToPoint: CGPointMake(11.97, 15.97) controlPoint1: CGPointMake(10.72, 16.86) controlPoint2: CGPointMake(11.42, 16.53)];
        [innerPath addCurveToPoint: CGPointMake(13, 14) controlPoint1: CGPointMake(12.53, 15.42) controlPoint2: CGPointMake(12.9, 14.72)];
        [innerPath addLineToPoint: CGPointMake(29.04, 14)];
        [innerPath addCurveToPoint: CGPointMake(30, 15.97) controlPoint1: CGPointMake(29.04, 14) controlPoint2: CGPointMake(29.44, 15.42)];
        [innerPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerShadowOffset, outerShadowBlurRadius, outerShadow);
        CGContextSetFillColorWithColor(context, outerShadow);
        [innerPath fill];
        [innerPath addClip];
        CGContextDrawLinearGradient(context, mainGradient, CGPointMake(21, 14), CGPointMake(21, 28), 0);
        
        ////// Inner Inner Shadow
        CGRect innerBorderRect = CGRectInset([innerPath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
        innerBorderRect = CGRectOffset(innerBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
        innerBorderRect = CGRectInset(CGRectUnion(innerBorderRect, [innerPath bounds]), -1, -1);
        
        UIBezierPath* innerNegativePath = [UIBezierPath bezierPathWithRect: innerBorderRect];
        [innerNegativePath appendPath: innerPath];
        innerNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerShadowOffset.width + round(innerBorderRect.size.width);
            CGFloat yOffset = innerShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerShadowBlurRadius,
                                        innerShadow);
            
            [innerPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(innerBorderRect.size.width), 0);
            [innerNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [innerNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// Outer Drawing
        UIBezierPath* outerPath = [UIBezierPath bezierPath];
        [outerPath moveToPoint: CGPointMake(30.04, 13)];
        [outerPath addLineToPoint: CGPointMake(11.96, 13)];
        [outerPath addCurveToPoint: CGPointMake(10.97, 14.97) controlPoint1: CGPointMake(11.86, 13.72) controlPoint2: CGPointMake(11.53, 14.42)];
        [outerPath addCurveToPoint: CGPointMake(9, 15.96) controlPoint1: CGPointMake(10.42, 15.53) controlPoint2: CGPointMake(9.72, 15.86)];
        [outerPath addLineToPoint: CGPointMake(9, 26)];
        [outerPath addCurveToPoint: CGPointMake(11, 27) controlPoint1: CGPointMake(9.4, 26.06) controlPoint2: CGPointMake(10.29, 26.3)];
        [outerPath addCurveToPoint: CGPointMake(11.96, 29) controlPoint1: CGPointMake(11.56, 27.56) controlPoint2: CGPointMake(12.03, 28.53)];
        [outerPath addLineToPoint: CGPointMake(30.04, 29)];
        [outerPath addCurveToPoint: CGPointMake(31, 27) controlPoint1: CGPointMake(29.96, 28.47) controlPoint2: CGPointMake(30.33, 27.6)];
        [outerPath addCurveToPoint: CGPointMake(33, 26.04) controlPoint1: CGPointMake(31.67, 26.4) controlPoint2: CGPointMake(32.64, 26.09)];
        [outerPath addLineToPoint: CGPointMake(33, 15.96)];
        [outerPath addCurveToPoint: CGPointMake(31.03, 14.97) controlPoint1: CGPointMake(32.28, 15.86) controlPoint2: CGPointMake(31.58, 15.53)];
        [outerPath addCurveToPoint: CGPointMake(30.04, 13) controlPoint1: CGPointMake(30.47, 14.42) controlPoint2: CGPointMake(30.04, 13)];
        [outerPath closePath];
        [outerPath moveToPoint: CGPointMake(31.88, 14.12)];
        [outerPath addCurveToPoint: CGPointMake(34, 15) controlPoint1: CGPointMake(32.46, 14.71) controlPoint2: CGPointMake(33.23, 15)];
        [outerPath addLineToPoint: CGPointMake(34, 16)];
        [outerPath addLineToPoint: CGPointMake(35, 16)];
        [outerPath addLineToPoint: CGPointMake(35, 17)];
        [outerPath addLineToPoint: CGPointMake(34, 17)];
        [outerPath addLineToPoint: CGPointMake(34, 18)];
        [outerPath addLineToPoint: CGPointMake(35, 18)];
        [outerPath addLineToPoint: CGPointMake(35, 19)];
        [outerPath addLineToPoint: CGPointMake(34, 19)];
        [outerPath addLineToPoint: CGPointMake(34, 20)];
        [outerPath addLineToPoint: CGPointMake(35, 20)];
        [outerPath addLineToPoint: CGPointMake(35, 21)];
        [outerPath addLineToPoint: CGPointMake(34, 21)];
        [outerPath addLineToPoint: CGPointMake(34, 22)];
        [outerPath addLineToPoint: CGPointMake(35, 22)];
        [outerPath addLineToPoint: CGPointMake(35, 23)];
        [outerPath addLineToPoint: CGPointMake(34, 23)];
        [outerPath addLineToPoint: CGPointMake(34, 24)];
        [outerPath addLineToPoint: CGPointMake(35, 24)];
        [outerPath addLineToPoint: CGPointMake(35, 25)];
        [outerPath addLineToPoint: CGPointMake(34, 25)];
        [outerPath addLineToPoint: CGPointMake(34, 27)];
        [outerPath addCurveToPoint: CGPointMake(32, 28) controlPoint1: CGPointMake(33.65, 27) controlPoint2: CGPointMake(32.6, 27.33)];
        [outerPath addCurveToPoint: CGPointMake(31, 30) controlPoint1: CGPointMake(31.26, 28.82) controlPoint2: CGPointMake(31, 30)];
        [outerPath addLineToPoint: CGPointMake(10.83, 30)];
        [outerPath addCurveToPoint: CGPointMake(10, 28) controlPoint1: CGPointMake(10.9, 29.23) controlPoint2: CGPointMake(10.52, 28.51)];
        [outerPath addCurveToPoint: CGPointMake(8, 27) controlPoint1: CGPointMake(9.33, 27.35) controlPoint2: CGPointMake(8.43, 27)];
        [outerPath addLineToPoint: CGPointMake(8, 25)];
        [outerPath addLineToPoint: CGPointMake(7, 25)];
        [outerPath addLineToPoint: CGPointMake(7, 24)];
        [outerPath addLineToPoint: CGPointMake(8, 24)];
        [outerPath addLineToPoint: CGPointMake(8, 23)];
        [outerPath addLineToPoint: CGPointMake(7, 23)];
        [outerPath addLineToPoint: CGPointMake(7, 22)];
        [outerPath addLineToPoint: CGPointMake(8, 22)];
        [outerPath addLineToPoint: CGPointMake(8, 21)];
        [outerPath addLineToPoint: CGPointMake(7, 21)];
        [outerPath addLineToPoint: CGPointMake(7, 20)];
        [outerPath addLineToPoint: CGPointMake(8, 20)];
        [outerPath addLineToPoint: CGPointMake(8, 19)];
        [outerPath addLineToPoint: CGPointMake(7, 19)];
        [outerPath addLineToPoint: CGPointMake(7, 18)];
        [outerPath addLineToPoint: CGPointMake(8, 18)];
        [outerPath addLineToPoint: CGPointMake(8, 17)];
        [outerPath addLineToPoint: CGPointMake(7, 17)];
        [outerPath addLineToPoint: CGPointMake(7, 16)];
        [outerPath addLineToPoint: CGPointMake(8, 16)];
        [outerPath addLineToPoint: CGPointMake(8, 15)];
        [outerPath addCurveToPoint: CGPointMake(10.12, 14.12) controlPoint1: CGPointMake(8.77, 15) controlPoint2: CGPointMake(9.54, 14.71)];
        [outerPath addCurveToPoint: CGPointMake(11, 12) controlPoint1: CGPointMake(10.71, 13.54) controlPoint2: CGPointMake(11, 12.77)];
        [outerPath addLineToPoint: CGPointMake(31, 12)];
        [outerPath addCurveToPoint: CGPointMake(31.88, 14.12) controlPoint1: CGPointMake(31, 12) controlPoint2: CGPointMake(31.29, 13.54)];
        [outerPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerShadowOffset, outerShadowBlurRadius, outerShadow);
        CGContextSetFillColorWithColor(context, outerShadow);
        [outerPath fill];
        [outerPath addClip];
        CGContextDrawLinearGradient(context, mainGradient, CGPointMake(21, 12), CGPointMake(21, 30), 0);
        
        ////// Outer Inner Shadow
        CGRect outerBorderRect = CGRectInset([outerPath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
        outerBorderRect = CGRectOffset(outerBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
        outerBorderRect = CGRectInset(CGRectUnion(outerBorderRect, [outerPath bounds]), -1, -1);
        
        UIBezierPath* outerNegativePath = [UIBezierPath bezierPathWithRect: outerBorderRect];
        [outerNegativePath appendPath: outerPath];
        outerNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerShadowOffset.width + round(outerBorderRect.size.width);
            CGFloat yOffset = innerShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerShadowBlurRadius,
                                        innerShadow);
            
            [outerPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(outerBorderRect.size.width), 0);
            [outerNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [outerNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        //// Cleanup
        CGGradientRelease(mainGradient);
        CGColorSpaceRelease(colorSpace);
    }];
}

- (UIImage *)debutsHighlightedImage{
    return [UIImage imageForSize:CGSizeMake(42, 42) withDrawingBlock:^{
        //// General Declarations
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        //// Color Declarations
        UIColor* dropShadow = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.36];
        UIColor* gradientTop = [UIColor colorWithRed: 0.91 green: 0.91 blue: 0.91 alpha: 1];
        UIColor* gradientBottom = [UIColor colorWithRed: 0.76 green: 0.76 blue: 0.76 alpha: 1];
        UIColor* pink = [UIColor colorWithRed: 0.9 green: 0.18 blue: 0.46 alpha: 0.75];
        
        //// Gradient Declarations
        NSArray* mainGradientColors = [NSArray arrayWithObjects: 
                                       (id)gradientTop.CGColor, 
                                       (id)gradientBottom.CGColor, nil];
        CGFloat mainGradientLocations[] = {0, 1};
        CGGradientRef mainGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)mainGradientColors, mainGradientLocations);
        
        //// Shadow Declarations
        CGColorRef outerShadow = dropShadow.CGColor;
        CGSize outerShadowOffset = CGSizeMake(0, 1);
        CGFloat outerShadowBlurRadius = 0;
        CGColorRef innerShadow = [UIColor whiteColor].CGColor;
        CGSize innerShadowOffset = CGSizeMake(0, 1);
        CGFloat innerShadowBlurRadius = 0;
        CGColorRef pinkGlow = pink.CGColor;
        CGSize pinkGlowOffset = CGSizeMake(0, -0);
        CGFloat pinkGlowBlurRadius = 3;
        
        
        //// Inner(Glow) Drawing
        UIBezierPath* innerGlowPath = [UIBezierPath bezierPath];
        [innerGlowPath moveToPoint: CGPointMake(22, 18)];
        [innerGlowPath addLineToPoint: CGPointMake(20, 18)];
        [innerGlowPath addLineToPoint: CGPointMake(20, 19)];
        [innerGlowPath addLineToPoint: CGPointMake(19, 19)];
        [innerGlowPath addLineToPoint: CGPointMake(19, 20)];
        [innerGlowPath addLineToPoint: CGPointMake(20, 20)];
        [innerGlowPath addLineToPoint: CGPointMake(20, 23)];
        [innerGlowPath addLineToPoint: CGPointMake(19, 23)];
        [innerGlowPath addLineToPoint: CGPointMake(19, 24)];
        [innerGlowPath addLineToPoint: CGPointMake(23, 24)];
        [innerGlowPath addLineToPoint: CGPointMake(23, 23)];
        [innerGlowPath addLineToPoint: CGPointMake(22, 23)];
        [innerGlowPath addLineToPoint: CGPointMake(22, 18)];
        [innerGlowPath closePath];
        [innerGlowPath moveToPoint: CGPointMake(30, 17)];
        [innerGlowPath addLineToPoint: CGPointMake(29, 17)];
        [innerGlowPath addLineToPoint: CGPointMake(29, 25)];
        [innerGlowPath addLineToPoint: CGPointMake(30, 25)];
        [innerGlowPath addLineToPoint: CGPointMake(30, 17)];
        [innerGlowPath closePath];
        [innerGlowPath moveToPoint: CGPointMake(13, 17)];
        [innerGlowPath addLineToPoint: CGPointMake(12, 17)];
        [innerGlowPath addLineToPoint: CGPointMake(12, 25)];
        [innerGlowPath addLineToPoint: CGPointMake(13, 25)];
        [innerGlowPath addLineToPoint: CGPointMake(13, 17)];
        [innerGlowPath closePath];
        [innerGlowPath moveToPoint: CGPointMake(24.54, 17.46)];
        [innerGlowPath addCurveToPoint: CGPointMake(24.54, 24.54) controlPoint1: CGPointMake(26.49, 19.42) controlPoint2: CGPointMake(26.49, 22.58)];
        [innerGlowPath addCurveToPoint: CGPointMake(17.46, 24.54) controlPoint1: CGPointMake(22.58, 26.49) controlPoint2: CGPointMake(19.42, 26.49)];
        [innerGlowPath addCurveToPoint: CGPointMake(17.46, 17.46) controlPoint1: CGPointMake(15.51, 22.58) controlPoint2: CGPointMake(15.51, 19.42)];
        [innerGlowPath addCurveToPoint: CGPointMake(24.54, 17.46) controlPoint1: CGPointMake(19.42, 15.51) controlPoint2: CGPointMake(22.58, 15.51)];
        [innerGlowPath closePath];
        [innerGlowPath moveToPoint: CGPointMake(16.76, 16.76)];
        [innerGlowPath addCurveToPoint: CGPointMake(16.76, 25.24) controlPoint1: CGPointMake(14.41, 19.1) controlPoint2: CGPointMake(14.41, 22.9)];
        [innerGlowPath addCurveToPoint: CGPointMake(25.24, 25.24) controlPoint1: CGPointMake(19.1, 27.59) controlPoint2: CGPointMake(22.9, 27.59)];
        [innerGlowPath addCurveToPoint: CGPointMake(25.24, 16.76) controlPoint1: CGPointMake(27.59, 22.9) controlPoint2: CGPointMake(27.59, 19.1)];
        [innerGlowPath addCurveToPoint: CGPointMake(16.76, 16.76) controlPoint1: CGPointMake(22.9, 14.41) controlPoint2: CGPointMake(19.1, 14.41)];
        [innerGlowPath closePath];
        [innerGlowPath moveToPoint: CGPointMake(29.06, 14.17)];
        [innerGlowPath addCurveToPoint: CGPointMake(30.03, 15.97) controlPoint1: CGPointMake(29.14, 14.72) controlPoint2: CGPointMake(29.47, 15.42)];
        [innerGlowPath addCurveToPoint: CGPointMake(32, 16.96) controlPoint1: CGPointMake(30.58, 16.53) controlPoint2: CGPointMake(31.28, 16.86)];
        [innerGlowPath addLineToPoint: CGPointMake(32, 25.04)];
        [innerGlowPath addCurveToPoint: CGPointMake(30.03, 26.03) controlPoint1: CGPointMake(31.28, 25.14) controlPoint2: CGPointMake(30.58, 25.47)];
        [innerGlowPath addCurveToPoint: CGPointMake(29.04, 28) controlPoint1: CGPointMake(29.47, 26.58) controlPoint2: CGPointMake(29.14, 27.28)];
        [innerGlowPath addLineToPoint: CGPointMake(12.96, 28)];
        [innerGlowPath addCurveToPoint: CGPointMake(11.97, 26.03) controlPoint1: CGPointMake(12.86, 27.28) controlPoint2: CGPointMake(12.53, 26.58)];
        [innerGlowPath addCurveToPoint: CGPointMake(10, 25.04) controlPoint1: CGPointMake(11.42, 25.47) controlPoint2: CGPointMake(10.72, 25.14)];
        [innerGlowPath addLineToPoint: CGPointMake(10, 16.96)];
        [innerGlowPath addCurveToPoint: CGPointMake(11.97, 15.97) controlPoint1: CGPointMake(10.72, 16.86) controlPoint2: CGPointMake(11.42, 16.53)];
        [innerGlowPath addCurveToPoint: CGPointMake(12.96, 14) controlPoint1: CGPointMake(12.53, 15.42) controlPoint2: CGPointMake(12.86, 14.72)];
        [innerGlowPath addLineToPoint: CGPointMake(29.04, 14)];
        [innerGlowPath addLineToPoint: CGPointMake(29.06, 14.17)];
        [innerGlowPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, pinkGlowOffset, pinkGlowBlurRadius, pinkGlow);
        [[UIColor whiteColor] setFill];
        [innerGlowPath fill];
        CGContextRestoreGState(context);
        
        
        
        //// Outer(Glow) Drawing
        UIBezierPath* outerGlowPath = [UIBezierPath bezierPath];
        [outerGlowPath moveToPoint: CGPointMake(30.04, 13)];
        [outerGlowPath addLineToPoint: CGPointMake(11.96, 13)];
        [outerGlowPath addCurveToPoint: CGPointMake(10.97, 14.97) controlPoint1: CGPointMake(11.86, 13.72) controlPoint2: CGPointMake(11.53, 14.42)];
        [outerGlowPath addCurveToPoint: CGPointMake(9, 15.96) controlPoint1: CGPointMake(10.42, 15.53) controlPoint2: CGPointMake(9.72, 15.86)];
        [outerGlowPath addLineToPoint: CGPointMake(9, 26)];
        [outerGlowPath addCurveToPoint: CGPointMake(11, 27) controlPoint1: CGPointMake(9.4, 26.06) controlPoint2: CGPointMake(10.29, 26.3)];
        [outerGlowPath addCurveToPoint: CGPointMake(11.96, 29) controlPoint1: CGPointMake(11.56, 27.56) controlPoint2: CGPointMake(12.03, 28.53)];
        [outerGlowPath addLineToPoint: CGPointMake(30.04, 29)];
        [outerGlowPath addCurveToPoint: CGPointMake(31, 27) controlPoint1: CGPointMake(29.96, 28.47) controlPoint2: CGPointMake(30.33, 27.6)];
        [outerGlowPath addCurveToPoint: CGPointMake(33, 26.04) controlPoint1: CGPointMake(31.67, 26.4) controlPoint2: CGPointMake(32.64, 26.09)];
        [outerGlowPath addLineToPoint: CGPointMake(33, 15.96)];
        [outerGlowPath addCurveToPoint: CGPointMake(31.03, 14.97) controlPoint1: CGPointMake(32.28, 15.86) controlPoint2: CGPointMake(31.58, 15.53)];
        [outerGlowPath addCurveToPoint: CGPointMake(30.04, 13) controlPoint1: CGPointMake(30.47, 14.42) controlPoint2: CGPointMake(30.04, 13)];
        [outerGlowPath closePath];
        [outerGlowPath moveToPoint: CGPointMake(31.88, 14.12)];
        [outerGlowPath addCurveToPoint: CGPointMake(34, 15) controlPoint1: CGPointMake(32.46, 14.71) controlPoint2: CGPointMake(33.23, 15)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 16)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 16)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 17)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 17)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 18)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 18)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 19)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 19)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 20)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 20)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 21)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 21)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 22)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 22)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 23)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 23)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 24)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 24)];
        [outerGlowPath addLineToPoint: CGPointMake(35, 25)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 25)];
        [outerGlowPath addLineToPoint: CGPointMake(34, 27)];
        [outerGlowPath addCurveToPoint: CGPointMake(32, 28) controlPoint1: CGPointMake(33.65, 27) controlPoint2: CGPointMake(32.6, 27.33)];
        [outerGlowPath addCurveToPoint: CGPointMake(31, 30) controlPoint1: CGPointMake(31.26, 28.82) controlPoint2: CGPointMake(31, 30)];
        [outerGlowPath addLineToPoint: CGPointMake(10.83, 30)];
        [outerGlowPath addCurveToPoint: CGPointMake(10, 28) controlPoint1: CGPointMake(10.9, 29.23) controlPoint2: CGPointMake(10.52, 28.51)];
        [outerGlowPath addCurveToPoint: CGPointMake(8, 27) controlPoint1: CGPointMake(9.33, 27.35) controlPoint2: CGPointMake(8.43, 27)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 25)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 25)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 24)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 24)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 23)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 23)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 22)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 22)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 21)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 21)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 20)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 20)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 19)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 19)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 18)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 18)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 17)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 17)];
        [outerGlowPath addLineToPoint: CGPointMake(7, 16)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 16)];
        [outerGlowPath addLineToPoint: CGPointMake(8, 15)];
        [outerGlowPath addCurveToPoint: CGPointMake(10.12, 14.12) controlPoint1: CGPointMake(8.77, 15) controlPoint2: CGPointMake(9.54, 14.71)];
        [outerGlowPath addCurveToPoint: CGPointMake(11, 12) controlPoint1: CGPointMake(10.71, 13.54) controlPoint2: CGPointMake(11, 12.77)];
        [outerGlowPath addLineToPoint: CGPointMake(31, 12)];
        [outerGlowPath addCurveToPoint: CGPointMake(31.88, 14.12) controlPoint1: CGPointMake(31, 12) controlPoint2: CGPointMake(31.29, 13.54)];
        [outerGlowPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, pinkGlowOffset, pinkGlowBlurRadius, pinkGlow);
        [[UIColor whiteColor] setFill];
        [outerGlowPath fill];
        CGContextRestoreGState(context);
        
        
        
        //// Inner Drawing
        UIBezierPath* innerPath = [UIBezierPath bezierPath];
        [innerPath moveToPoint: CGPointMake(22, 18)];
        [innerPath addLineToPoint: CGPointMake(20, 18)];
        [innerPath addLineToPoint: CGPointMake(20, 19)];
        [innerPath addLineToPoint: CGPointMake(19, 19)];
        [innerPath addLineToPoint: CGPointMake(19, 20)];
        [innerPath addLineToPoint: CGPointMake(20, 20)];
        [innerPath addLineToPoint: CGPointMake(20, 23)];
        [innerPath addLineToPoint: CGPointMake(19, 23)];
        [innerPath addLineToPoint: CGPointMake(19, 24)];
        [innerPath addLineToPoint: CGPointMake(23, 24)];
        [innerPath addLineToPoint: CGPointMake(23, 23)];
        [innerPath addLineToPoint: CGPointMake(22, 23)];
        [innerPath addLineToPoint: CGPointMake(22, 18)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(30, 17)];
        [innerPath addLineToPoint: CGPointMake(29, 17)];
        [innerPath addLineToPoint: CGPointMake(29, 25)];
        [innerPath addLineToPoint: CGPointMake(30, 25)];
        [innerPath addLineToPoint: CGPointMake(30, 17)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(13, 17)];
        [innerPath addLineToPoint: CGPointMake(12, 17)];
        [innerPath addLineToPoint: CGPointMake(12, 25)];
        [innerPath addLineToPoint: CGPointMake(13, 25)];
        [innerPath addLineToPoint: CGPointMake(13, 17)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(24.54, 17.46)];
        [innerPath addCurveToPoint: CGPointMake(24.54, 24.54) controlPoint1: CGPointMake(26.49, 19.42) controlPoint2: CGPointMake(26.49, 22.58)];
        [innerPath addCurveToPoint: CGPointMake(17.46, 24.54) controlPoint1: CGPointMake(22.58, 26.49) controlPoint2: CGPointMake(19.42, 26.49)];
        [innerPath addCurveToPoint: CGPointMake(17.46, 17.46) controlPoint1: CGPointMake(15.51, 22.58) controlPoint2: CGPointMake(15.51, 19.42)];
        [innerPath addCurveToPoint: CGPointMake(24.54, 17.46) controlPoint1: CGPointMake(19.42, 15.51) controlPoint2: CGPointMake(22.58, 15.51)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(16.76, 16.76)];
        [innerPath addCurveToPoint: CGPointMake(16.76, 25.24) controlPoint1: CGPointMake(14.41, 19.1) controlPoint2: CGPointMake(14.41, 22.9)];
        [innerPath addCurveToPoint: CGPointMake(25.24, 25.24) controlPoint1: CGPointMake(19.1, 27.59) controlPoint2: CGPointMake(22.9, 27.59)];
        [innerPath addCurveToPoint: CGPointMake(25.24, 16.76) controlPoint1: CGPointMake(27.59, 22.9) controlPoint2: CGPointMake(27.59, 19.1)];
        [innerPath addCurveToPoint: CGPointMake(16.76, 16.76) controlPoint1: CGPointMake(22.9, 14.41) controlPoint2: CGPointMake(19.1, 14.41)];
        [innerPath closePath];
        [innerPath moveToPoint: CGPointMake(30, 15.97)];
        [innerPath addCurveToPoint: CGPointMake(32, 16.96) controlPoint1: CGPointMake(30.56, 16.53) controlPoint2: CGPointMake(31.28, 16.86)];
        [innerPath addLineToPoint: CGPointMake(32, 25.04)];
        [innerPath addCurveToPoint: CGPointMake(30.03, 26.03) controlPoint1: CGPointMake(31.28, 25.14) controlPoint2: CGPointMake(30.58, 25.47)];
        [innerPath addCurveToPoint: CGPointMake(29.04, 28) controlPoint1: CGPointMake(29.47, 26.58) controlPoint2: CGPointMake(29.14, 27.28)];
        [innerPath addLineToPoint: CGPointMake(12.96, 28)];
        [innerPath addCurveToPoint: CGPointMake(11.97, 26.03) controlPoint1: CGPointMake(12.86, 27.28) controlPoint2: CGPointMake(12.53, 26.58)];
        [innerPath addCurveToPoint: CGPointMake(10, 25.04) controlPoint1: CGPointMake(11.42, 25.47) controlPoint2: CGPointMake(10.72, 25.14)];
        [innerPath addLineToPoint: CGPointMake(10, 16.96)];
        [innerPath addCurveToPoint: CGPointMake(11.97, 15.97) controlPoint1: CGPointMake(10.72, 16.86) controlPoint2: CGPointMake(11.42, 16.53)];
        [innerPath addCurveToPoint: CGPointMake(13, 14) controlPoint1: CGPointMake(12.53, 15.42) controlPoint2: CGPointMake(12.9, 14.72)];
        [innerPath addLineToPoint: CGPointMake(29.04, 14)];
        [innerPath addCurveToPoint: CGPointMake(30, 15.97) controlPoint1: CGPointMake(29.04, 14) controlPoint2: CGPointMake(29.44, 15.42)];
        [innerPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerShadowOffset, outerShadowBlurRadius, outerShadow);
        CGContextSetFillColorWithColor(context, outerShadow);
        [innerPath fill];
        [innerPath addClip];
        CGContextDrawLinearGradient(context, mainGradient, CGPointMake(21, 14), CGPointMake(21, 28), 0);
        
        ////// Inner Inner Shadow
        CGRect innerBorderRect = CGRectInset([innerPath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
        innerBorderRect = CGRectOffset(innerBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
        innerBorderRect = CGRectInset(CGRectUnion(innerBorderRect, [innerPath bounds]), -1, -1);
        
        UIBezierPath* innerNegativePath = [UIBezierPath bezierPathWithRect: innerBorderRect];
        [innerNegativePath appendPath: innerPath];
        innerNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerShadowOffset.width + round(innerBorderRect.size.width);
            CGFloat yOffset = innerShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerShadowBlurRadius,
                                        innerShadow);
            
            [innerPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(innerBorderRect.size.width), 0);
            [innerNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [innerNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        
        //// Outer Drawing
        UIBezierPath* outerPath = [UIBezierPath bezierPath];
        [outerPath moveToPoint: CGPointMake(30.04, 13)];
        [outerPath addLineToPoint: CGPointMake(11.96, 13)];
        [outerPath addCurveToPoint: CGPointMake(10.97, 14.97) controlPoint1: CGPointMake(11.86, 13.72) controlPoint2: CGPointMake(11.53, 14.42)];
        [outerPath addCurveToPoint: CGPointMake(9, 15.96) controlPoint1: CGPointMake(10.42, 15.53) controlPoint2: CGPointMake(9.72, 15.86)];
        [outerPath addLineToPoint: CGPointMake(9, 26)];
        [outerPath addCurveToPoint: CGPointMake(11, 27) controlPoint1: CGPointMake(9.4, 26.06) controlPoint2: CGPointMake(10.29, 26.3)];
        [outerPath addCurveToPoint: CGPointMake(11.96, 29) controlPoint1: CGPointMake(11.56, 27.56) controlPoint2: CGPointMake(12.03, 28.53)];
        [outerPath addLineToPoint: CGPointMake(30.04, 29)];
        [outerPath addCurveToPoint: CGPointMake(31, 27) controlPoint1: CGPointMake(29.96, 28.47) controlPoint2: CGPointMake(30.33, 27.6)];
        [outerPath addCurveToPoint: CGPointMake(33, 26.04) controlPoint1: CGPointMake(31.67, 26.4) controlPoint2: CGPointMake(32.64, 26.09)];
        [outerPath addLineToPoint: CGPointMake(33, 15.96)];
        [outerPath addCurveToPoint: CGPointMake(31.03, 14.97) controlPoint1: CGPointMake(32.28, 15.86) controlPoint2: CGPointMake(31.58, 15.53)];
        [outerPath addCurveToPoint: CGPointMake(30.04, 13) controlPoint1: CGPointMake(30.47, 14.42) controlPoint2: CGPointMake(30.04, 13)];
        [outerPath closePath];
        [outerPath moveToPoint: CGPointMake(31.88, 14.12)];
        [outerPath addCurveToPoint: CGPointMake(34, 15) controlPoint1: CGPointMake(32.46, 14.71) controlPoint2: CGPointMake(33.23, 15)];
        [outerPath addLineToPoint: CGPointMake(34, 16)];
        [outerPath addLineToPoint: CGPointMake(35, 16)];
        [outerPath addLineToPoint: CGPointMake(35, 17)];
        [outerPath addLineToPoint: CGPointMake(34, 17)];
        [outerPath addLineToPoint: CGPointMake(34, 18)];
        [outerPath addLineToPoint: CGPointMake(35, 18)];
        [outerPath addLineToPoint: CGPointMake(35, 19)];
        [outerPath addLineToPoint: CGPointMake(34, 19)];
        [outerPath addLineToPoint: CGPointMake(34, 20)];
        [outerPath addLineToPoint: CGPointMake(35, 20)];
        [outerPath addLineToPoint: CGPointMake(35, 21)];
        [outerPath addLineToPoint: CGPointMake(34, 21)];
        [outerPath addLineToPoint: CGPointMake(34, 22)];
        [outerPath addLineToPoint: CGPointMake(35, 22)];
        [outerPath addLineToPoint: CGPointMake(35, 23)];
        [outerPath addLineToPoint: CGPointMake(34, 23)];
        [outerPath addLineToPoint: CGPointMake(34, 24)];
        [outerPath addLineToPoint: CGPointMake(35, 24)];
        [outerPath addLineToPoint: CGPointMake(35, 25)];
        [outerPath addLineToPoint: CGPointMake(34, 25)];
        [outerPath addLineToPoint: CGPointMake(34, 27)];
        [outerPath addCurveToPoint: CGPointMake(32, 28) controlPoint1: CGPointMake(33.65, 27) controlPoint2: CGPointMake(32.6, 27.33)];
        [outerPath addCurveToPoint: CGPointMake(31, 30) controlPoint1: CGPointMake(31.26, 28.82) controlPoint2: CGPointMake(31, 30)];
        [outerPath addLineToPoint: CGPointMake(10.83, 30)];
        [outerPath addCurveToPoint: CGPointMake(10, 28) controlPoint1: CGPointMake(10.9, 29.23) controlPoint2: CGPointMake(10.52, 28.51)];
        [outerPath addCurveToPoint: CGPointMake(8, 27) controlPoint1: CGPointMake(9.33, 27.35) controlPoint2: CGPointMake(8.43, 27)];
        [outerPath addLineToPoint: CGPointMake(8, 25)];
        [outerPath addLineToPoint: CGPointMake(7, 25)];
        [outerPath addLineToPoint: CGPointMake(7, 24)];
        [outerPath addLineToPoint: CGPointMake(8, 24)];
        [outerPath addLineToPoint: CGPointMake(8, 23)];
        [outerPath addLineToPoint: CGPointMake(7, 23)];
        [outerPath addLineToPoint: CGPointMake(7, 22)];
        [outerPath addLineToPoint: CGPointMake(8, 22)];
        [outerPath addLineToPoint: CGPointMake(8, 21)];
        [outerPath addLineToPoint: CGPointMake(7, 21)];
        [outerPath addLineToPoint: CGPointMake(7, 20)];
        [outerPath addLineToPoint: CGPointMake(8, 20)];
        [outerPath addLineToPoint: CGPointMake(8, 19)];
        [outerPath addLineToPoint: CGPointMake(7, 19)];
        [outerPath addLineToPoint: CGPointMake(7, 18)];
        [outerPath addLineToPoint: CGPointMake(8, 18)];
        [outerPath addLineToPoint: CGPointMake(8, 17)];
        [outerPath addLineToPoint: CGPointMake(7, 17)];
        [outerPath addLineToPoint: CGPointMake(7, 16)];
        [outerPath addLineToPoint: CGPointMake(8, 16)];
        [outerPath addLineToPoint: CGPointMake(8, 15)];
        [outerPath addCurveToPoint: CGPointMake(10.12, 14.12) controlPoint1: CGPointMake(8.77, 15) controlPoint2: CGPointMake(9.54, 14.71)];
        [outerPath addCurveToPoint: CGPointMake(11, 12) controlPoint1: CGPointMake(10.71, 13.54) controlPoint2: CGPointMake(11, 12.77)];
        [outerPath addLineToPoint: CGPointMake(31, 12)];
        [outerPath addCurveToPoint: CGPointMake(31.88, 14.12) controlPoint1: CGPointMake(31, 12) controlPoint2: CGPointMake(31.29, 13.54)];
        [outerPath closePath];
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, outerShadowOffset, outerShadowBlurRadius, outerShadow);
        CGContextSetFillColorWithColor(context, outerShadow);
        [outerPath fill];
        [outerPath addClip];
        CGContextDrawLinearGradient(context, mainGradient, CGPointMake(21, 12), CGPointMake(21, 30), 0);
        
        ////// Outer Inner Shadow
        CGRect outerBorderRect = CGRectInset([outerPath bounds], -innerShadowBlurRadius, -innerShadowBlurRadius);
        outerBorderRect = CGRectOffset(outerBorderRect, -innerShadowOffset.width, -innerShadowOffset.height);
        outerBorderRect = CGRectInset(CGRectUnion(outerBorderRect, [outerPath bounds]), -1, -1);
        
        UIBezierPath* outerNegativePath = [UIBezierPath bezierPathWithRect: outerBorderRect];
        [outerNegativePath appendPath: outerPath];
        outerNegativePath.usesEvenOddFillRule = YES;
        
        CGContextSaveGState(context);
        {
            CGFloat xOffset = innerShadowOffset.width + round(outerBorderRect.size.width);
            CGFloat yOffset = innerShadowOffset.height;
            CGContextSetShadowWithColor(context,
                                        CGSizeMake(xOffset + copysign(0.1, xOffset), yOffset + copysign(0.1, yOffset)),
                                        innerShadowBlurRadius,
                                        innerShadow);
            
            [outerPath addClip];
            CGAffineTransform transform = CGAffineTransformMakeTranslation(-round(outerBorderRect.size.width), 0);
            [outerNegativePath applyTransform: transform];
            [[UIColor grayColor] setFill];
            [outerNegativePath fill];
        }
        CGContextRestoreGState(context);
        
        CGContextRestoreGState(context);
        
        
        //// Cleanup
        CGGradientRelease(mainGradient);
        CGColorSpaceRelease(colorSpace);
    }];    
}

@end
