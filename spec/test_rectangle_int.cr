require "gobject/gtk"
require "../src/cairo"

require "spec"

describe Cairo::RectangleInt do
  context "test initialize" do
    it "when initialize with args" do
      r = Cairo::RectangleInt.new 1, 2, 3, 4
      r.should be_a(Cairo::RectangleInt)
      r.x.should eq(1)
      r.y.should eq(2)
      r.width.should eq(3)
      r.height.should eq(4)
    end
  end

  context "test methods" do
    it "sets x value" do
      r = Cairo::RectangleInt.new 1, 2, 3, 4
      r.x = 7
      r.x.should eq(7)
    end
    it "sets y value" do
      r = Cairo::RectangleInt.new 1, 2, 3, 4
      r.y = 8
      r.y.should eq(8)
    end
    it "sets width value" do
      r = Cairo::RectangleInt.new 1, 2, 3, 4
      r.width = 9
      r.width.should eq(9)
    end
    it "sets height value" do
      r = Cairo::RectangleInt.new 1, 2, 3, 4
      r.height = 6
      r.height.should eq(6)
    end
  end

end
