module SauceGrabber
  class Shooter
    class << self

      def shoot(browser)
        @browser = browser
        shots = []
        shots << browser.screenshot.png
        begin
          unless browser.name == ( :firefox  )
            scroll_to_bottom
            shots << browser.screenshot.png
          end
        rescue Selenium::WebDriver::Error::UnsupportedOperationError => e
          # This gets past an issue with JS unsupported errors
        end
        return shots
      end    

      def scroll_to_bottom
        script = %q{window.scrollTo(0,document.body.scrollHeight);}
        @browser.execute_script(script)
      end
  
    end

  end
end