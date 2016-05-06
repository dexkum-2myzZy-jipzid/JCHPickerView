Pod::Spec.new do |s|
  s.name         = "JCHPickerView"
  s.version      = "1.0.0"
  s.summary      = "A horizontal picker view for iOS."
  s.homepage     = "https://github.com/JackChan829/JCHPickerView"
  s.license      = 'MIT'
  s.author       = { "J4ck_Chan" => "liang.chen829@gmail.com" }
  s.source       = { :git => "https://github.com/JackChan829/JCHPickerView.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'JCHPickerView/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
end
