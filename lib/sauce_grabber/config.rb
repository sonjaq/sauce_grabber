  
module SauceGrabber
  class Config

    SAUCE_BASE_URL = "ondemand.saucelabs.com:80/wd/hub"
    
    class << self

      def load_config(file)
        @config = YAML.load_file(file)
        register_actions     
      end

      def config
        @config
      end

      def credentials
        [username, access_key]
      end

      def username
        config["username"] ||= ENV["SAUCE_USERNAME"]
      end

      def access_key
        config["access_key"] ||= ENV["SAUCE_ACCESS_KEY"]
      end

      def live_domain
        config["live_site"]
      end

      def paths
        config["pages"]
      end

      def actions
        config["actions"] ||= []
      end

      def vm_limit
        limit = config["vm_limit"] || 1
        limit.to_i
      end

      def screenshot_dir
        live_domain
      end

      def browsers
        config["browsers"]
      end

      def pages
        protocol = https? ? "https://" : "http://"
        @full_paths ||= paths.map { |path| protocol + live_domain + path }
      end

      def target
        config["target_url"] ||= "http://#{username}:#{access_key}@#{SAUCE_BASE_URL}"
      end

    end
  end
end
