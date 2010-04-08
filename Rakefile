require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('assetbuild', '0.1.0') do |p|
  p.description    = "Easily merge and compress multiple asset files together (currently supports CSS and coffee-script)."
  p.url            = "http://github.com/jimjeffers/CSS-Reader"
  p.author         = "Jim Jeffers"
  p.email          = "shout@jimjeffers.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.runtime_dependencies = ["yui-compressor"]
  p.development_dependencies = []
  p.bin_files = ["bin/*"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }