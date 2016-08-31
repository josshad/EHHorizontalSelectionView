//
//  UIColor+UIColorAdditions.m
//  jReader
//
//  Created by Danila Gusev on 03/12/15.
//  Copyright © 2015 Danila Gusev. All rights reserved.
//

#import "UIColor+UIColorAdditions.h"

@implementation UIColor (UIColorAdditions)

- (NSInteger)getHexColor
{
    CGFloat rComponent;
    CGFloat bComponent;
    CGFloat gComponent;
    
    [self getRed:&rComponent green:&gComponent blue:&bComponent alpha:nil];
    
    
    return lroundf(rComponent * 255) * 256 * 256 + lroundf(gComponent * 255) * 256  + lroundf(bComponent * 255);
    
}

+ (UIColor *)colorWithHex:(NSInteger)intColor
{
    CGFloat bComponent = intColor & 0xFF;
    CGFloat gComponent = intColor >> 8 & 0xFF;
    CGFloat rComponent = intColor >> 16 & 0xFF;
    
    return [UIColor colorWithRed:rComponent/255.0 green:gComponent/255.0 blue:bComponent/255.0 alpha:1];
}
@end
