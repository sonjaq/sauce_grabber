module SauceGrabber
  class CapabilitiesFactory

    attr_reader   :capabilities, :browser_label

    def initialize(req_browser, tunnel)
      @capabilities =  build_browser(req_browser)
      add_sc_info(@capabilities) if tunnel
      return @capabilities
    rescue => _
      return ""
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
        next if key == caps[:browser_name]
        caps[key] = value.to_s
      end
      add_sc_info(caps)
      caps
    end

    def add_sc_info(caps)
      caps["parentTunnel"] = ENV['SAUCE_USERNAME']
    end

  end
end