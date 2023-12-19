# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TuraqApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  post_install do |installer|
      installer.generated_projects.each do |project|
            project.targets.each do |target|
                target.build_configurations.each do |config|
                    config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
                 end
            end
     end
  end

  # Pods for TuraqApp
  pod 'SnapKit', '~> 5.6.0'
  pod 'IQKeyboardManagerSwift', '6.3.0'
  pod 'Alamofire'
  pod 'SkeletonView'
  pod 'GoogleMaps', '7.4.0'
  pod 'FittedSheets'

  target 'TuraqAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TuraqAppUITests' do
    # Pods for testing
  end

end
