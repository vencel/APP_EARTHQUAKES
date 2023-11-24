# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'pruebaearthquakes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for pruebaearthquakes

  target 'pruebaearthquakesTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'pruebaearthquakesUITests' do
    # Pods for testing
  end

pod 'Alamofire'
pod 'KeychainSwift'
pod 'SwiftJWT'
pod 'Connectivity'
pod 'RxSwift', '~> 5.1.1'
pod 'RxCocoa'
pod 'RxGesture'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
