require "gobject/gtk"
require "../src/cairo"

require "spec"

describe Cairo::FontExtents do
  context "test initialize" do
    it "when initialize with args" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.should be_a(Cairo::FontExtents)
      f.ascent.should eq(1.0) 
      f.descent.should eq(2.0)
      f.height.should eq(3.0)
      f.max_x_advance.should eq(4.0)
      f.max_y_advance.should eq(5.0)
    end
  end

  context "test methods" do
    it "sets ascent value" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.ascent = 6.0
      f.ascent.should eq(6.0) 
    end
    it "sets descent value" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.descent = 7.0
      f.descent.should eq(7.0) 
    end
    it "sets height value" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.height = 8.0
      f.height.should eq(8.0) 
    end
    it "sets max_x_advance value" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.max_x_advance = 9.0
      f.max_x_advance.should eq(9.0) 
    end
    it "sets max_y_advance value" do
      f = Cairo::FontExtents.new 1.0, 2.0, 3.0, 4.0, 5.0
      f.max_y_advance = 9.0
      f.max_y_advance.should eq(9.0) 
    end

  end

end
