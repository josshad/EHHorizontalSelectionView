//
//  UIColor+UIColorAdditions.h
//  jReader
//
//  Created by Danila Gusev on 03/12/15.
//  Copyright © 2015 Danila Gusev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorAdditions)

- (NSInteger)getHexColor;
+ (UIColor *)colorWithHex:(NSInteger)intColor;
@end
