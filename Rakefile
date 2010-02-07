require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('css-reader', '0.1.0') do |p|
  p.description    = "Easily merge and compress multiple CSS files together."
  p.url            = "http://github.com/jimjeffers/CSS-Reader"
  p.author         = "Jim Jeffers"
  p.email          = "shout@jimjeffers.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }