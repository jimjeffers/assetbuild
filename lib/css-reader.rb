require "rubygems"
require "yui/compressor"

class CSSReader
  def initialize(*args)
    @@yui = YUI::CssCompressor.new
    @files = {}
    @processed_css = []
    append(*args)
  end
  
  def append(*args)
    unless args.nil? || args.length < 1
      if args.length == 1 
        args = args[0] if args.class == Array
        args = [args] if args.class == String
      end
      for path in args
        file = File.open(path)
        unless @files.keys.include?(path)
          process_imports( @files[path] = {
                            :name       => File.basename(path), 
                            :directory  => File.dirname(path), 
                            :contents   => file.readlines, 
                            :position   => @files.length } )
        end
      end
    end
  end
  
  def stylesheets
    @files.map { |path,values| values[:name] }
  end
  
  def normal
    @processed_css.join("")
  end
  
  def compressed
    @@yui.compress(normal)
  end
  
  def save(name,options={})
    compress = options[:compress] || false
    File.open(name,'w') {|f| f.write compress ? compressed : normal }
  end
  
  protected
  def process_imports(file)
    file[:contents].each do |line|
      if line =~ /@import.*;/
        file_name = eval(line.match(/".*?"/)[0])
        file_path = [file[:directory],file_name].join("/")
        append(file_path)
      else
        @processed_css << line
      end
    end
  end
end