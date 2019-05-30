# Uncomment this line to define a global platform for your project
platform :ios, '11.0'

  # Comment the next line if you don't want to use dynamic frameworks
def shared_pods
  use_frameworks!

  pod 'NextResponderTextField'
  pod 'IQKeyboardManagerSwift', :git => 'https://github.com/CameronPorter95/IQKeyboardManager.git'
  pod 'KeychainAccess'
  pod 'Moya'
  pod 'BrightFutures'
  pod 'Cache', :git => 'https://github.com/CameronPorter95/Cache.git', :branch => 'version_4.2.0_swift_5.0'

end

target 'FormBuilder' do
  shared_pods
end

target 'FormBuilderTests' do
  inherit! :search_paths
end

target 'FormBuilderUITests' do
  inherit! :search_paths
end
