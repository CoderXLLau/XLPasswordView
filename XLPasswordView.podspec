Pod::Spec.new do |s|
    s.name         = 'XLPasswordView'
    s.version      = '0.9.1'
    s.summary      = 'An easy password input view'
    s.homepage     = 'https://github.com/CoderXLLau/XLPasswordView'
    s.license      = 'MIT'
    s.authors      = {'CoderXLLau' => '2604156181@qq.com'}
    s.platform     = :ios, '7.0'
    s.source       = {:git => 'https://github.com/CoderXLLau/XLPasswordView.git', :tag => s.version}
    s.source_files = 'XLPasswordView/**/*.{h,m}'
    s.resource     = 'XLPasswordView/XLPasswordView.bundle'

    s.requires_arc = true
end
