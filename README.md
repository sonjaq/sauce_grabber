# Welcome to SauceGrabber.

### Installation

1. Copy or clone this repo to a destination on your working machine.
2. Ensure the SAUCE_USERNAME and SAUCE_ACCESSKEY variables are populated in your Environment
3. In a terminal, change to the repo directory and type `bundle install`
4. Prepare a `browsers.csv` and a `urls.csv` file
5. (optional) Start the sauce connect tunnel executable
6. See Usage

### Usage

Usage is simple:

    $ bin/sauce_grabber 

SauceGrabber will look for a `browsers.csv` and `urls.csv` file in the current working directory. Assuming those exist, your Sauce sessions will be initiated.

Screenshots will be output to 'screenshots' by default. Screenshots are sorted by platform/browser/browser_version/.

### Advanced Usage

	$ bin/sauce_grabber -b my_browsers_file.csv -u my_urls_file.csv -o output_dir -t

`-b` specifies a browsers csv
`-u` specifies a urls csv
`-o` specifies a custom output directory
`-t` tunnel using an already established sauce connect tunnel

 ### Requirements:
 - Ruby 2.0
 - Bundler Installed

## CSV Notes

Best results are had when CSVs are prepared in Google Sheets or another spreadsheet product, and then exported.

### URLs CSV format

Headers: template,url

### Browsers CSV format

Required Headers: `browser_name`,`operating_system`*,`platform`*,`version`

* Some configurations use `platform` for configuration. Trust the Sauce Labs Platform Configurator [1] as your guide.

Sauce Labs _should_ provide the current stable browser when no version is specified. Experiment at your own risk.

Optional fields:

Any key/value pair that is specified as part of the Sauce Labs Platform Configurator[1] is acceptable. The Python code snippet is my preferred guide for parameter settings.

Some optional field/value examples:
- `screenResolution` => 1024x768
- `recordVideo` => false
- `recordScreenshots` => false (Sauce Screenshots, separate from the shots from this app)

[1] https://wiki.saucelabs.com/display/DOCS/Platform+Configurator#/

### Questions?

Ping me. avleaf@gmail.com