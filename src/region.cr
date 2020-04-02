module Cairo

  # Regions are a simple graphical data type representing an area of integer-aligned rectangles.
  # They are often used on raster surfaces to track areas of interest, such as change or clip areas. 
  class Region
 
    def initialize
      @pointer = LibCairo.region_create
    end

    # Creates a new Rectangle containing *rectangle*.
    # *rectangle* : a Cairo::`RectangleInt`.
    # Returns : a newly allocated Cairo::Region.
    def initialize(rectangle : RectangleInt)
      @pointer = LibCairo.region_create_rectangle(rectangle.to_unsafe.as(LibCairo::RectangleInt*))
    end

    def finalize
      LibCairo.region_destroy(@pointer)
    end

    # Allocates a new region object copying the area from this.
    # Returns : a newly allocated Cairo::Region.
    def dup : Region
      Region.new(LibCairo.region_copy(@pointer))
    end

    # Increases the reference count on region by one.
    # Returns : the referenced Cairo::Region.
    def reference : Region
      Region.new(LibCairo.region_reference(@pointer))
    end

    # Compares whether this region is equivalent to *other*.
    # nil as an argument is equal to itself, but not to any non-nil region.
    # *other* : a Cairo::Region
    # Returns : true if both regions contained the same coverage, false if it is not or any region is in an error status.  
    def ==(other : Region) : Bool
      LibCairo.region_equal(@pointer, other.to_unsafe) == 1
    end

    # Checks whether an error has previous occured for this region object.
    # Returns : Cairo::Status::SUCCESS or Cairo::STATUS::NO_MEMORY  
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

