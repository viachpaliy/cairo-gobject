require "gobject/gtk"
require "../src/cairo"

require "spec"

describe Cairo::TextExtents do
  context "test initialize" do
    it "when initialize with args" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.should be_a(Cairo::TextExtents)
      f.x_bearing.should eq(1.0) 
      f.y_bearing.should eq(2.0)
      f.width.should eq(3.0)
      f.height.should eq(4.0)
      f.x_advance.should eq(5.0)
      f.y_advance.should eq(6.0)
    end
  end

  context "test methods" do
    it "sets x_bearing value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.x_bearing = 7.0
      f.x_bearing.should eq(7.0) 
    end
    it "sets y_bearing value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.y_bearing = 8.0
      f.y_bearing.should eq(8.0) 
    end
    it "sets width value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.width = 9.0
      f.width.should eq(9.0) 
    end
    it "sets height value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.height = 18.0
      f.height.should eq(18.0) 
    end
    it "sets x_advance value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.x_advance = 19.0
      f.x_advance.should eq(19.0) 
    end
    it "sets y_advance value" do
      f = Cairo::TextExtents.new 1.0, 2.0, 3.0, 4.0, 5.0, 6.0
      f.y_advance = 91.0
      f.y_advance.should eq(91.0) 
    end

  end

end
