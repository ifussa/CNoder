platform :ios, '8.0'
use_frameworks!
target ‘CNoder’ do

pod 'SwifterSwift'
pod 'Alamofire'
pod 'SnapKit'
pod 'Kingfisher'
pod 'SVProgressHUD'
pod 'EFQRCode'
pod 'QRCodeReader.swift'
pod 'ObjectMapper'
pod 'CryptoSwift'
pod 'SDWebImage'

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

end
