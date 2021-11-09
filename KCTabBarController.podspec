#
# Be sure to run `pod lib lint KCTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KCTabBarController'
  s.version          = '0.0.2'
  s.summary          = 'A short description of KCTabBarController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage     = "https://github.com/LGCooci/KCTabBarController.git"
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors            = { "cooci" => "cooci_tz@163.com" }
  s.source = { :git => "https://github.com/LGCooci/KCTabBarController.git", :tag => s.version}
   s.social_media_url = 'https://juejin.im/user/5c3f3c415188252b7d0ea40c'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KCTabBarController/**/*'
  
  # s.resource_bundles = {
  #   'KCTabBarController' => ['KCTabBarController/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit','Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end