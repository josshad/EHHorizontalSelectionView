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

@property (nonatomic, weak) id<EHHorizontalSelectionViewProtocol> delegate;

- (void)selectIndex:(NSUInteger)index;
- (void)registerCellWithClass:(Class)class;
- (void)registerCellNib:(UINib *)nib withClass:(Class)class;
- (NSUInteger)selectedIndex;

@end

@protocol EHHorizontalSelectionViewProtocol <NSObject>

@required
- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView*)hSelView;
- (NSString *)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView*)hSelView;

@optional
- (void)horizontalSelection:(EHHorizontalSelectionView *)hSelView didSelectObjectAtIndex:(NSUInteger)index;

@end