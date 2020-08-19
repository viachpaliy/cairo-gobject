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
      LibCairo.region_destroy(@pointer.as(LibCairo::Region*))
    end

    # Allocates a new region object copying the area from this.
    # Returns : a newly allocated Cairo::Region.
    def dup : Region
      Region.new(LibCairo.region_copy(@pointer.as(LibCairo::Region*)))
    end

    # Increases the reference count on region by one.
    # Returns : the referenced Cairo::Region.
    def reference : Region
      Region.new(LibCairo.region_reference(@pointer.as(LibCairo::Region*)))
    end

    # Compares whether this region is equivalent to *other*.
    # nil as an argument is equal to itself, but not to any non-nil region.
    # *other* : a Cairo::Region
    # Returns : true if both regions contained the same coverage, false if it is not or any region is in an error status.  
    def ==(other : Region) : Bool
      LibCairo.region_equal(@pointer.as(LibCairo::Region*), other.to_unsafe) == 1
    end

    # Checks whether an error has previous occured for this region object.
    # Returns : Cairo::Status::SUCCESS or Cairo::STATUS::NO_MEMORY  
    def status : Status
      Status.new(LibCairo.region_status(@pointer.as(LibCairo::Region*)))
    end

    # Gets the bounding rectangle of region as a Cairo::`RectangleInt`.
    # Returns : a `RectangleInt` into which to store the extents. 
    def extents : RectangleInt
      LibCairo.region_get_extents(@pointer.as(LibCairo::Region*), out extents)
      RectangleInt.new(extents)
    end

    # Returns the number of rectangles contained in region. 
    def num_rectangles : Int32
      LibCairo.region_num_rectangles(@pointer.as(LibCairo::Region*))
    end

    # Stores the nth rectangle from the region in Cairo::RectangleInt.
    # *nth* : a number indicating which rectangle should be returned.
    # Returns : a `RectangleInt` into which to store the nth rectangle.
    def rectangle(nth : Int32) : RectangleInt
      LibCairo.region_get_rectangle(@pointer.as(LibCairo::Region*), nth, out rectangle)
      RectangleInt.new(rectangle)
    end

    # Checks whether region is empty.
    # Returns : true if region is empty, false if it isn't. 
    def empty? : Bool
      LibCairo.region_is_empty(@pointer.as(LibCairo::Region*)) == 1
    end

    # Checks whether rectangle is inside, outside or partially contained in region.
    # *rectangle* : a Cairo::RectangleInt.
    # Returns : Cairo::Region::IN if rectangle is entirely inside region,
    # Cairo::Region::OUT if rectangle is entirely outside region,
    # or Cairo::Region::PART if rectangle is partially inside and partially outside region. 
    def contains?(rectangle : RectangleInt) : RegionOverlap
      RegionOverlap.new(LibCairo.region_contains_rectangle(@pointer.as(LibCairo::Region*), rectangle.to_unsafe))
    end

    # Checks whether (x, y) is contained in region.
    # *x* : the x coordinate of a point
    # *y* : the y coordinate of a point
    # Returns : true if (x, y) is contained in region, false if it is not. 
    def contains?(x : Int32, y : Int32) : Bool
      LibCairo.region_contains_point(@pointer.as(LibCairo::Region*), x, y) == 1
    end

    # Translates region by (dx, dy).
    # *dx* : amount to translate in the x direction.
    # *dy* : amount to translate in the y direction.
    # Returns self.
    def translate(dx : Int32, dy : Int32)
      LibCairo.region_translate(@pointer.as(LibCairo::Region*), dx, dy)
      self
    end

    # Subtracts *other* from self and places the result in self.
    # *other* : another Cairo::Region.
    # Returns self. 
    def subtract(other : Region)
      status = Status.new(LibCairo.region_subtract(@pointer.as(LibCairo::Region*), other.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Subtracts *rectangle* from self and places the result in self.
    # *rectangle* : a Cairo::RectangleInt
    # Returns self.
    def subtract(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_subtract_rectangle(@pointer.as(LibCairo::Region*), rectangle.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the intersection of self with *other* and places the result in self.
    # *other* : another Cairo::Region.
    # Returns self.
    def intersect(other : Region)
      status = Status.new(LibCairo.region_intersect(@pointer.as(LibCairo::Region*), other.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the intersection of self with *rectangle* and places the result in self.
    # *rectangle* : a Cairo::RectangleInt
    # Returns self.
    def intersect(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_intersect_rectangle(@pointer.as(LibCairo::Region*), rectangle.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the union of self with *other* and places the result in self.
    # *other* : another Cairo::Region.
    # Returns self.
    def union(other : Region)
      status = Status.new(LibCairo.region_union(@pointer.as(LibCairo::Region*), other.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the union of self with *rectangle* and places the result in self.
    # *rectangle* : a Cairo::RectangleInt
    # Returns self.
    def union(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_union_rectangle(@pointer.as(LibCairo::Region*), rectangle.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the exclusive difference of self with *other* and places the result in self.
    # *other* : another Cairo::Region.
    # Returns self.
    def xor(other : Region)
      status = Status.new(LibCairo.region_xor(@pointer.as(LibCairo::Region*), other.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

    # Computes the exclusive difference of self with *rectangle* and places the result in self.
    # *rectangle* : a Cairo::RectangleInt
    # Returns self.
    def xor_rectangle(rectangle : RectangleInt)
      status = Status.new(LibCairo.region_xor_rectangle(@pointer.as(LibCairo::Region*), rectangle.to_unsafe))
      raise new StatusException.new(status) unless status.success?
      self
    end

  end
end

