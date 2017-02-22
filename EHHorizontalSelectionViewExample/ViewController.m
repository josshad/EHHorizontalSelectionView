//
//  ViewController.m
//  EHHorizontalSelectionView
//
//  Created by Danila Gusev on 30/08/2016.
//  Copyright © 2016 josshad. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+UIColorAdditions.h"
#import "UIImage+UIImageAdditions.h"
#import "CustomHorizontalViewCell.h"

@interface ViewController () <EHHorizontalSelectionViewProtocol>

@end

@implementation ViewController
{
    NSArray * _arr1;
    NSArray * _arr2;
    NSArray * _arr3;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _arr1 = @[@"First", @"Second"];
    _arr2 = @[@"Living Room", @"Kitchen", @"Bedroom", @"Attic", @"Bathroom"];
    _arr3 = @[@"Lorem", @"Ipsum", @"Dolor", @"Sit"];
    
    _hSelView1.delegate = self;
    _hSelView2.delegate = self;
    _hSelView3.delegate = self;
    
    
    //set cell classes
    [_hSelView2 registerCellWithClass:[EHHorizontalLineViewCell class]];
    
    [_hSelView3 registerCellNib:[UINib nibWithNibName:@"CustomHorizontalViewCell" bundle:nil] withClass:[CustomHorizontalViewCell class]];
    
    //Set line color for _hSelView2 selection view
    [_hSelView2 setTintColor:[UIColor colorWithHex:0xff46c7]];
    
    //Update color line height for EHHorizontalLineViewCell
    [EHHorizontalLineViewCell updateColorHeight:2.f];
    
    //Set font for _hSelView3 selection view
    [_hSelView3 setFont:[UIFont systemFontOfSize:18]];
    
    
    [_hSelView1 setTextColor:[UIColor redColor]];
    
    [_hSelView1 setAltTextColor:[UIColor orangeColor]];
    
    [EHHorizontalLineViewCell updateTextColor:[UIColor colorWithHex:0x0085d2]];
    
    [_hSelView1 setNeedCentered:YES];
}


#pragma mark - EHHorizontalSelectionViewProtocol

- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView*)hSelView
{
    if (hSelView == _hSelView1)
    {
        return [_arr1 count];
    }
    else if (hSelView == _hSelView2)
    {
        return [_arr2 count];
    }
    else if (hSelView == _hSelView3)
    {
        return [_arr3 count];
    }
    return 0;
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView*)hSelView
{
    if (hSelView == _hSelView1 )
    {
        return [_arr1 objectAtIndex:index];
    }
    else if (hSelView == _hSelView2)
    {
        return [[_arr2 objectAtIndex:index] uppercaseString];
    }
    else if (hSelView == _hSelView3)
    {
        return [_arr3 objectAtIndex:index];
    }
    return @"";
}

- (EHHorizontalViewCell *)selectionView:(EHHorizontalSelectionView *)selectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectionView == _hSelView3)
    {
        CustomHorizontalViewCell * cell = (CustomHorizontalViewCell*)[selectionView dequeueReusableCellWithReuseIdentifier:[CustomHorizontalViewCell reuseIdentifier] forIndexPath:indexPath];
        cell.titleLabel.text = [_arr3 objectAtIndex:indexPath.row];
        NSString * str = [NSString stringWithFormat:@"%li",(long)indexPath.row + 1];
        UIImage * image = [UIImage imageNamed:str];
        cell.iconView.image = image;
        cell.altTextColor = [UIColor blackColor];
        return cell;
    }
    return nil;
}

#pragma mark - UI

- (void)viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithStartColor:[UIColor colorWithHex:0x1f1c27] endColor:[UIColor colorWithHex:0x544a57] size:CGSizeMake(1, self.view.bounds.size.height)]];
    self.navigationController.navigationBarHidden = YES;
    [super viewWillAppear:animated];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
