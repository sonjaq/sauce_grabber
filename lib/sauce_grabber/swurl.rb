module SauceGrabber
  class Swurl

    attr_accessor   :browser, :url, :anchors, :template

    def initialize(url, template = nil)
      @url = url
      @template = template
      @browser = Watir::Browser.new() # Grab this from a current browser list
    end

    def view
      browser.goto(url)
    rescue e
      require "pry";binding.pry # temporary debug statment
    end

    def shot
      Shooter.screenshot(browser)
      Shooter.footer_screenshot(browser)
    rescue e
      require "pry";binding.pry # temporary debug statment
    end

  end
end
