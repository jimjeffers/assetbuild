require File.expand_path(File.join(File.dirname(__FILE__),'..','lib','asset_build'))

describe AssetBuild do
  it "should be defined" do
    defined?(AssetBuild).nil?.should be(false)
  end
  
  before(:all) do
    @manifest_path = File.expand_path(File.join(File.dirname(__FILE__),'..','demo','assetbuild.yml'))
    @asset_build = AssetBuild.new(@manifest_path)
  end
  
  describe "initialize" do
    it "should know where to put destination files" do
      @asset_build.process_files!
    end
  end
end