#
#  Be sure to run `pod spec lint SwiftyAPIRequest.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SwiftyAPIRequest"
  s.version      = "0.1.0"
  s.summary      = "Swifty Typed API Request Library."
  s.homepage     = "https://github.com/moaible/SwiftyAPIRequest.git"
  s.license = {
    :type => "MIT",
    :text => <<-LICENSE
      Copyright (c) 2015 - 2016 Yosuke Ishikawa
      Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
      The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
      THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    LICENSE
  }
  s.author             = { "moaible" => "motodera@moapp.info" }
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.10"
  s.source       = {
    :git => "http://moaible/SwiftyAPIRequest.git",
    :tag => "#{s.version}"
  }
  s.source_files  = "Sources/**/*.{swift,h,m}"
  s.dependency "Result", "~> 3.0"

end
