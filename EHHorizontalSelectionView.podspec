#
# Be sure to run `pod lib lint EHHorizontalSelectionView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EHHorizontalSelectionView'
  s.version          = '1.1.2'
  s.summary          = 'Horizontal table view style controller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
	This is extension for presenting horizontal lists of items (horizontal tableview)
                       DESC

  s.homepage         = 'https://github.com/josshad/EHHorizontalSelectionView/'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Danila Gusev' => 'jos.shad@gmail.com' }
  s.source           = { :git => 'https://github.com/josshad/EHHorizontalSelectionView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'EHHorizontalSelectionView/**/*.m','EHHorizontalSelectionView/**/*.h'
  s.public_header_files = 'EHHorizontalSelectionView/**/*.h'
  
  s.resource_bundles = {
    'EHHorizontalSelectionView' => ['EHHorizontalSelectionView/xibs/*.xib']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
