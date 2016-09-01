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
    _arr1 = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth"];
    _arr2 = @[@"Living Room", @"Kitchen", @"Bedroom", @"Attic", @"Bathroom"];
    _arr3 = @[@"Lorem", @"Ipsum", @"Dolor", @"Sit", @"Amet", @"Consectetur"];
    
    _hSelView1.delegate = self;
    _hSelView2.delegate = self;
    _hSelView3.delegate = self;
    
    
    //set cell classes
    [_hSelView2 registerCellWithClass:[EHHorizontalLineViewCell class]];
    [_hSelView3 registerCellWithClass:[EHRoundedHorizontalViewCell class]];
    
    [_hSelView2 setTintColor:[UIColor colorWithHex:0xff46c7]];
    [EHRoundedHorizontalViewCell updateTintColor:[UIColor colorWithHex:0xffb647]];
    
    [EHRoundedHorizontalViewCell updateFontMedium:[UIFont boldSystemFontOfSize:15]];
    [EHRoundedHorizontalViewCell updateFont:[UIFont systemFontOfSize:15]];
    [_hSelView3 setCellGap:15];
    //set custom cell classes
}


#pragma mark - EHHorizontalSelectionViewProtocol

- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView*)hSelView
{
    if (hSelView == _hSelView1 || _hSelView5 == hSelView)
    {
        return [_arr1 count];
    }
    else if (hSelView == _hSelView2 || _hSelView4 == hSelView)
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
    if (hSelView == _hSelView1 || _hSelView5 == hSelView)
    {
        return [_arr1 objectAtIndex:index];
    }
    else if (hSelView == _hSelView2 || _hSelView4 == hSelView)
    {
        return [[_arr2 objectAtIndex:index] uppercaseString];
    }
    else if (hSelView == _hSelView3)
    {
        return [[_arr3 objectAtIndex:index] uppercaseString];
    }
    return @"";
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
