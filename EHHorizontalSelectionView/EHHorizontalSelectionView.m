//
//  HorizontalTableView.m
//  TvRemote
//
//  Created by Danila Gusev on 29/02/2016.
//  Copyright © 2016 com.abrt. All rights reserved.
//

#import "EHHorizontalSelectionView.h"
#import "EHHorizontalViewCell.h"



@interface EHHorizontalSelectionView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView * collectionView;

@end


@implementation EHHorizontalSelectionView
{

    UICollectionViewFlowLayout * _flowLayout;
    NSIndexPath * _selectedIndexPath;
    EHHorizontalViewCell *_selectedCell;
    CGRect _lastCellRect;
    Class _class;
    NSUInteger _objectsCount;
    UINib * _nib;
}

#pragma mark - initializers
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self startView];
    }
    return self;
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self startView];
    }
    return self;
}

#pragma mark - public
- (void)registerCellWithClass:(Class)class
{
    NSCAssert([class isSubclassOfClass:[EHHorizontalViewCell class]],  @"registerCellWithClass: received class that is not subclass of EHHorizontalViewCell class" );
    _class = class;
    [_collectionView registerClass:class forCellWithReuseIdentifier:[_class reuseIdentifier]];
}

- (void)registerCellNib:(UINib *)nib withClass:(Class)class
{
    NSCAssert([class isSubclassOfClass:[EHHorizontalViewCell class]],  @"registerCellNibWithName:withClass: received class that is not subclass of EHHorizontalViewCell class" );
    _class = class;
    [_collectionView registerNib:nib forCellWithReuseIdentifier:[_class reuseIdentifier]];
    _nib = nib;
}


- (NSUInteger)selectedIndex
{
    return _selectedIndexPath.row;
}

- (void)selectIndex:(NSUInteger)index
{
    NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [_collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    [self collectionView:_collectionView didSelectItemAtIndexPath:indexPath];
}

- (void)reloadData
{
    [_collectionView reloadData];
}

#pragma mark - private
- (void)startView
{
    if (!_collectionView)
    {
        _cellGap = NSIntegerMin;
        _needCentered = NSIntegerMin;
        _fontMedium = nil;
        _font = nil;
        _tintColor = nil;
        _textColor = nil;
        _selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        _flowLayout  = [[UICollectionViewFlowLayout alloc] init];
        [_flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _flowLayout.minimumInteritemSpacing = 4.0f;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = YES;
        _collectionView.clipsToBounds = NO;
        self.clipsToBounds = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [_collectionView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_collectionView setShowsHorizontalScrollIndicator:NO];
        [_collectionView setShowsVerticalScrollIndicator:NO];
        [_collectionView setAlwaysBounceHorizontal:YES];
        
        [self registerCellNib:[UINib nibWithNibName:@"EHHorizontalViewCell"  bundle:[NSBundle bundleForClass:[EHHorizontalViewCell class]]] withClass:[EHHorizontalViewCell class]];
        
        [self addSubview:_collectionView];
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_collectionView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_collectionView)]];
        
        [_collectionView reloadData];
    }
}

#pragma mark - Collecton view methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    _objectsCount = MAX(0,[_delegate numberOfItemsInHorizontalSelection:self]);
    return _objectsCount;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGRect frame = collectionView.frame;

    NSString * name = [_delegate titleForItemAtIndex:indexPath.row forHorisontalSelection:self];

    if ([_class useDynamicSize])
    {
        
        UIFont * font;
        
        if (!_font)
        {
            font = [_class font];
        }
        else
        {
            font = _font;
        }
        
        
        float gap;
        if (_cellGap == NSIntegerMin)
        {
            gap = [_class cellGap];
        }
        else
        {
            gap = _cellGap;
        }
        
        
        CGSize strSize = [name sizeWithAttributes:@{NSFontAttributeName : font}];
        
        return CGSizeMake(strSize.width + gap, frame.size.height);
    }
    else
    {
        
        EHHorizontalViewCell * cell = [[_nib instantiateWithOwner:nil options:nil] lastObject];
        return cell.bounds.size;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    BOOL needCentered = NO;
    if (_needCentered >= 0)
    {
        needCentered = _needCentered;
    }
    else if ([_class isSubclassOfClass:[EHHorizontalViewCell class]])
    {
        needCentered = [_class needCentered];
    }
    
    if (needCentered)
    {
        float width = 0;
        for (int i = 0; i < _objectsCount; i++)
        {
            CGSize size = [self collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:section]];
            width += size.width;
        }
        if (width < self.bounds.size.width)
            return UIEdgeInsetsMake(0, (self.bounds.size.width - width) / 2.0, 0, 0);
    }
    
    return UIEdgeInsetsZero;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EHHorizontalViewCell * cell = (EHHorizontalViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:[_class reuseIdentifier] forIndexPath:indexPath];
    
    
    [cell setTitleLabelText:[_delegate titleForItemAtIndex:indexPath.row forHorisontalSelection:self]];

    if (_tintColor)
    {
        [cell setTintColor:_tintColor];
    }
    
    if (_textColor)
    {
        [cell setTextColor:_textColor];
    }
    
    if (_font)
    {
        [cell setFont:_font];
    }
    
    if (_fontMedium)
    {
        [cell setFontMedium:_fontMedium];
    }
    
    cell.selectedCell = NO;
    if (_selectedIndexPath.row == indexPath.row)
    {
        _lastCellRect = cell.frame;
        cell.selectedCell = YES;
        _selectedCell = cell;
    }
    return cell;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    EHHorizontalViewCell * cell = (EHHorizontalViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell highlight:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    EHHorizontalViewCell * cell = (EHHorizontalViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell highlight:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectedCell)
    {
        _selectedCell.selectedCell = NO;
    }
    
    EHHorizontalViewCell * newCell = (EHHorizontalViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    _selectedIndexPath = indexPath;
    _selectedCell = newCell;

    if (_selectedIndexPath.row < _objectsCount)
    {
        [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        [newCell setSelectedCell:YES fromCellRect:_lastCellRect];
        _lastCellRect = newCell.frame;
        
        if (_delegate && [_delegate respondsToSelector:@selector(horizontalSelection:didSelectObjectAtIndex:)])
        {
            [_delegate horizontalSelection:self didSelectObjectAtIndex:_selectedIndexPath.row];
        }
    }
}



@end
