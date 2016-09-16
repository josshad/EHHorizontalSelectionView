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
    
//    _hSelView1.delegate = self;
//    _hSelView2.delegate = self;
//    _hSelView3.delegate = self;
//    
//    
//    //set cell classes
//    [_hSelView2 registerCellWithClass:[EHHorizontalLineViewCell class]];
//    [_hSelView3 registerCellWithClass:[EHRoundedHorizontalViewCell class]];
//    
//    //Set line color for _hSelView2 selection view
//    [_hSelView2 setTintColor:[UIColor colorWithHex:0xff46c7]];
//    
//    //Update color line height for EHHorizontalLineViewCell
//    [EHHorizontalLineViewCell updateColorHeight:2.f];
//    
//    //Update color for all EHRoundedHorizontalViewCell classes
//    [EHRoundedHorizontalViewCell updateTintColor:[UIColor colorWithHex:0xffb647]];
//    
//    //Update selected font for all EHRoundedHorizontalViewCell classes
//    [EHRoundedHorizontalViewCell updateFontMedium:[UIFont boldSystemFontOfSize:15]];
//    
//    //Set font for _hSelView3 selection view
//    [_hSelView3 setFont:[UIFont systemFontOfSize:18]];
//    
//    //Set cell additional inset
//    [_hSelView3 setCellGap:15];
    
    _hSelView4 = [[EHHorizontalSelectionView alloc] init];
    _hSelView4.frame = CGRectMake(0, 10.0f, 320.0, 60.0f);
    _hSelView4.delegate = self;
    [_hSelView4 registerCellWithClass:[EHRoundedHorizontalViewCell class]];
    [self.view addSubview:_hSelView4];
    

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
    else if (hSelView == _hSelView4)
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
    else if (hSelView == _hSelView4)
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
