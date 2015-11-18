module SauceGrabber
  class Browser

    attr_reader :browser, :browser_label, :session_id

    def initialize(capabilities_factory)
      @caps          = capabilities_factory.capabilities
      @browser_label = capabilities_factory.browser_label
      @target        = SauceGrabber::Config.target 
      self
    end
    
    def start_browser
      @browser = Watir::Browser.new(
        :remote,
        :url => @target,
        :desired_capabilities => @caps
      )
    end

    def destroy_browser
      @browser.quit
    rescue => e
      SauceGrabber.logger.error "Something bad happened. \n#{e}"
    end

    def method_missing(meth, *args, &blk)
      @browser.send(meth, *args) if @browser.respond_to?(meth)
    end

    def screenshot_save(path)
      @browser.screenshot.save(path)
    end

  end
end
