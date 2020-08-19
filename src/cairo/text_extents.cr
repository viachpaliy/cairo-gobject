module Cairo

  # The Cairo::TextExtents class stores the extents of a single glyph or a string of glyphs in user-space coordinates.
  # Because text extents are in user-space coordinates, they are mostly, but not entirely, independent of the current transformation matrix.
  # If you call `Context#scale`(cr, 2.0, 2.0), text will be drawn twice as big, but the reported text extents will not be doubled.
  # They will change slightly due to hinting (so you can't assume that metrics are independent of the transformation matrix), but otherwise will remain unchanged. 
  class TextExtents
    include GObject::WrappedType
    
    @pointer : Void*

    def initialize(pointer : LibCairo::TextExtents*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::TextExtents*)
    end   

    # Returns a new TextExtents
    # *x_bearing* : the horizontal distance from the origin to the leftmost part of the glyphs as drawn. 
    #               Positive if the glyphs lie entirely to the right of the origin. 
    # *y_bearing* : the vertical distance from the origin to the topmost part of the glyphs as drawn.
    #                Positive only if the glyphs lie completely below the origin; will usually be negative. 
    # *width*     : width of the glyphs as drawn. 
    # *height*    : height of the glyphs as drawn.
    # *x_advance* : distance to advance in the X direction after drawing these glyphs.  
    # *y_advance* : distance to advance in the Y direction after drawing these glyphs. 
    #               Will typically be zero except for vertical text layout as found in East-Asian languages. 
    def self.new(x_bearing : Float64|Nil = nil, y_bearing : Float64|Nil = nil, width : Float64|Nil = nil,
                 height : Float64|Nil = nil, x_advance : Float64|Nil = nil, y_advance : Float64|Nil = nil) : self 
      ptr = Pointer(UInt8).malloc(48, 0u8)
      new(ptr.as(LibCairo::TextExtents*)).tap do |object|
        object.x_bearing = x_bearing unless x_bearing.nil?
        object.y_bearing = y_bearing unless y_bearing.nil?
        object.width = width unless width.nil?
        object.height = height unless height.nil?
        object.x_advance = x_advance unless x_advance.nil?
        object.y_advance = y_advance unless y_advance.nil?
      end
    end

    # Returns the horizontal distance from the origin to the leftmost part of the glyphs as drawn.
    def x_bearing
      to_unsafe.as(LibCairo::TextExtents*).value.x_bearing
    end

    # Sets the horizontal distance from the origin to the leftmost part of the glyphs as drawn.
    # *value* : a new value. 
    def x_bearing=(value : Float64)
      to_unsafe.as(LibCairo::TextExtents*).value.x_bearing = Float64.new(value)
    end

    # Returns the vertical distance from the origin to the topmost part of the glyphs as drawn.
    def y_bearing
      to_unsafe.as(LibCairo::TextExtents*).value.y_bearing
    end

    # Sets the vertical distance from the origin to the topmost part of the glyphs as drawn.
    # *value* : a new value. 
    def y_bearing=(value : Float64)
      to_unsafe.as(LibCairo::TextExtents*).value.y_bearing = Float64.new(value)
    end

    # Returns the width of the glyphs as drawn. 
    def width
      to_unsafe.as(LibCairo::TextExtents*).value.width
    end 

    # Sets the width of the glyphs as drawn. 
    # *value* : a new value.
    def width=(value : Float64)
      to_unsafe.as(LibCairo::TextExtents*).value.width = Float64.new(value)
    end 

    # Returns height of the glyphs as drawn.
    def height
      to_unsafe.as(LibCairo::TextExtents*).value.height
    end

    # Sets height of the glyphs as drawn.
    # *value* : a new value.
    def height=(value : Float64)
      to_unsafe.as(LibCairo::TextExtents*).value.height = Float64.new(value)
    end

    # Returns the distance to advance in the X direction after drawing these glyphs.
    def x_advance    
      to_unsafe.as(LibCairo::TextExtents*).value.x_advance
    end

    # Sets the distance to advance in the X direction after drawing these glyphs.
    # *value* : a new value.
    def x_advance=(value : Float64)   
      to_unsafe.as(LibCairo::TextExtents*).value.x_advance = Float64.new(value)
    end

    # Returns the distance to advance in the Y direction after drawing these glyphs.
    def y_advance    
      to_unsafe.as(LibCairo::TextExtents*).value.y_advance
    end

    # Sets the distance to advance in the Y direction after drawing these glyphs.
    # *value* : a new value.
    def y_advance=(value : Float64)   
      to_unsafe.as(LibCairo::TextExtents*).value.y_advance = Float64.new(value)
    end

  end
  
end
