Pod::Spec.new do |s|

  s.name         = "Color-tvOS-SDK"
  s.version      = "2.2.0"
  s.summary      = "tvOS SDK for the ColorTV Marketing Platform"

  s.description  = <<-DESC
  ColorTV is the first dedicated Connected TV marketing platform. We're committed to delivering the deepest user insights to developers.

  We provide a diverse set of ad units and analytics to help you get the most out of every user, and to get your app discovered. Gain insights into how users are engaging with your application. Stop leaving money on the table and start monetizing today.
                   DESC

  s.homepage     = "http://colortv.com"

  s.license      = { :type => "BSD", :file => "LICENSE" }

  s.author             = "ColorTV"
  s.social_media_url   = "https://twitter.com/thecolortv"

  s.module_name = "COLORAdFramework"
  s.platform     = :tvos, "9.0"

  s.source       = { :git => "https://github.com/color-tv/Color-tvOS-SDK.git", :tag => "#{s.version.to_s}" }

  s.vendored_frameworks = "ColorTV Framework/COLORAdFramework.framework"
  s.public_header_files = "ColorTV Framework/COLORAdFramework.framework/Headers/*.h"
  s.source_files = "ColorTV Framework/COLORAdFramework.framework/Headers/*.h"

  s.framework  = "AdSupport"

end
