//
//  EHHorizontalViewCell.m
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import "EHHorizontalViewCell.h"

@implementation EHHorizontalViewCell

- (void)awakeFromNib {
    [self createSelectedView];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UILabel * l = [[UILabel alloc] init];
        [self addSubview:l];
        self.titleLabel = l;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        
        UIView * sView = [[UIView alloc] init];
        [self addSubview:sView];
        self.selectedView = sView;
        self.selectedView.backgroundColor = [UIColor clearColor];
        
        UIView * colView = [[UIView alloc] init];
        [self.selectedView addSubview:colView];
        self.coloredView = colView;
        self.coloredView.backgroundColor = [[self class] defaultColor];
        
        [self createSelectedView];
        
        [self insertSubview:self.selectedView belowSubview:self.titleLabel];
    }
    return self;
}

+ (UIColor *)defaultColor
{
    return [UIColor colorWithRed:0 green:122/255.0 blue:1 alpha:1];
}

+ (NSString * _Nonnull)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (BOOL)useDynamicSize
{
    return YES;
}

+ (UIFont *)currentFont
{
    return [UIFont fontWithName:@"HelveticaNeue" size:18.0];
}

+ (UIFont *)currentFontMedium
{
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0];
}

+ (float)currentGap
{
    return _EHDefaultGap * 4;
}

+ (BOOL)needCentred
{
    return YES;
}

- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect
{
    if (selected)
    {
        self.selectedView.hidden = NO;
        
        [UIView animateWithDuration:!CGRectIsNull(rect) ? 0.3 : 0.0 animations:^{
            self.titleLabel.font = [[self class] currentFontMedium];
            self.titleLabel.alpha = 1.0;
        }];
        
    }
    else
    {
        self.selectedView.hidden = YES;
        [UIView animateWithDuration:!CGRectIsNull(rect) ? 0.3 : 0.0 animations:^{
            self.titleLabel.font = [[self class] currentFont];
            self.titleLabel.alpha = .5;
        }];
        
    }
}

- (void)createSelectedView
{
    
}

- (void)highlight:(BOOL)highlighted
{
    self.titleLabel.alpha = highlighted ? 0.3 : 0.5;
}

- (void)setTitleLabelText:(NSString *)text
{
    self.titleLabel.text = text;
}

- (void)setSelectedCell:(BOOL)selected
{
    [self setSelectedCell:selected fromCellRect:CGRectNull];
}

@end
