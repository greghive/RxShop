# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'
use_frameworks!

target 'RxShop' do
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxDataSources'
end

target 'RxShopTests' do
    pod 'RxBlocking'
    pod 'RxTest'
end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      if target.name == 'RxSwift'
         target.build_configurations.each do |config|
            if config.name == 'Debug'
               config.build_settings['OTHER_SWIFT_FLAGS'] ||= ['-D', 'TRACE_RESOURCES']
            end
         end
      end
   end
end
