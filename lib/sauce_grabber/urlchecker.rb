module SauceGrabber
  class UrlChecker
    class << self

      def check(browser)
        @browser = browser
        shots = []
        begin
            shots = checkurls

        rescue Selenium::WebDriver::Error::UnsupportedOperationError => e
          # This gets past an issue with JS unsupported errors
        end
        return shots
      end

      def checkurls()
        script = %q{var list, images = [], index;
      list = document.querySelectorAll('img');
      for (index = 0; index < list.length; ++index) {
          if (list[index].naturalWidth == "undefined" || list[index].naturalWidth == 0) {
            images.push(list[index]);
          }
      }
      return images}
        @browser.execute_script(script)
      end

    end

  end
end