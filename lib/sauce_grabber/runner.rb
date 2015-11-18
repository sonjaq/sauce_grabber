require 'sauce_grabber'

module SauceGrabber
  class Runner
    attr_accessor   :options, :browsers, :urls
    
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

    def capabilities_array(browser_csv)
      
    end

    def urls_array(urls_csv)
      
    end

    def go
      puts @options
      exit
    end

  end
end