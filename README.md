# EHHorizontalSelectionView

This is extension for presenting horisontal lists of items (horisontal tableview)

## Installation
### Manual
Add files from EHHorizontalSelectionView/EHHorizontalSelectionView  to your project 

##Usage
	#import <EHHorizontalSelectionView/EHHorizontalSelectionView.h>

##Customization

###Color
You can change default tint color for cell of selected type

    [EHHorizontalLineViewCell updateTintColor:[UIColor colorWithHex:0x00c264]];
  
Or you can subclass cell of that type and override method **+ (UIColor * _Nonnull)tintColor;**

    + (UIColor *)tintColor
    {
      return [UIColor redColor];
    }

###Fonts
  
    [EHRoundedHorizontalViewCell updateFontMedium:[UIFont boldSystemFontOfSize:15]];
    [EHRoundedHorizontalViewCell updateFontMedium:[UIFont systemFontOfSize:15]];
    
###Gap wifth between cells

    [EHHorizontalLineViewCell updateCellGap:20];
    
###Line height (for EHHorizontalLineViewCell)

    [EHHorizontalLineViewCell updateColorHeight:2];

##Author
Danila Gusev

<a href="mailto:jos.shad@gmail.com">jos.shad@gmail.com</a>

## License

Usage is provided under the <a href="http://opensource.org/licenses/MIT" target="_blank">MIT</a> License. See <a href="https://github.com/josshad/EHPlainAlert/blob/master/LICENSE">LICENSE</a> for full details.
