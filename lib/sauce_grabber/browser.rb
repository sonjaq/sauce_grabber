module SauceGrabber
  class Browser

    SAUCE_BASE_URL = "ondemand.saucelabs.com:80/wd/hub"

    attr_reader   :browser, :browser_label, :caps

    def initialize(capabilities)
      @caps = capabilities
      @caps[:name] = browser_label
    end

    def start_browser
      puts "Initiating #{browser_label}"
      return local_browser if local?
      @browser = Watir::Browser.new(
        :remote,
        :url => target,
        :desired_capabilities => @caps
      )
    rescue => e
      puts "#{browser_label} failed to start."
    end

    def local_browser
      @browser = Watir::Browser.new :chrome
    end

    def destroy_browser
      @browser.quit
    rescue => e
      SauceGrabber.logger.error "Something bad happened. \n#{e}"
    end

    def browser_label
      [name.capitalize, version, os].join(" ")
    end

    def name
      caps[:browser_name] || ""
    end

    def os
      return caps[:platform] if caps[:platform]
      caps[:operating_system]
    end

    def version
      caps[:version].to_s || ""
    end

    private

    def local?
      ENV["LOCAL"]
    end

    def target
      "http://#{username}:#{access_key}@#{SAUCE_BASE_URL}"
    end

    def username
      ENV["SAUCE_USERNAME"]
    end

    def access_key
      ENV["SAUCE_ACCESS_KEY"]
    end

  end
end
