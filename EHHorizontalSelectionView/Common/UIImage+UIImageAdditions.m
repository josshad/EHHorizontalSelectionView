//
//  UIImage+UIImageAdditions.h
//  Ezzi
//
//  Created by Danila Gusev on 30.07.13.
//
//
#import "UIImage+UIImageAdditions.h"
#import "CCARadialGradientLayer.h"

@implementation UIImage (UIImageAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color
{
    return [self imageWithColor:color andSize:CGSizeMake(1.0f, 1.0f)];
}

+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius fillColor:(UIColor *)fillColor
{
    return [self imageOutlineWithCornerRadius:cornerRadius strokeColor:nil fillColor:fillColor];
}

+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor
{
    return [self imageOutlineWithCornerRadius:cornerRadius strokeColor:strokeColor fillColor:nil];
}


+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor insetPonint:(CGPoint)insetPoint drawingRect:(CGRect)drawingRect
{
    UIGraphicsBeginImageContextWithOptions(drawingRect.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(drawingRect, insetPoint.x, insetPoint.y) cornerRadius:cornerRadius];
    if (strokeColor) {
        [strokeColor setStroke];
        [aPath stroke];
    }
    if (fillColor) {
        [fillColor setFill];
        [aPath fill];
    }
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}
+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor rect:(CGRect)drawingRect
{
    UIGraphicsBeginImageContextWithOptions(drawingRect.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(drawingRect, 1.0f, 1.0f) cornerRadius:cornerRadius];
    if (strokeColor) {
        [strokeColor setStroke];
        [aPath stroke];
    }
    if (fillColor) {
        [fillColor setFill];
        [aPath fill];
    }
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}

+ (UIImage *)imageOutlineWithCornerRadius:(CGFloat)cornerRadius strokeColor:(UIColor *)strokeColor fillColor:(UIColor *)fillColor
{
    CGRect drawingRect = CGRectMake(0, 0, 2 * cornerRadius + 3.0f, 2 * cornerRadius + 3.0f);
    UIGraphicsBeginImageContextWithOptions(drawingRect.size, NO, [UIScreen mainScreen].scale);
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(drawingRect, 1.0f, 1.0f) cornerRadius:cornerRadius];
    aPath.lineWidth = 0.5;
    if (strokeColor) {
        [strokeColor setStroke];
        [aPath stroke];
    }
    if (fillColor) {
        [fillColor setFill];
        [aPath fill];
    }
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}

- (UIImage *)imageByApplyingAlpha:(CGFloat) alpha {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, self.size.width, self.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, self.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[ (__bridge id)startColor.CGColor,   // start color
                      (__bridge id)endColor.CGColor ]; // end color
    
    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blur setDefaults];
    layer.backgroundFilters = [NSArray arrayWithObject:blur];
    UIGraphicsBeginImageContext(size);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}

+ (UIImage *)roundImageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor size:(CGSize)size
{

    CCARadialGradientLayer *layer = [CCARadialGradientLayer layer];
    layer.frame = CGRectMake(0, 0, size.width, size.height);
    layer.colors = @[ (__bridge id)startColor.CGColor,
                      (__bridge id)startColor.CGColor,// start color
                      (__bridge id)endColor.CGColor ]; // end color
    layer.locations = @[@0,@0.4,@1];
    layer.gradientOrigin = CGPointMake(size.width/2.0, size.height/2.0);
    layer.gradientRadius = size.width/2.0;
//    CIFilter *blur = [CIFilter filterWithName:@"CIGaussianBlur"];
//    [blur setDefaults];
//    layer.backgroundFilters = [NSArray arrayWithObject:blur];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context)
        [layer renderInContext:context];
    UIImage *res = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return res;
}

+ (CGImageRef)resizeCGImage:(CGImageRef)image toWidth:(int)width andHeight:(int)height {
    // create context, keeping original image properties
    CGColorSpaceRef colorspace = CGImageGetColorSpace(image);
    CGContextRef context = CGBitmapContextCreate(NULL, width, height,
                                                 CGImageGetBitsPerComponent(image),
                                                 CGImageGetBytesPerRow(image),
                                                 colorspace,
                                                 CGImageGetAlphaInfo(image));
    CGColorSpaceRelease(colorspace);
    
    
    if(context == NULL)
        return nil;
    
    
    // draw image to context (resizing it)
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), image);
    // extract resulting image from context
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    
    return imgRef;
}

@end
