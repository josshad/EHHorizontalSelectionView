# EHHorizontalSelectionView

This is extension for presenting horizontal lists of items (horizontal tableview)

<img src="https://josshad.github.io/EHHorizontalSelectionView/EHSelView.gif">

## Installation
### CocoaPods
To install EHHorizontalSelectionView using CocoaPods, please integrate it in your existing Podfile, or create a new Podfile:

```ruby
target 'MyApp' do
  pod 'EHHorizontalSelectionView'
end
```
Then run `pod install`.

### Manual
Add files from EHHorizontalSelectionView  to your project 

## Usage
	#import <EHHorizontalSelectionView/EHHorizontalSelectionView.h>

You can use EHHorizontalSelectionView as outlet in your xib or storyboard

	@property (nonatomic, weak) IBOutlet EHHorizontalSelectionView * hSelView;

Default style of table is with EHHorizontalViewCell cells. To change default behaviour you need register another cell class or cell nib. Custom cell must subclassed from EHHorizontalViewCell.

For example cell types with animated selection:

	[_hSelView registerCellWithClass:[EHHorizontalLineViewCell class]];
	
<img src="https://josshad.github.io/EHHorizontalSelectionView/EHLine.gif">
	
	[_hSelView1 registerCellWithClass:[EHRoundedHorizontalViewCell class]];
	
<img src="https://josshad.github.io/EHHorizontalSelectionView/EHRound.gif">

or your custom cell:

	[_hSelView2 registerCellNib:[UINib nibWithNibName:@"MyCustomCellNib" bundle:nil] withClass:[EHHorizontalViewCell class]];

Setting delegate:

	_hSelView1.delegate = self;

Delegate needs for getting data for selection view:

	- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView*)hSelView
	- (NSString *)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView*)hSelView
	
and for receiving selection event:

	- (void)horizontalSelection:(EHHorizontalSelectionView * _Nonnull)hSelView didSelectObjectAtIndex:(NSUInteger)index;
	
## Tips

In case of "the behavior of the UICollectionViewFlowLayout is not defined because:" may help:

	self.automaticallyAdjustsScrollViewInsets = NO;
	

## Customization

### IB customization
After 1.3.0 you can use IB to change selection view apperance. There was presented a set of properties allowing to change the appearance of the view.
<img src="https://josshad.github.io/EHHorizontalSelectionView/EHIBProperties.png">
EHHorizontalSelcetionView is now marked as IBDesignable and you can see customization on your xib or storyboard
<img src="https://josshad.github.io/EHHorizontalSelectionView/EHIBXib.png">


### Color
You can change default tint color for cell of selected type

    [EHHorizontalLineViewCell updateTintColor:[UIColor colorWithHex:0x00c264]];
  
You can subclass cell of that type and override method **+ (UIColor * _Nonnull)tintColor;**

    + (UIColor *)tintColor
    {
      return [UIColor redColor];
    }

Or you can change tint color for chosen selection view

        [_hSelView2 setTintColor:[UIColor colorWithHex:0xff46c7]];

### Fonts
  
Change default appearance

    [EHRoundedHorizontalViewCell updateFontMedium:[UIFont boldSystemFontOfSize:15]];
    [EHRoundedHorizontalViewCell updateFont:[UIFont systemFontOfSize:15]];

Change for chosen selectionView

    [_hSelView3 setFont:[UIFont systemFontOfSize:17]];
    
### Additional width for cell (inset)

Change default appearance

    [EHHorizontalLineViewCell updateCellGap:20];

Change for chosen selectionView

    [_hSelView3 setCellGap:15.f];    

   
### Line height (for EHHorizontalLineViewCell)

    [EHHorizontalLineViewCell updateColorHeight:2];

## Author
Danila Gusev

<a href="mailto:jos.shad@gmail.com">jos.shad@gmail.com</a>

## License

Usage is provided under the <a href="http://opensource.org/licenses/MIT" target="_blank">MIT</a> License. See <a href="https://github.com/josshad/EHHorizontalSelectionView/blob/master/LICENSE">LICENSE</a> for full details.
