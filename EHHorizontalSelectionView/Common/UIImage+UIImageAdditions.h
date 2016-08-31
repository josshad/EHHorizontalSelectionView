//
//  UIImage+UIImageAdditions.h
//  Ezzi
//
//  Created by Danila Gusev on 30.07.13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;
+ (UIImage *)roundImageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size;

+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor;
+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor;
+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor;
+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor rect:(CGRect)drawingRect;
+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor insetPonint:(CGPoint)insetPoint drawingRect:(CGRect)drawingRect;
- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha;

+ (CGImageRef)resizeCGImage:(CGImageRef)image toWidth:(int)width andHeight:(int)height;
@end
