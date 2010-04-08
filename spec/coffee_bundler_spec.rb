require File.expand_path(File.join(File.dirname(__FILE__),'..','lib','asset_build'))

describe CoffeeBundler do
  it "should be defined" do
    defined?(CoffeeBundler).nil?.should be(false)
  end
  
  before(:all) do
    @bundle_path = File.expand_path(File.join(File.dirname(__FILE__),'..','demo','coffee_bundle'))
    @coffee_bundler = CoffeeBundler.new(@bundle_path)
  end
  
  describe "to_javascript" do
    it "should compile to javascript" do
      (@coffee_bundler.to_javascript.index("function()") > 0).should be(true)
    end
    
    it "should have 'cubed_list' before 'Animal'" do
      (@coffee_bundler.to_javascript.index("cubed_list") < @coffee_bundler.to_javascript.index("Animal")).should be(true)
    end
    
    it "should retain comments as javascript" do
      (@coffee_bundler.to_javascript.index("//") > 0).should be(true)
    end
    
    it "should be able to process a stand alone file" do
      @coffee_bundler = CoffeeBundler.new(File.expand_path(File.join(File.dirname(__FILE__),'..','demo','stand_alone.coffee')))
      (@coffee_bundler.to_javascript.index("var _a, _b, _c, city, futurists, poet, street;") > 0).should be(true)
    end
  end
  
  describe "compressed" do
    it "should not retain comments when compressed" do
      (@coffee_bundler.compressed.index("//").nil?).should be(true)
    end
  end
end