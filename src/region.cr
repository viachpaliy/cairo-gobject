module Cairo
  class Region
    include GObject::WrappedType

    @pointer : Void*
    def initialize(pointer : LibCairo::Region*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::Region*)
    end

    def initialize
      @pointer = LibCairo.region_create
    end

    # Create Rectangle
    def initialize(rectangle : RectangleInt)
      @pointer = LibCairo.region_create_rectangle(rectangle.to_unsafe.as(LibCairo::RectangleInt*))
    end

    def finalize
      LibCairo.region_destroy(@pointer)
    end

    def dup : Region
      Region.new(LibCairo.region_copy(@pointer))
    end

    def reference : Region
      Region.new(LibCairo.region_reference(@pointer))
    end

    def ==(other : Region) : Bool
      LibCairo.region_equal(@pointer, other.to_unsafe) == 1
    end

    def status : Status
      Status.new(LibCairo.region_status(@pointer).value)
    end

    def extents : RectangleInt
      LibCairo.region_get_extents(@pointer, out extents)
      RectangleInt.new(extents)
    end

    def num_rectangles : Int32
      LibCairo.region_num_rectangles(@pointer)
    end

    def rectangle(nth : Int32) : RectangleInt
      LibCairo.region_get_rectangle(@pointer, nth, out rectangle)
      RectangleInt.new(rectangle)
    end

    def empty? : Bool
      LibCairo.region_is_empty(@pointer) == 1
    end

    def contains?(rectangle : RectangleInt) : RegionOverlap
      RegionOverlap.new(LibCairo.region_contains_rectangle(@pointer, rectangle.to_unsafe).value)
    end

    def contains?(x : Int32, y : Int32) : Bool
      LibCairo.region_contains_point(@pointer, x, y) == 1
    end
      
    def translate(dx : Int32, dy : Int32)
      LibCairo.region_translate(@pointer, dx, dy)
      self
    end

    def subtract(other : Region)
      status = Status.new(LibCairo.region_subtract(@pointer, other.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def subtract(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_subtract_rectangle(@pointer, rectangle.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def intersect(other : Region)
      status = Status.new(LibCairo.region_intersect(@pointer, other.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def intersect(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_intersect_rectangle(@pointer, rectangle.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def union(other : Region)
      status = Status.new(LibCairo.region_union(@pointer, other.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def union(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_union_rectangle(@pointer, rectangle.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def xor(other : Region)
      status = Status.new(LibCairo.region_xor(@pointer, other.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end

    def xor_rectangle(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_xor_rectangle(@pointer, rectangle.to_unsafe).value)
      raise new StatusException.new(status) unless status.success?
      self
    end


  end
end

