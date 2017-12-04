//
//  HorizontalTableView.m
//  TvRemote
//
//  Created by Danila Gusev on 29/02/2016.
//  Copyright © 2016 com.abrt. All rights reserved.
//

#import "EHHorizontalSelectionView.h"
#import "EHHorizontalViewCell.h"


typedef NS_ENUM(NSUInteger, EHHorizontalSelectionViewType) {
    EHHorizontalSelectionViewDefault = 0,
    EHHorizontalSelectionViewLine = 1,
    EHHorizontalSelectionViewRound = 2
};

@interface EHHorizontalSelectionView () <UICollectionViewDataSource, UICollectionViewDelegate, EHHorizontalSelectionViewProtocol>

@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic) IBInspectable NSUInteger type;

@end


@implementation EHHorizontalSelectionView
{
    UICollectionViewFlowLayout * _flowLayout;
    NSIndexPath * _Nullable  _selectedIndexPath;
    EHHorizontalViewCell *_selectedCell;
    CGRect _lastCellRect;
    Class _class;
    NSString * _identifier;
    NSUInteger _objectsCount;
    UINib * _nib;
    BOOL _startScrolling;
    BOOL _hasChanges;
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

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
    self.delegate = self;
    [self reloadData];
}

#pragma mark - public
- (void)registerCellWithClass:(Class)class
{
    [self registerCellWithClass:class reuseIdentifier:nil];
}

- (void)registerCellNib:(UINib *)nib withClass:(Class)class
{
    [self registerCellNib:nib withClass:class reuseIdentifier:nil];
}

- (void)registerCellWithClass:(Class _Nonnull)class reuseIdentifier:(NSString *)identifier
{
    NSAssert([class isSubclassOfClass:[EHHorizontalViewCell class]],  @"registerCellWithClass: received class that is not subclass of EHHorizontalViewCell class" );
    _class = class;
    
    if (!identifier || [identifier length] == 0)
    {
        _identifier = [_class reuseIdentifier];
    }
    else
    {
        _identifier = identifier;
    }
    [_collectionView registerClass:class forCellWithReuseIdentifier:_identifier];
}

- (void)registerCellNib:(UINib * _Nonnull)nib withClass:(Class _Nonnull)class reuseIdentifier:(NSString *)identifier
{
    NSAssert([class isSubclassOfClass:[EHHorizontalViewCell class]],  @"registerCellNibWithName:withClass: received class that is not subclass of EHHorizontalViewCell class" );
    _class = class;
    if (!identifier || [identifier length] == 0)
    {
        _identifier = [_class reuseIdentifier];
    }
    else
    {
        _identifier = identifier;
    }
    [_collectionView registerNib:nib forCellWithReuseIdentifier:_identifier];
    _nib = nib;
}

