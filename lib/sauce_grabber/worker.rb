module SauceGrabber
  class Worker

    attr_reader :browser, :browser_label, :live_domain, :registered_actions,
                :screenshot_dir

    def initialize(browser)
      @registered_actions = SauceGrabber::Config.registered_actions || nil
      @browser            = browser
      @live_domain        = SauceGrabber::Config.live_domain
      @full_paths         = SauceGrabber::Config.pages
      @screenshot_dir     = SauceGrabber::Config.live_domain
    end

    def init_browser
      @browser.start_browser
    rescue Selenium::WebDriver::Error::WebDriverError
      SauceGrabber.logger.error "#{browser_label} is not a valid browser config."
      nil
    end

    def work
      actor = init_browser
      return unless actor

      begin
        @full_paths.each do |path| 
          @browser.browser.goto path
          capture_screen
          SauceGrabber.logger.info "#{browser_label} - #{browser.url}" # test code
        end
      rescue => e
        SauceGrabber.logger.error "Something went wrong with #{browser_label}."
        SauceGrabber.logger.error e.backtrace.join("\n")
      ensure
        @browser.destroy_browser
      end
    rescue ::Net::ReadTimeout => _
      SauceGrabber.logger.error "#{browser_label} timed out."
    end

    private
    
    def capture_screen
      SauceGrabber::Shooter.new(@browser)
    rescue Selenium::WebDriver::Error::UnknownError
      SauceGrabber.logger.warn "Configuration for #{browser_label} Screenshot Failed"
    end

  end
end
