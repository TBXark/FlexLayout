#
# Be sure to run `pod lib lint FlexLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TKFlexLayout'
  s.version          = '1.0.0'
  s.summary          = 'A simple flexLayout tool.'
  s.description      = 'A simple flexLayout tool by Swift'
  s.homepage         = 'https://github.com/tbxark/FlexLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tbxark' => 'tbxark@outlook.com' }
  s.source           = { :git => 'https://github.com/tbxark/FlexLayout.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.module_name = 'FlexLayout'
  s.source_files = 'FlexLayout/Classes/**/*'
end
