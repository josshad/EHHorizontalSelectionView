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

@property (nonatomic, weak) id<EHHorizontalSelectionViewProtocol> _Nullable delegate;

- (void)selectIndex:(NSUInteger)index;
- (void)registerCellWithClass:(Class _Nonnull)class;
- (void)registerCellNib:(UINib * _Nonnull)nib withClass:(Class _Nonnull)class;
- (NSUInteger)selectedIndex;

@end

@protocol EHHorizontalSelectionViewProtocol <NSObject>

@required
- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView;
- (NSString * _Nullable)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView* _Nonnull)hSelView;

@optional
- (void)horizontalSelection:(EHHorizontalSelectionView * _Nonnull)hSelView didSelectObjectAtIndex:(NSUInteger)index;

@end