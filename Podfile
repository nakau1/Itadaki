# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF'] = false
    end
  end
end

target 'Itadaki' do
  inhibit_all_warnings!
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Realm'#, :git => 'https://github.com/realm/realm-cocoa.git', :submodules => true
  pod 'RealmSwift'#, :git => 'https://github.com/realm/realm-cocoa.git', :submodules => true

  target 'ItadakiTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
