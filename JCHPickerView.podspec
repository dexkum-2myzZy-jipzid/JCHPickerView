Pod::Spec.new do |s|
  s.name         = "JCHPickerView"
  s.version      = "1.0.1"
  s.summary      = "A horizontal picker view for iOS."
  s.homepage     = "https://github.com/J4ckChan/JCHPickerView"
  s.social_media_url = "https://twitter.com/LiangChen829"
  s.license      = 'MIT'
  s.author       = { "J4ck_Chan" => "liang.chen829@gmail.com" }
  s.source       = { :git => "https://github.com/J4ckChan/JCHPickerView.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'JCHPickerView/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
end
