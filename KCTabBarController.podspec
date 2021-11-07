Pod::Spec.new do |s|
  
  s.name = 'KCTabBarController'
  s.version      = "0.0.1"
  s.license= { :type => "MIT", :file => "LICENSE" }
  s.summary      = "封装一个简单好用的TabBarController,以后一键导入"
  s.homepage     = "https://github.com/LGCooci/KCTabBarController.git"
  s.authors            = { "cooci" => "cooci_tz@163.com" }
  s.source = { :git => "https://github.com/LGCooci/KCTabBarController.git", :tag => s.version}
  s.requires_arc = true
  s.ios.deployment_target = '9.0'
  s.source_files = "KCTabBarController/KCTabBarController/*.{h,m}"
  s.frameworks = 'UIKit','Foundation'
end
