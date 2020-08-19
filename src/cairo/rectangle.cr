module Cairo

  # A class for holding a rectangle. 
  # This is a wrapper for LibCairo::Rectangle structure.
  class Rectangle
    include GObject::WrappedType

    # Returns a new Rectangle.
    # *x* : X coordinate of the left side of the rectangle.
    # *y* : Y coordinate of the the top side of the rectangle.
    # *width* : the width of the rectangle.
    # *height* : the height of the rectangle.
    def self.new(x : Float64|Nil = nil, y : Float64|Nil = nil, width : Float64|Nil = nil, height : Float64|Nil = nil) : self
      ptr = Pointer(UInt8).malloc(32, 0u8)
      new(ptr.as(LibCairo::Rectangle*)).tap do |object|
        object.x = x unless x.nil?
        object.y = y unless y.nil?
        object.width = width unless width.nil?
        object.height = height unless height.nil?
      end
    end

    @pointer : Void*

    def initialize(pointer : LibCairo::Rectangle*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::Rectangle*)
    end

    # Returns the X coordinate of the left side of the rectangle. 
    def x 
      (to_unsafe.as(LibCairo::Rectangle*).value.x)
    end

    # Sets the X coordinate of the left side of the rectangle.
    # *value* : a new value. 
    def x=(value : Float64)
      to_unsafe.as(LibCairo::Rectangle*).value.x = Float64.new(value)
    end

    # Returns the Y coordinate of the the top side of the rectangle. 
    def y
      (to_unsafe.as(LibCairo::Rectangle*).value.y)
    end

    # Sets the Y coordinate of the the top side of the rectangle.
    # *value* : a new value.
    def y=(value : Float64)
      to_unsafe.as(LibCairo::Rectangle*).value.y = Float64.new(value)
    end

    # Returns the width of the rectangle. 
    def width
      (to_unsafe.as(LibCairo::Rectangle*).value.width)
    end

    # Sets the width of the rectangle.
    # *value* : a new value.
    def width=(value : Float64)
      to_unsafe.as(LibCairo::Rectangle*).value.width = Float64.new(value)
    end

    # Returns the height of the rectangle.
    def height
      (to_unsafe.as(LibCairo::Rectangle*).value.height)
    end

    # Sets the height of the rectangle.
     # *value* : a new value.
    def height=(value : Float64)
      to_unsafe.as(LibCairo::Rectangle*).value.height = Float64.new(value)
    end

  end

end
