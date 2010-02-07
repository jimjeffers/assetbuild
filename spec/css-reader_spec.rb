require File.expand_path(File.join(File.dirname(__FILE__),'..','lib','css-reader'))

describe CSSReader do
  it "should be defined" do
    defined?(CSSReader).nil?.should be(false)
  end
  
  describe "stylesheets" do
    before(:all) do
      @test_path = File.expand_path(File.join(File.dirname(__FILE__),'..','demo','test.css'))
      @secondary_path = File.expand_path(File.join(File.dirname(__FILE__),'..','demo','secondary.css'))
      @css_reader = CSSReader.new(@test_path)
    end
    
    it "should include test.css" do
      @css_reader.stylesheets.include?("test.css").should be(true)
    end
    
    it "should include reset.css" do
      @css_reader.stylesheets.include?("reset.css").should be(true)
    end
    
    it "should include typography.css" do
      @css_reader.stylesheets.include?("typography.css").should be(true)
    end
    
    it "should include basic_stuff.css" do
      @css_reader.stylesheets.include?("basic_stuff.css").should be(true)
    end
    
    it "should include basic_stuff.css" do
      @css_reader.stylesheets.include?("more_stuff.css").should be(true)
    end
    
    it "should not include secondary.css" do
      @css_reader.stylesheets.include?("secondary.css").should be(false)
    end
    
    it "should include secondary.css if we append it" do
      @css_reader.append(@secondary_path)
      @css_reader.stylesheets.include?("secondary.css").should be(true)
    end
    
    it "should include secondary.css if we open multiple docs on initialize" do
      @css_reader = CSSReader.new(@test_path,@secondary_path)
      @css_reader.stylesheets.include?("secondary.css").should be(true)
    end
    
    describe "normal" do
      before(:all) do
        @css_text = @css_reader.normal
      end
      
      it "should have '\#basic' before '\#more'" do
        (@css_text.index("\#basic") < @css_text.index("\#more")).should be(true)
      end
      
      it "should 'body' before '\#basic'" do
        (@css_text.index("body") < @css_text.index("\#basic")).should be(true)
      end
      
      it "should 'border: 0;' before 'body'" do
        (@css_text.index("border: 0;") < @css_text.index("body")).should be(true)
      end
      
      it "should have '\#basic' before '\#primary_content'" do
        (@css_text.index("\#basic") < @css_text.index("\#primary_content")).should be(true)
      end
      
      it "should not contain and @import statements" do
        @css_text.match(/@import./).should be(nil)
      end
      
      it "should have new lines" do
        @css_text.match(/\n/).nil?.should be(false)
      end
      
      it "should have comments" do
        @css_text.match(/\/\*.*/).nil?.should be(false)
      end
    end
    
    describe "compressed" do
      before(:all) do
        @css_text = @css_reader.compressed
      end
      
      it "should not have any new lines" do
        @css_text.match(/\n/).should be(nil)
      end
      
      it "should not have any comments" do
        @css_text.match(/\/\*.*/).should be(nil)
      end
    end
    
    describe "save" do
      before(:all) do
        @css_reader.save((@normal = "normal.css"))
        @css_reader.save((@compressed = "compressed.css"), :compress => true)
      end
      
      it "should create a new file with the name 'normal.css'" do
        File.exists?(@normal).should be(true)
      end
      
      it "should create a new file with the name 'compressed.css'" do
        File.exists?(@compressed).should be(true)
      end
      
      describe "compressed file" do
        before(:all) do
          @css_text = File.open(@compressed,"r").readlines.join("\n")
        end
        it "should not have any new lines" do
          @css_text.match(/\n/).should be(nil)
        end

        it "should not have any comments" do
          @css_text.match(/\/\*.*/).should be(nil)
        end
      end
      
      describe "normal file" do
        before(:all) do
          @css_text = File.open(@normal,"r").readlines.join("\n")
        end
        it "should have new lines" do
          @css_text.match(/\n/).nil?.should be(false)
        end

        it "should have comments" do
          @css_text.match(/\/\*.*/).nil?.should be(false)
        end
      end
    end
  end
end