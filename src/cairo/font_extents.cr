module Cairo

  # The FontExtents class stores metric information for a font. 
  # Values are given in the current user-space coordinate system. 
  # This is a wrapper for LibCairo::FontExtents structure.
  class FontExtents
    include GObject::WrappedType
    
    @pointer : Void*

    def initialize(pointer : LibCairo::FontExtents*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::FontExtents*)
    end   

    #  Returns a new FontExtents
    # *ascent*  : the distance that the font extends above the baseline. 
    # *descent* : the distance that the font extends below the baseline.
    # *height*  : the recommended vertical distance between baselines when setting consecutive lines of text with the font. 
    # *max_x_advance* : the maximum distance in the X direction that the the origin is advanced for any glyph in the font. 
    # *max_y_advance* : the maximum distance in the Y direction that the the origin is advanced for any glyph in the font. 
    # *max_y_advance* will be zero for normal fonts used for horizontal writing. (The scripts of East Asia are sometimes written vertically.) 
    def self.new(ascent : Float64|Nil = nil, descent : Float64|Nil = nil, height : Float64|Nil = nil,
		 max_x_advance : Float64|Nil = nil, max_y_advance : Float64|Nil = nil) : self 
      ptr = Pointer(UInt8).malloc(40, 0u8)
      new(ptr.as(LibCairo::FontExtents*)).tap do |object|
        object.ascent = ascent unless ascent.nil?
        object.descent = descent unless descent.nil?
        object.height = height unless height.nil?
        object.max_x_advance = max_x_advance unless max_x_advance.nil?
        object.max_y_advance = max_y_advance unless max_y_advance.nil?
      end
    end

    # Returns the distance that the font extends above the baseline.
    def ascent
      (to_unsafe.as(LibCairo::FontExtents*).value.ascent)
    end 

    # Sets the distance that the font extends above the baseline.
    # *value* : a new value.
    def ascent=(value : Float64)
      to_unsafe.as(LibCairo::FontExtents*).value.ascent = Float64.new(value)
    end

    # Returns the distance that the font extends below the baseline.
    def descent
      (to_unsafe.as(LibCairo::FontExtents*).value.descent)
    end 

    # Sets the distance that the font extends below the baseline.
    # *value* : a new value.
    def descent=(value : Float64)
      to_unsafe.as(LibCairo::FontExtents*).value.descent = Float64.new(value)
    end

    # Returns the recommended vertical distance between baselines when setting consecutive lines of text with the font. 
    def height
      (to_unsafe.as(LibCairo::FontExtents*).value.height)
    end

    # Sets the recommended vertical distance between baselines when setting consecutive lines of text with the font.
    # *value* : a new value. 
    def height=(value : Float64)
      to_unsafe.as(LibCairo::FontExtents*).value.height = Float64.new(value)
    end

    # Returns the maximum distance in the X direction that the the origin is advanced for any glyph in the font.
    def max_x_advance
      (to_unsafe.as(LibCairo::FontExtents*).value.max_x_advance)
    end

    # Sets the maximum distance in the X direction that the the origin is advanced for any glyph in the font.
    # *value* : a new value.
    def max_x_advance=(value : Float64)
      to_unsafe.as(LibCairo::FontExtents*).value.max_x_advance = Float64.new(value)
    end

    # Returns the maximum distance in the Y direction that the the origin is advanced for any glyph in the font.
    def max_y_advance
      (to_unsafe.as(LibCairo::FontExtents*).value.max_y_advance)
    end

    # Sets the maximum distance in the Y direction that the the origin is advanced for any glyph in the font.
    # *value* : a new value.
    def max_y_advance=(value : Float64)
      to_unsafe.as(LibCairo::FontExtents*).value.max_y_advance = Float64.new(value)
    end

  end

end
