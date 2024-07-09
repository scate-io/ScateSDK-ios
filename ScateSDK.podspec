Pod::Spec.new do |s|
    s.name         = "ScateSDK"
    s.version      = "0.0.2"
    s.summary      = "Scate SDK is made for developers to integrate Scate's services into their apps. Please visit https://www.scate.io for more information."
    s.homepage     = "https://github.com/scateio/ScateSDK-ios.git"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "Scate" => "e@inscate.com" }
    s.source       = { :http => 'https://github.com/scateio/ScateSDK-ios/releases/download/0.0.1/ScateSDK.xcframework-0.0.2.zip' }
    s.vendored_frameworks = "ScateSDK.xcframework"
    s.ios.deployment_target = '12.0'
end