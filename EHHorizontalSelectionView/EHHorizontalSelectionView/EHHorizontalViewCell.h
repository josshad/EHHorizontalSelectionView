//
//  EHHorizontalViewCell.h
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat _EHDefaultGap = 10;

@interface EHHorizontalViewCell : UICollectionViewCell

@property (nonatomic, weak, nullable) IBOutlet UILabel * titleLabel;

@property (nonatomic, weak, nullable) IBOutlet UIView * selectedView;

@property (nonatomic, weak, nullable) IBOutlet UIView * coloredView;

@property (nonatomic, assign) BOOL selectedCell;

//class methods

+ (NSString * _Nonnull)reuseIdentifier;
+ (UIFont * _Nonnull)currentFont;
+ (UIFont * _Nonnull)currentFontMedium;

+ (BOOL)useDynamicSize;

+ (float)currentGap;
+ (BOOL)needCentred;

//instance methods
- (void)highlight:(BOOL)highlighted;
- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect;
- (void)setTitleLabelText:(nullable NSString  *)text;

@end
