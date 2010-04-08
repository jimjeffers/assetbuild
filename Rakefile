require 'rubygems'
require 'rake'

# Rakefile
begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name                      = "assetbuild"
    gemspec.summary                   = "Easily merge and compress multiple asset files together (currently supports CSS and coffee-script)."
    gemspec.homepage                  = "http://github.com/jimjeffers/assetbuild"
    gemspec.authors                   = ["Jim Jeffers"]
    gemspec.description               = "Easily merge and compress multiple asset files together (currently supports CSS and coffee-script)."
    gemspec.email                     = "shout@jimjeffers.com"
    gemspec.executables               = ["assetbuild", "buildcoffee", "buildcss"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }