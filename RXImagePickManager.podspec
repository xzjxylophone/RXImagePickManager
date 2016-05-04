

Pod::Spec.new do |s|
  s.name     = "RXImagePickManager"
  s.version  = "0.4"
  s.license  = "MIT"
  s.summary  = "RXImagePickManager is a normal RXImagePickManager"
  s.homepage = "https://github.com/xzjxylophone/RXImagePickManager"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXImagePickManager.git', :tag => "v#{s.version}" }
  s.description = %{
      RXImagePickManager is a normal RXImagePickManager.
  }
  s.source_files = 'RXImagePickManager/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '7.0'
end






