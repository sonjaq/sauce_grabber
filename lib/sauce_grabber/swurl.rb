module SauceGrabber
  class Swurl
    class << self

      def swurl(browser, urls)
        @current_browser = browser
        @browser = browser.start_browser
        @urls = urls

        urls.each do |u|
          @browser.goto(u[:url])
          sleep(1) # To accommodate slow page load
          shots = get_screenshots(@browser)
          shots.each_with_index { |s, i| 
            next if s == nil
            destination = url_to_path(u,i)
            while File.exists?(destination)
              i += 1
              destination = url_to_path(u,i)
            end
            File.open(destination, 'wb') { |f| f.write(s)} 
          }  
        end

      rescue => e
        # quiet in case this fails
      ensure
        @browser.quit
        return { browser: browser, urls: urls }
      end

      def url_to_path(url,index)
        target_dir = screenshot_dir
        ensure_screenshot_directory(target_dir)
        filename = prepare_filename(url, index)
        File.join(target_dir, filename)
      end

      def screenshot_dir
        File.join(
            output_dir,
            @current_browser.os,
            @current_browser.name,
            @current_browser.version
          )
      end

      def ensure_screenshot_directory(dir)
        unless File.exists?(dir)
          FileUtils.mkdir_p(dir)
        end
      end

      def prepare_filename(url,index)
        f = "#{url[:template]}-#{safe_filename(url[:url])}"
        if index > 0 
          f +=  "-#{index}"
        end
        f + ".png"
      end

      def output_dir=(arg)
        @output_dir = arg
      end

      def output_dir
        @output_dir
      end

      def safe_filename(url)
        path = URI.parse(url).path
        return "root" if path == ("" || "/")
        path.gsub(/(\/|\.)/, "-").chomp("-")
      end

      def get_screenshots(browser)
        # Returns [] of screenshots
        SauceGrabber::Shooter.shoot(browser)
      rescue => e
        return []
      end

    end
  end
end
