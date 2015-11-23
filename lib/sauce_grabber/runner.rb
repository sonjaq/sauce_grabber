require 'sauce_grabber'

module SauceGrabber
  class Runner
    attr_accessor   :options, :browsers, :urls, :current_browser, 
                    :errors, :failed, :success
    
    def initialize
      opts = Slop.parse do |o|
        o.string '-b', '--browsers-file', 'browser csv file (default: browsers.csv)', default: "browsers.csv"
        o.string '-u', '--urls-file', 'csv file of urls (default: urls.csv)', default: "urls.csv"
        o.string '-o', '--output-dir', 'Output directory', default: "screenshots"
        o.on '--version', 'print the version' do
          puts "SauceGrabber #{SauceGrabber::VERSION}"
          exit
        end
        o.on '-h', '--help','Display this help' do
         puts o
         exit
        end
      end

      @errors  = Array.new
      @failed  = Array.new
      @success = Array.new

      @options  = opts
      @browsers = capabilities_array(opts[:browsers_file] )
      @urls     = urls_array(opts[:urls_file] )
      
      Swurl.output_dir = options[:output_dir]
      
      go
    end

    # Consider adding utility fields with chunk processing here
    def capabilities_array(browser_csv)
      unless File.exists?(browser_csv)
        puts "Please provide a browser csv file and try again."
        finish
      end
      capabilities = SmarterCSV.process(browser_csv,:convert_values_to_numeric => false)
      capabilities.map do |caps|
        SauceGrabber::CapabilitiesFactory.new(caps)
      end
      capabilities
    end

    def urls_array(urls_csv)
      unless File.exists?(urls_csv)
        puts "Please provide a URLs csv file and try again."
        finish
      end
      SmarterCSV.process(urls_csv) 
    end

    def go
      browse_capabilities
    rescue => e
      errors.push(e)
    ensure
      finish
    end

    def browse(caps)
      browser = Browser.new(caps)
      success.push(Swurl.swurl(browser, urls))
    rescue => e
      failed.push(caps)
      errors.push({ error: e, caps: caps })
    end

    def browse_capabilities
      @browsers.each_with_index do |caps, i|
        browse(caps)
      end
    end

    def finish
      puts "Screenshots are available in #{Swurl.output_dir}",
           "Thanks for using Sauce Grabber."
      # Exit
      exit
    end

  end
end