- (EHHorizontalViewCell * _Nonnull)dequeueReusableCellWithReuseIdentifier:(NSString * _Nonnull)identifier forIndexPath:(NSIndexPath * _Nonnull)indexPath
{
    return [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
}

- (NSUInteger)selectedIndex
{
    if (!_selectedIndexPath || _selectedIndexPath.row < 0)
    {
        return NSNotFound;
    }

    return (NSUInteger)_selectedIndexPath.row;
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

#pragma mark - Accessors & Mutators 

- (void)setNeedCentered:(BOOL)needCentered {
    _needCentered = needCentered;
    _hasChanges = YES;
    [self reloadData];
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    [self reloadData];
}

- (void)setTintColor:(UIColor *)tintColor
{
    _tintColor = tintColor;
    [self reloadData];
}

- (void)setAltTextColor:(UIColor *)altTextColor
{
    _altTextColor = altTextColor;
   [self reloadData];
}

- (void)setType:(NSUInteger)type {
    if (_type != type) {
        _type = type;
        NSBundle * frameworkBundle = [NSBundle bundleForClass:[EHHorizontalViewCell class]];
        NSURL * bundleURL = [[frameworkBundle resourceURL] URLByAppendingPathComponent:@"EHHorizontalSelectionView.bundle"];
        NSBundle * podBundle = [NSBundle bundleWithURL:bundleURL];
        podBundle = (podBundle != nil) ? podBundle : frameworkBundle;
        
        switch (_type) {
            case EHHorizontalSelectionViewLine:
                [self registerCellWithClass:[EHHorizontalLineViewCell class]];
                break;
            case EHHorizontalSelectionViewRound:
                [self registerCellWithClass:[EHRoundedHorizontalViewCell class]];
                break;
            default:
                [self registerCellNib:[UINib nibWithNibName:@"EHHorizontalViewCell"  bundle:podBundle] withClass:[EHHorizontalViewCell class]];
        }
    }
    [self reloadData];
}

#pragma mark - private
- (void)startView
{
    if (!_collectionView)
    {
        _cellGap = NSIntegerMin;
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
        
        NSBundle * frameworkBundle = [NSBundle bundleForClass:[EHHorizontalViewCell class]];
        NSURL * bundleURL = [[frameworkBundle resourceURL] URLByAppendingPathComponent:@"EHHorizontalSelectionView.bundle"];
        NSBundle * podBundle = [NSBundle bundleWithURL:bundleURL];
        podBundle = (podBundle != nil) ? podBundle : frameworkBundle;
        
        switch (self.type) {               
            case EHHorizontalSelectionViewLine:
                [self registerCellWithClass:[EHHorizontalLineViewCell class]];
                break;
            case EHHorizontalSelectionViewRound:
                [self registerCellWithClass:[EHRoundedHorizontalViewCell class]];
                break;
            default:
                [self registerCellNib:[UINib nibWithNibName:@"EHHorizontalViewCell"  bundle:podBundle] withClass:[EHHorizontalViewCell class]];
        }
        
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
        
        if (!_font) {
            font = [_class font];
        } else {
            font = _font;
        }
        
        
        float gap;
        if (_cellGap == NSIntegerMin) { //Default behaviour

            gap = [_class cellGap];
        } else {
            gap = _cellGap;
        }
        
        
        CGSize strSize = [name sizeWithAttributes:@{NSFontAttributeName : font}];
        
        return CGSizeMake(strSize.width + gap, frame.size.height);
    } else {
        EHHorizontalViewCell * cell = [[_nib instantiateWithOwner:nil options:nil] firstObject];
        return cell.bounds.size;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    BOOL needCentered = NO;
    if (_hasChanges) {
        needCentered = self.needCentered;
    } else if ([_class isSubclassOfClass:[EHHorizontalViewCell class]]) { //default behaviour
        needCentered = [_class needCentered];
    }
    
    if (needCentered) {
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
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectionView:cellForItemAtIndexPath:)])
    {
        EHHorizontalViewCell * cell = [self.delegate selectionView:self cellForItemAtIndexPath:indexPath];
        if (cell != nil)
        {
            cell.selectedCell = NO;
            if (_selectedIndexPath.row == indexPath.row)
            {
                _lastCellRect = cell.frame;
                cell.selectedCell = YES;
                _selectedCell = cell;
            }
            return cell;
        }
    }
    
    
    EHHorizontalViewCell * cell = (EHHorizontalViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:_identifier forIndexPath:indexPath];
    
    
    [cell setTitleLabelText:[_delegate titleForItemAtIndex:indexPath.row forHorisontalSelection:self]];
    
    if (self.tintColor) {
        [cell setTintColor:self.tintColor];
    }
    
    if (self.textColor) {
        [cell setTextColor:self.textColor];
    }
    
    if (self.altTextColor) {
        [cell setAltTextColor:self.altTextColor];
    }
    
    if (self.font) {
        [cell setFont:self.font];
    }
    
    if (self.fontMedium) {
        [cell setFontMedium:self.fontMedium];
    }
    
    cell.selectedCell = NO;
    if (_selectedIndexPath.row == indexPath.row) {
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
    
        [UIView animateWithDuration:0.3 animations:^{
            [_collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        } completion:^(BOOL finished){
            if (_delegate && [_delegate respondsToSelector:@selector(horizontalSelection:didSelectObjectAtIndex:)])
            {
                [_delegate horizontalSelection:self didSelectObjectAtIndex:_selectedIndexPath.row];
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(horizontalSelection:didSelectObject:atIndex:)])
            {
                [_delegate horizontalSelection:self didSelectObject:_selectedCell atIndex:_selectedIndexPath.row];
            }
        }];
        [newCell setSelectedCell:YES fromCellRect:_lastCellRect];
        _lastCellRect = newCell.frame;
        
        if (_delegate && [_delegate respondsToSelector:@selector(horizontalSelection:willSelectObjectAtIndex:)])
        {
            [_delegate horizontalSelection:self willSelectObjectAtIndex:_selectedIndexPath.row];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(horizontalSelection:willSelectObject:atIndex:)])
        {
            [_delegate horizontalSelection:self willSelectObject:_selectedCell atIndex:_selectedIndexPath.row];
        }
    }
}

-(void)deselect
{
    [_selectedCell setSelectedCell:NO fromCellRect:_lastCellRect];

    _selectedIndexPath = NULL;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
}

#pragma mark - EHHorizontalSelectionViewProtocol

- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView *)hSelView
{
    return 3;
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView *)hSelView
{
    return [NSString stringWithFormat:@"Title %lu",(unsigned long)index];
}

@end
