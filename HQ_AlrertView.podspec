Pod::Spec.new do |s|
s.name = 'HQ_AlrertView'
s.version = '1.0.0'
s.license = 'MIT'
s.summary = '自定义的一个Alert弹框'
s.homepage = 'https://github.com/GrayDoll/HQ_AlrertView'
s.authors = { 'GrayDoll' => '1224469004@qq.com' }
s.source = { :git => "https://github.com/GrayDoll/HQ_AlrertView.git", :tag => "1.0.0"}
s.requires_arc = true
s.ios.deployment_target = '8.0'
s.source_files = "DFTextStyle", "*.{h,m}"
end