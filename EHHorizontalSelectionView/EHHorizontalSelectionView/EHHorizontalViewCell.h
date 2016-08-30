//
//  EHHorizontalViewCell.h
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat _EHDefaultGap = 10;
static NSMutableDictionary * _EHHorisontalSelectionStyles  = nil;

@interface EHHorizontalViewCell : UICollectionViewCell

@property (nonatomic, weak, nullable) IBOutlet UILabel * titleLabel;

@property (nonatomic, weak, nullable) IBOutlet UIView * selectedView;

@property (nonatomic, weak, nullable) IBOutlet UIView * coloredView;

@property (nonatomic, assign) BOOL selectedCell;

//class methods

+ (BOOL)useDynamicSize;
+ (NSMutableDictionary * _Nonnull)styles;

+ (NSString * _Nonnull)reuseIdentifier;
+ (UIFont * _Nonnull)font;
+ (UIFont * _Nonnull)fontMedium;
+ (float)cellGap;
+ (BOOL)needCentred;


+ (void)updateTintColor:(UIColor * _Nonnull)color;
+ (void)updateFont:(UIFont * _Nonnull)font;
+ (void)updateFontMedium:(UIFont * _Nonnull)font;
+ (void)updateCellGap:(float)gap;
+ (void)updateNeedCentered:(BOOL)needCentered;





//instance methods
- (UIView * _Nullable)createSelectedView;
- (void)highlight:(BOOL)highlighted;
- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect;
- (void)setTitleLabelText:(nullable NSString  *)text;

@end
