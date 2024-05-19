Pod::Spec.new do |s|
    s.name         = "ScateSDK-ios"
    s.version      = "0.0.1"
    s.summary      = "Scate iOS SDK"
    s.description  = "Scate SDK"
    s.homepage     = "https://github.com/scateio/ScateSDK-ios.git"
    s.license = { :type => "MIT", :file => "LICENSE" }
    s.author             = { "Scate" => "e@inscate.com" }
    s.source       = { :git => "https://github.com/scateio/ScateSDK-ios.git", :branch => "main", :tag => "#{s.version}" }
    s.vendored_frameworks = "ScateSDK.xcframework"
    s.platform = :ios
    s.swift_version = "5.7"
    s.ios.deployment_target  = '16.0'
    s.requires_arc = true
end