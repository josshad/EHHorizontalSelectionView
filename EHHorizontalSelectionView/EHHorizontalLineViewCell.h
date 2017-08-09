//
//  HorizontalViewCell.h
//  TvRemote
//
//  Created by Danila Gusev on 29/02/2016.
//  Copyright © 2016 com.abrt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EHHorizontalViewCell.h"

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface EHHorizontalLineViewCell : EHHorizontalViewCell

/*!
 * @brief default height of selection line for EHHorizontalLineViewCell cells
 */
+ (float)colorHeight;

/*!
 * @brief change default height
 */
+ (void)updateColorHeight:(float)newH;

@end

NS_ASSUME_NONNULL_END
