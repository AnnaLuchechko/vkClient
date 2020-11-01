# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'vkClient' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

	pod 'Alamofire', '~> 5.2'
	pod 'SwiftyJSON', '~> 5.0.0'
	pod 'Kingfisher', '~> 5.14.1'
	pod 'SwiftKeychainWrapper', '~> 4.0.1'
  pod "PromiseKit"
	pod 'RealmSwift'
  
end

post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
             config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
             config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
    
         end
     end
 end
