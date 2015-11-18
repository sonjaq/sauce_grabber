module SauceGrabber
  class Shooter
    class << self

      

      def scroll_to_bottom
        script = %q{window.scrollTo(0,document.body.scrollHeight);}
        browser.execute_script(script)
      end
   





    end
# Need to path saving logic here\
#   Logic from WatirSauce
#       browser_id = browser_label.gsub(/(\s+|\.)/,"-")
#       file = File.join(
#         screenshot_dir, 
#         "#{trimmed_path(true)}---#{browser_id}.png"
#         )
#       if File.exists?(file)
#         dupe_number = 0
#         while File.exists?(file) do
#           dupe_number += 1
#           file = File.join(
#             screenshot_dir, 
#             "#{trimmed_path(true)}---#{browser_id}-#{dupe_number}.png"
#             )
#         end
#       end

# file
# 
# 

    # This logic probably needs love
    # 
    # 
    def trimmed_path(safe=false)
      path = browser.browser.url.match(live_domain).post_match
      
      path = "home" if path == "/"
      (safe == false) ? path : path = path.gsub(/(\/|\.)/, "--").gsub(/(^-+|-+$)/, "")
    end


    def path
      
    end

    def screenshot_directory

    end

    def screenshot_directory?(path)
      File.exists(path)
    end
  end
end