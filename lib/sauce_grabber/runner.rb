require 'sauce_grabber'

module SauceGrabber
  class Runner
    attr_accessor   :options, :browsers, :urls, :current_browser
    
    def initialize
      opts = Slop.parse do |o|
        # require "pry";binding.pry # temporary debug statment
        o.string '-b', '--browsers-file', 'browser csv file' 
        o.string '-u', '--urls-file', 'csv file of urls' 
        o.bool '-v', '--verbose', 'enable verbose mode'
        o.on '--version', 'print the version' do
          puts SauceGrabber::VERSION
          exit
        end
      end
      @options  = opts
      @browsers = capabilities_array(opts[:browsers_file])
      @urls     = urls_array(opts[:urls_file])
      go
    end

    # Consider adding utility fields with chunk processing here
    def capabilities_array(browser_csv)
      capabilities = SmarterCSV.process(browser_csv)
      capabilities.map do |caps|
        CapabiltiesFactory.new(caps)
      end
    end

    def urls_array(urls_csv)
      SmarterCSV.process(urls_csv)
    end

    def go
      puts @options
      exit
    end

  end
end