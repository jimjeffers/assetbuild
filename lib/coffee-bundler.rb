require "rubygems"
require "yui/compressor"

class CoffeeBundler
  def initialize(*args)
    @@yui = YUI::JavaScriptCompressor.new
    @files = {}
    @processed_js = []
    append(*args)
  end
  
  def append(*args)
    unless args.nil? || args.length < 1
      if args.length == 1 
        args = args[0] if args.class == Array
        args = [args] if args.class == String
      end
      for path in args
        if File.directory?(path)
          for inner_path in Dir.glob(File.join(path,'*.coffee')).to_a
            process_path(inner_path)
          end
        else
          process_path(path)
        end
      end
    end
  end
  
  def to_javascript
    @files.sort{|a,b| a[1][:position]<=>b[1][:position]}.map{ |path,values| values[:contents] }.join("")
  end
  
  def compressed
    @@yui.compress(to_javascript)
  end
  
  protected
  def compile(path)
    %x(coffee -p #{path})
  end
  
  def process_path(path)
    unless @files.keys.include?(path)
      @files[path] = {
        :name       => File.basename(path), 
        :directory  => File.dirname(path), 
        :contents   => compile(path), 
        :position   => @files.length 
      }
    end
  end
end