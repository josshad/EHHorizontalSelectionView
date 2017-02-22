//
//  HorizontalViewCell.m
//  TvRemote
//
//  Created by Danila Gusev on 29/02/2016.
//  Copyright © 2016 com.abrt. All rights reserved.
//

#import "EHHorizontalLineViewCell.h"
#import "EHHorizontalViewCell.h"

@implementation EHHorizontalLineViewCell

static float _EHHorizontalColorHeight = 4;

+ (float)cellGap
{
    return _EHDefaultGap * 8;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleLabel.frame = self.bounds;
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        UIView * tLabel = self.titleLabel;
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tLabel)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tLabel]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(tLabel)]];
    }
    return self;
}

- (UIView *)createSelectedView
{
    self.clipsToBounds = NO;
    self.coloredView.layer.shadowRadius = 7.5;
    self.coloredView.layer.shadowOffset = CGSizeMake(0, 0);
    self.coloredView.layer.masksToBounds = NO;
    self.coloredView.layer.shadowColor = self.coloredView.backgroundColor.CGColor;
    self.coloredView.layer.shadowOpacity = 1;
    self.selectedView.clipsToBounds = NO;

    [self updateSelectedFrames];
    return self.selectedView;
}



+ (float)colorHeight
{
    return _EHHorizontalColorHeight;
}

+ (void)updateColorHeight:(float)newH
{
    _EHHorizontalColorHeight = newH;
}

- (void)updateSelectedFrames
{
    self.selectedView.frame = self.bounds;
    self.coloredView.frame = CGRectMake(0, self.selectedView.bounds.size.height - [[self class] colorHeight], self.selectedView.bounds.size.width, [[self class] colorHeight]);
}

- (void)updateFramesForMovingFromRect:(CGRect)rect
{
    self.selectedView.frame = CGRectMake(CGRectGetMinX(rect) - CGRectGetMinX(self.frame), 0, rect.size.width, self.selectedView.bounds.size.height);
    self.coloredView.frame = CGRectMake(0, self.selectedView.bounds.size.height - [[self class] colorHeight], self.selectedView.bounds.size.width, [[self class] colorHeight]);
}

- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect
{
    if (selected)
    {
        self.selectedView.hidden = NO;
        [self updateSelectedFrames];
        if (!CGRectIsNull(rect))
        {
            [self updateFramesForMovingFromRect:rect];

            [UIView animateWithDuration:0.4 animations:^{
                [self updateSelectedFrames];
            
            }];
        }
    }
    
    [super setSelectedCell:selected fromCellRect:rect];
    
}


- (void)setSelectedCell:(BOOL)selected
{
    [self setSelectedCell:selected fromCellRect:CGRectNull];
}
@end
