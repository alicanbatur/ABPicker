#
# Be sure to run `pod lib lint ABPicker.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "ABPicker"
  s.version          = "0.1.0"
  s.summary          = "Picker with a custom, date and hour column."
  s.description      = <<-DESC
                       * Fill your custom column with what you need. Let me know min date and how many days you want in yoru date area. Let me know min, max hour value. Leave the rest.
                       * There will be a button, textfield and a view which can be animate.
                       DESC
  s.homepage         = "https://github.com/alicanbatur/ABPicker"
  s.license          = 'MIT'
  s.author           = { "alicanbatur" => "alicanbatur@hotmail.com" }
  s.source           = { :git => "https://github.com/alicanbatur/ABPicker.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alicanbatur'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'ABPicker' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
