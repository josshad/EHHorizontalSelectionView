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

NS_ASSUME_NONNULL_BEGIN

IB_DESIGNABLE
@interface EHHorizontalSelectionView : UIView

/*!
 * @brief Delegate for selection view. If not null, then must realise - (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView and - (NSString * _Nullable)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView methods
 *
 */
@property (nonatomic, weak) id<EHHorizontalSelectionViewProtocol> delegate;

/*!
 * @brief text color of cells. If not setted value will take from cell class method +textColor
 */
@property (nonatomic, strong, nullable) IBInspectable UIColor * textColor;

/*!
 * @brief additional text color. Used customize appearence of nonSelected cells. May be setted for all cells of class with +updateAltTextColor
 */
@property (nonatomic, strong, nullable) IBInspectable UIColor * altTextColor;

/*!
 * @brief tint color of cells. If not setted value will take from cell class method +tintColor
 */
@property (nonatomic, strong, nullable) IBInspectable UIColor * tintColor;

/*!
 * @brief font of cells. If not setted value will take from cell class method +font
 */
@property (nonatomic, strong, nullable) UIFont * font;

/*!
 * @brief selected font of cells. If not setted value will take from cell class method +fontMedium
 */
@property (nonatomic, strong, nullable) UIFont * fontMedium;

/*!
 * @brief cell additional width. If not setted value will take from cell class method +cellGap
 */
@property (nonatomic, assign) IBInspectable CGFloat cellGap;

/*!
 * @brief need center cells if sums of their width < screen size. If not setted value will take from cell class method +needCentered
 */
@property (nonatomic, assign) IBInspectable BOOL needCentered;

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
- (void)registerCellWithClass:(Class)class;

/*!
 * @brief register nib for use by selection view
 *
 * @param nib UI of cell
 *
 * @param class Class to register (must be subclass of EHHorizontalViewCell)
 */
- (void)registerCellNib:(UINib *)nib withClass:(Class)class;


/*!
 * @brief register class for use by selection view
 *
 * @param class Class to register (must be subclass of EHHorizontalViewCell)
 *
 * @param identifier Reuse identifier for cell. Default is [class reuseIdentifier]
 */
- (void)registerCellWithClass:(Class)class reuseIdentifier:(NSString * _Nullable)identifier;

/*!
 * @brief register nib for use by selection view
 *
 * @param nib UI of cell
 *
 * @param class Class to register (must be subclass of EHHorizontalViewCell)
 *
 * @param identifier Reuse identifier for cell. Default is [class reuseIdentifier]
 */
- (void)registerCellNib:(UINib *)nib withClass:(Class)class reuseIdentifier:(NSString * _Nullable)identifier;


/*!
 * @brief geting cell for registered reuse identifier
 *
 * @param identifier Reuse identifier for cell. For example [class reuseIdentifier]
 *
 * @param indexPath indexPath for cell
 */
- (EHHorizontalViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString * _Nonnull)identifier forIndexPath:(NSIndexPath *)indexPath;


/*!
 * @brief returns selected index
 */
- (NSUInteger)selectedIndex;

/*!
 * @brief returns selection view data
 */
- (void)reloadData;

/*!
 * @brief deselects selected cell
 */
- (void)deselect;


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
- (NSString * _Nullable)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView*)hSelView;

@optional

/*!
 * @brief called when some cell of selection view will be selected
 *
 * @param selectionView Current selectionView
 *
 * @param index Index of selected item in selection view
 */
- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView willSelectObjectAtIndex:(NSUInteger)index;

/*!
 * @brief called when some cell of selection view will be selected
 *
 * @param selectionView Current selectionView
 *
 *
 * @param selectedCell Cell that became selected
 *
 * @param index Index of selected item in selection view
 */
- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView willSelectObject:(EHHorizontalViewCell *)selectedCell atIndex:(NSUInteger)index;


/*!
 * @brief called when some cell of selection view will became selected
 *
 * @param selectionView Current selectionView
 *
 * @param index Index of selected item in selection view
 */
- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView didSelectObjectAtIndex:(NSUInteger)index;

/*!
 * @brief called when some cell of selection view became selected
 *
 * @param selectionView Current selectionView
 *
 *
 * @param selectedCell Cell that became selected
 *
 * @param index Index of selected item in selection view
 */
- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView didSelectObject:(EHHorizontalViewCell *)selectedCell atIndex:(NSUInteger)index;


/*!
 * @brief _optional_ method for custom EHHorizontalViewCells
 *
 * @param selectionView Current selectionView
 *
 * @param indexPath Index of item
 */
- (EHHorizontalViewCell * _Nullable)selectionView:(EHHorizontalSelectionView *)selectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END

