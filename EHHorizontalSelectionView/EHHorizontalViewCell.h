//
//  EHHorizontalViewCell.h
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const CGFloat _EHDefaultGap;

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface EHHorizontalViewCell : UICollectionViewCell


/*!
 * @brief title label outlet.
 */
@property (nonatomic, weak, nullable) IBOutlet UILabel * titleLabel;


/*!
 * @brief view that appear on selection
 */
@property (nonatomic, weak, nullable) IBOutlet UIView * selectedView;


/*!
 * @brief subview of selectedView. Tint color is applied to it.
 */
@property (nonatomic, weak, nullable) IBOutlet UIView * coloredView;


/*!
 * @brief flag that cell is selected
 */
@property (nonatomic, assign) BOOL selectedCell;

/*!
 * @brief text color of current cell. If not setted value will take from cell class method +textColor
 */
@property (nonatomic, strong) UIColor * _Nullable textColor;

/*!
 * @brief additional text color. Used customize appearence of nonSelected cells
 */
@property (nonatomic, strong) UIColor * _Nullable altTextColor;

/*!
 * @brief tint color of current cell. If not setted value will take from cell class method +tintColor
 */
@property (nonatomic, strong) UIColor * _Nullable tintColor;

/*!
 * @brief font of current cell. If not setted value will take from cell class method +fontMedium
 */
@property (nonatomic, strong) UIFont * _Nullable font;

/*!
 * @brief selected font of current cell. If not setted value will take from cell class method +fontMedium
 */
@property (nonatomic, strong) UIFont * _Nullable fontMedium;

//class methods


/*!
 * @brief adjust cell size with title label font. Default YES. 
 */
+ (BOOL)useDynamicSize;

/*!
 * @brief styles dictionary of current cell class
 */
+ (NSMutableDictionary * _Nonnull)styles;


/*!
 * @brief reuseIdentifier string for cell class. Default is class name.
 */
+ (NSString * _Nonnull)reuseIdentifier;


//styles
/*!
 * @brief default font of all cells of current class.
 */
+ (UIFont * _Nonnull)font;

/*!
 * @brief default font for selecton of all cells of current class.
 */
+ (UIFont * _Nonnull)fontMedium;


/*!
 * @brief default color for text of all cells of current class.
 */
+ (UIColor * _Nonnull)textColor;

/*!
 * @brief alternative text color of all cells of current class.
 */
+ (UIColor * _Nonnull)altTextColor;

/*!
 * @brief default color for selection of all cells of current class.
 */
+ (UIColor * _Nonnull)tintColor;

/*!
 * @brief cell additional width of current class.
 */
+ (float)cellGap;

/*!
 * @brief need center cells if sums of their width < screen size
 */
+ (BOOL)needCentered;


//change styles of all cells of current class


/*!
 * @brief change default text color
 */
+ (void)updateTextColor:(UIColor * _Nonnull)color;

/*!
 * @brief change alternative text color for all cells of class
 */
+ (void)updateAltTextColor:(UIColor * _Nonnull)color;


/*!
 * @brief change default tint color
 */
+ (void)updateTintColor:(UIColor * _Nonnull)color;

/*!
 * @brief change default font
 */
+ (void)updateFont:(UIFont * _Nonnull)font;

/*!
 * @brief change default selection font
 */
+ (void)updateFontMedium:(UIFont * _Nonnull)font;

/*!
 * @brief change default gap
 */
+ (void)updateCellGap:(float)gap;

/*!
 * @brief change cells centering
 */
+ (void)updateNeedCentered:(BOOL)needCentered;





//instance methods
/*!
 * @brief selected view creation. could be overridden
 */
- (UIView * _Nullable)createSelectedView;

/*!
 * @brief cell highlightning
 */
- (void)highlight:(BOOL)highlighted;

/*!
 * @brief cell selection
 */
- (void)setSelectedCell:(BOOL)selected fromCellRect:(CGRect)rect;

/*!
 * @brief change title label text
 */
- (void)setTitleLabelText:(nullable NSString  *)text;

@end

NS_ASSUME_NONNULL_END
