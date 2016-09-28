//
//  HorizontalTableView.h
//  TvRemote
//
//  Created by Danila Gusev on 29/02/2016.
//  Copyright © 2016 com.abrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHorizontalViewCell.h"
#import "EHHorizontalLineViewCell.h"
#import "EHRoundedHorizontalViewCell.h"

@protocol EHHorizontalSelectionViewProtocol;

@interface EHHorizontalSelectionView : UIView

/*!
 * @brief Delegate for selection view. If not null, then must realise - (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView and - (NSString * _Nullable)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView methods
 *
 */
@property (nonatomic, weak) id<EHHorizontalSelectionViewProtocol> _Nullable delegate;


/*!
 * @brief text color of cells. If not setted value will take from cell class method +textColor
 */
@property (nonatomic, strong) UIColor * _Nullable textColor;

/*!
 * @brief tint color of cells. If not setted value will take from cell class method +tintColor
 */
@property (nonatomic, strong) UIColor * _Nullable tintColor;

/*!
 * @brief font of cells. If not setted value will take from cell class method +font
 */
@property (nonatomic, strong) UIFont * _Nullable font;

/*!
 * @brief selected font of cells. If not setted value will take from cell class method +fontMedium
 */
@property (nonatomic, strong) UIFont * _Nullable fontMedium;

/*!
 * @brief cell additional width. If not setted value will take from cell class method +cellGap
 */
@property (nonatomic, assign) float cellGap;

/*!
 * @brief need center cells if sums of their width < screen size. If not setted value will take from cell class method +needCentered
 */
@property (nonatomic, assign) NSInteger needCentered;

/*!
 * @brief select element of selection view
 *
 * @param index Index to select
 */
- (void)selectIndex:(NSUInteger)index;

/*!
 * @brief register class for use by selection view
 *
 * @param class Class to register (must be subclass of EHHorizontalViewCell)
 */
- (void)registerCellWithClass:(Class _Nonnull)class;

/*!
 * @brief register nib for use by selection view
 *
 * @param nib UI of cell
 *
 * @param class Class to register (must be subclass of EHHorizontalViewCell)
 */
- (void)registerCellNib:(UINib * _Nonnull)nib withClass:(Class _Nonnull)class;

/*!
 * @brief returns selected index
 */
- (NSUInteger)selectedIndex;

/*!
 * @brief returns selection view data
 */
- (void)reloadData;



@end

@protocol EHHorizontalSelectionViewProtocol <NSObject>

@required

/*!
 * @brief called on selection view updates. Should return count of cells in selection view
 *
 * @param hSelView Current selectionView
 */
- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView;

/*!
 * @brief called on generating selection view cell at index. Should return count of cells in selection view
 *
 * @param index Index of item in selection view
 *
 * @param hSelView Current selectionView
 */
- (NSString * _Nullable)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView;

@optional

/*!
 * @brief called when some cell of selection view became selected
 *
 * @param hSelView Current selectionView
 *
 * @param index Index of selected item in selection view
 */
- (void)horizontalSelection:(EHHorizontalSelectionView * _Nonnull)hSelView didSelectObjectAtIndex:(NSUInteger)index;

@end