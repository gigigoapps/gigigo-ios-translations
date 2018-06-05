Pod::Spec.new do |s|  
    s.name              = 'GIGTranslations'
    s.version           = '0.0.1'
    s.summary           = 'Framework to support translations from Gigigo Translation Center'
    s.homepage          = 'https://gigigo.com/'

    s.author            = { 'Name' => 'jerilyn.goncalves@gigigo.com' }
    s.license           = { :type => 'MIT', :file => 'LICENSE' }

    s.platform          = :ios
    #s.source            = { :http => 'link to your cocoapods .zip attachment' }
    s.source_files      = "GIGTranslations.h"
    s.ios.deployment_target = '9.0'
    s.ios.vendored_frameworks = 'GIGTranslations.framework'
end