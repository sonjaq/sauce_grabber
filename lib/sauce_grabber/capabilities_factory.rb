module SauceGrabber
  class CapabilitiesFactory

    attr_reader   :capabilities, :browser_label

    def initialize(req_browser)
      @capabilities =  build_browser(req_browser)
      return @capabilities
    rescue => _
      return nil
    end

    def build_browser(req_hash)
      caps = case req_hash[:browser_name]
             when "Android"
               Selenium::WebDriver::Remote::Capabilities.android
             when "Appium"
               Selenium::WebDriver::Remote::Capabilities.android
             when "Chrome"
               Selenium::WebDriver::Remote::Capabilities.chrome
             when "Edge"
               Selenium::WebDriver::Remote::Capabilities.edge
             when "Firefox"
               Selenium::WebDriver::Remote::Capabilities.firefox
             when "Internet Explorer"
               Selenium::WebDriver::Remote::Capabilities.internet_explorer
             when "iPad"
               Selenium::WebDriver::Remote::Capabilities.ipad
             when "iPhone"
               Selenium::WebDriver::Remote::Capabilities.iphone
             when "Safari"
               Selenium::WebDriver::Remote::Capabilities.safari
             else e
               raise ArgumentError
             end

      req_hash.each_pair do |key, value|
        unless caps[:browser_name].downcase.match(value.to_s.downcase)
          caps[key] = value.to_s
        end
      end
      caps
    end
    
    def short_name(req_hash)
      # Bad idea - need to move this maybe to runner or shooter?
    end

  end
end