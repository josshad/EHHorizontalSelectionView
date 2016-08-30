//
//  CustomLineCellCode.m
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import "CustomLineCellCode.h"
#import "UIColor+UIColorAdditions.h"

@implementation CustomLineCellCode

+ (UIColor *)defaultColor
{
    return [UIColor colorWithHex:0xffb647];
}


+ (UIFont *)currentFont
{
    return [UIFont fontWithName:@"Helvetica-Light" size:18.0];
}

+ (UIFont *)currentFontMedium
{
    return [UIFont fontWithName:@"Helvetica-Bold" size:18.0];
}

+ (float)currentGap
{
    return 40;
}


@end
