module Cairo

  # A class for holding a rectangle with integer coordinates.
  # This is a wrapper for LibCairo::RectangleInt structure.
  class RectangleInt
    include GObject::WrappedType

    # Returns a new RectangleInt.
    # *x* : X coordinate of the left side of the rectangle.
    # *y* : Y coordinate of the the top side of the rectangle.
    # *width* : the width of the rectangle.
    # *height* : the height of the rectangle.
    def self.new(x : Int32|Nil = nil, y : Int32|Nil = nil, width : Int32|Nil = nil, height : Int32|Nil = nil) : self
      ptr = Pointer(UInt8).malloc(16, 0u8)
      new(ptr.as(LibCairo::RectangleInt*)).tap do |object|
        object.x = x unless x.nil?
        object.y = y unless y.nil?
        object.width = width unless width.nil?
        object.height = height unless height.nil?
      end
    end

    @pointer : Void*
    def initialize(pointer : LibCairo::RectangleInt*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::RectangleInt*)
    end

    # Returns the X coordinate of the left side of the rectangle. 
    def x
      (to_unsafe.as(LibCairo::RectangleInt*).value.x)
    end

    # Sets the X coordinate of the left side of the rectangle.
    # *value* : a new value. 
    def x=(value : Int32)
      to_unsafe.as(LibCairo::RectangleInt*).value.x = Int32.new(value)
    end

    # Returns the Y coordinate of the the top side of the rectangle. 
    def y
      (to_unsafe.as(LibCairo::RectangleInt*).value.y)
    end

    # Sets the Y coordinate of the the top side of the rectangle.
    # *value* : a new value.
    def y=(value : Int32)
      to_unsafe.as(LibCairo::RectangleInt*).value.y = Int32.new(value)
    end

    # Returns the width of the rectangle. 
    def width
      (to_unsafe.as(LibCairo::RectangleInt*).value.width)
    end

    # Sets the width of the rectangle.
    # *value* : a new value.
    def width=(value : Int32)
      to_unsafe.as(LibCairo::RectangleInt*).value.width = Int32.new(value)
    end

    # Returns the height of the rectangle.
    def height
      (to_unsafe.as(LibCairo::RectangleInt*).value.height)
    end

    # Sets the height of the rectangle.
     # *value* : a new value.
    def height=(value : Int32)
      to_unsafe.as(LibCairo::RectangleInt*).value.height = Int32.new(value)
    end

  end

end
