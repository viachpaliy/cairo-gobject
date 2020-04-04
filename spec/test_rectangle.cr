require "gobject/gtk"
require "../src/cairo"

require "spec"

describe Cairo::Rectangle do
  context "test initialize" do
    it "when initialize with args" do
      r = Cairo::Rectangle.new 1.1, 2.2, 3.3, 4.4
      r.should be_a(Cairo::Rectangle)
      r.x.should eq(1.1)
      r.y.should eq(2.2)
      r.width.should eq(3.3)
      r.height.should eq(4.4)
    end
  end

  context "test methods" do
    it "sets x value" do
      r = Cairo::Rectangle.new 1.1, 2.2, 3.3, 4.4
      r.x = 7.2
      r.x.should eq(7.2)
    end
    it "sets y value" do
      r = Cairo::Rectangle.new 1.1, 2.2, 3.3, 4.4
      r.y = 8.2
      r.y.should eq(8.2)
    end
    it "sets width value" do
      r = Cairo::Rectangle.new 1.1, 2.2, 3.3, 4.4
      r.width = 9.2
      r.width.should eq(9.2)
    end
    it "sets height value" do
      r = Cairo::Rectangle.new 1.1, 2.2, 3.3, 4.4
      r.height = 19.2
      r.height.should eq(19.2)
    end
  end

end
