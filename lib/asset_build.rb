require 'asset_build/coffee_bundler'
require 'asset_build/css_reader'

class AssetBuild
  attr_accessor :manifest
  
  def initialize(path)
    @manifest = YAML::load(File.open(path).readlines.join(""))
    @path = File.dirname(path)
  end
  
  def process_files!
    @manifest.each do |destination,options|
      compressed = options["compress"] || false
      if options["type"] == "coffeescript"
        coffee_bundler = CoffeeBundler.new(File.join(@path,options["source"]))
        coffee_bundler.save(File.join(@path,destination),:compress => compressed)
        puts File.join(@path,destination)
      elsif options["type"] == "stylesheet"
        css_reader = CSSReader.new(File.join(@path,options["source"]))
        css_reader.save(File.join(@path,destination),:compress => compressed)
        puts File.join(@path,destination)
      end
    end
  end
end