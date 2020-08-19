module Cairo

  # Cairo::Pattern is the paint with which cairo draws.
  # The primary use of patterns is as the source for all cairo drawing operations, although they can also be used as masks, that is, as the brush too. 
  class Pattern

    def finalize
      LibCairo.pattern_destroy(@pointer.as(LibCairo::Pattern*))
    end

    # Creates a new Cairo::Pattern corresponding to an opaque color.
    # The color components are floating point numbers in the range 0 to 1.
    # If the values passed in are outside that range, they will be clamped.
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # Returns :  the newly created Cairo::Pattern if successful, or an error pattern in case of no memory. 
    def self.create_rgb(red : Float64, green : Float64, blue : Float64)
      Pattern.new(LibCairo.pattern_create_rgb(red, green, blue))
    end

    # Creates a new cairo_pattern_t corresponding to a translucent color.
    # The color components are floating point numbers in the range 0 to 1.
    # If the values passed in are outside that range, they will be clamped.
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # *alpha* : alpha component of the color
    # Returns :  the newly created Cairo::Pattern if successful, or an error pattern in case of no memory.
    def self.create_rgba(red : Float64, green : Float64, blue : Float64, alpha : Float64)
      Pattern.new(LibCairo.pattern_create_rgb(red, green, blue, alpha))
    end

    # Creates a new Cairo::Pattern for the given surface.
    # *surface* :  the surface
    # Returns :  the newly created Cairo::Pattern if successful, or an error pattern in case of no memory.
    def self.create_for_surface(surface : Surface)
      Pattern.new(LibCairo.pattern_create_for_surface(surface.to_unsafe))
    end

    # Creates a new linear gradient cairo_pattern_t along the line defined by (x0, y0) and (x1, y1).
    # Before using the gradient pattern, a number of color stops should be defined using `Pattern#add_color_stop()`. 
    # Note: The coordinates here are in pattern space. For a new pattern, pattern space is identical to user space,
    # but the relationship between the spaces can be changed with `Pattern#matrix=()`. 
    # *x0* : x coordinate of the start point
    # *y0* : y coordinate of the start point
    # *x1* : x coordinate of the end point
    # *y1* : y coordinate of the end point
    # Returns :  the newly created Cairo::Pattern if successful, or an error pattern in case of no memory.
    def self.create_linear(x0 : Float64, y0 : Float64, x1 : Float64, y1 : Float64)
      Pattern.new(LibCairo.pattern_create_linear(x0, y0, x1, y1))
    end

    # Creates a new radial gradient cairo_pattern_t between the two circles defined by (cx0, cy0, radius0) and (cx1, cy1, radius1).
    # Before using the gradient pattern, a number of color stops should be defined using `Pattern#add_color_stop()`. 
    # Note: The coordinates here are in pattern space. For a new pattern, pattern space is identical to user space,
    # but the relationship between the spaces can be changed with `Pattern#matrix=()`. 
    # *cx0* : x coordinate for the center of the start circle
    # *cy0* : y coordinate for the center of the start circle
    # *radius0* :  radius of the start circle
    # *cx1* : x coordinate for the center of the end circle
    # *cy1* : y coordinate for the center of the end circle
    # *radius1* :  radius of the end circle
    # Returns :  the newly created Cairo::Pattern if successful, or an error pattern in case of no memory.
    def self.create_radial(cx0 : Float64, cy0 : Float64, radius0 : Float64, cx1 : Float64, cy1 : Float64, radius1 : Float64)
      Pattern.new(LibCairo.pattern_create_radial(cx0, cy0, radius0, cx1, cy1, radius1))
    end

    # Increases the reference count on pattern by one.
    # Returns : the referenced Cairo::Pattern.
    def reference : Pattern
      Pattern.new(LibCairo.pattern_reference(@pointer.as(LibCairo::Pattern*)))
    end

    # Returns the current reference count of pattern. 
    def reference_count : UInt32
      LibCairo.pattern_get_reference_count(@pointer.as(LibCairo::Pattern*))
    end

    # Checks whether an error has previously occurred for this pattern.
    # Returns : Cairo::`Status`::SUCCESS, Cairo::`Status`::NO_MEMORY, or Cairo::`Status`::PATTERN_TYPE_MISMATCH.  
    def status : Status
      Status.new(LibCairo.pattern_status(@pointer.as(LibCairo::Pattern*)))
    end

    # Return user data previously attached to pattern using the specified key.
    # If no user data has been attached with the given key this function returns nil.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to.
    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.pattern_get_user_data(@pointer.as(LibCairo::Pattern*), key)
    end

    # Attach user data to pattern.
    # To remove user data from a pattern, call this function with the key that was used to set it and nil for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the Pattern.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the Pattern is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.
    def set_user_data(key : LibCairo::UserDataKey, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.pattern_set_user_data(@pointer.as(LibCairo::Pattern*), key, user_data, destroy).value)
    end

    # Returns the type a pattern.
    def type : PatternType
      PatternType.new(LibCairo.pattern_get_type(@pointer.as(LibCairo::Pattern*)))
    end

    # Adds an opaque color stop to a gradient pattern. The offset specifies the location along the gradient's control vector.
    # For example, a linear gradient's control vector is from (x0,y0) to (x1,y1) while
    # a radial gradient's control vector is from any point on the start circle to the corresponding point on the end circle. 
    # The color is specified in the same way as in `Context#set_source_rgb()`. 
    # If two (or more) stops are specified with identical offset values, they will be sorted according to the order in which the stops are added,
    # (stops added earlier will compare less than stops added later). This can be useful for reliably making sharp color transitions instead of the typical blend. 
    # Note: If the pattern is not a gradient pattern, (eg. a linear or radial pattern),
    # then the pattern will be put into an error status with a status of Cairo::`Status`::PATTERN_TYPE_MISMATCH.
    # *offset* : an offset in the range [0.0 .. 1.0]
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # Returns this pattern. 
    def add_color_stop(offset : Float64, red : Float64, green : Float64, blue : Float64)
      LibCairo.pattern_add_color_stop_rgb(@pointer.as(LibCairo::Pattern*), offset, red, green, blue)
      self
    end

    # Adds a translucent color stop to a gradient pattern. The offset specifies the location along the gradient's control vector.
    # For example, a linear gradient's control vector is from (x0,y0) to (x1,y1) while
    # a radial gradient's control vector is from any point on the start circle to the corresponding point on the end circle. 
    # The color is specified in the same way as in `Context#set_source_rgba()`. 
    # If two (or more) stops are specified with identical offset values, they will be sorted according to the order in which the stops are added,
    # (stops added earlier will compare less than stops added later). This can be useful for reliably making sharp color transitions instead of the typical blend. 
    # Note: If the pattern is not a gradient pattern, (eg. a linear or radial pattern),
    # then the pattern will be put into an error status with a status of Cairo::`Status`::PATTERN_TYPE_MISMATCH. 
    # *offset* : an offset in the range [0.0 .. 1.0]
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # *alpha* : alpha component of the color
    # Returns this pattern. 
    def add_color_stop(offset : Float64, red : Float64, green : Float64, blue : Float64, alpha : Float64)
      LibCairo.pattern_add_color_stop_rgba(@pointer.as(LibCairo::Pattern*), offset, red, green, blue, alpha)
      self
    end

    # Returns the pattern's transformation matrix. 
    def matrix : Matrix
      matrix = Matrix.new
      LibCairo.pattern_get_matrix(@pointer.as(LibCairo::Pattern*), matrix.to_unsafe)
      matrix
    end

    # Sets the pattern's transformation matrix to *matrix*. This matrix is a transformation from user space to pattern space. 
    # When a pattern is first created it always has the identity matrix for its transformation matrix, which means that pattern space is initially identical to user space. 
    # Important: Please note that the direction of this transformation matrix is from user space to pattern space.
    # This means that if you imagine the flow from a pattern to user space (and on to device space), then coordinates in that flow will be transformed by the inverse of the pattern matrix. 
    #For example, if you want to make a pattern appear twice as large as it does by default the correct code to use is: 
    # ```
    # matrix.init_scale(0.5,0.5)
    # pattern.matrix = matrix
    # ```
    # Meanwhile, using values of 2.0 rather than 0.5 in the code above would cause the pattern to appear at half of its default size.
    # *matrix* : a Cairo::Matrix
    # Returns this pattern.
    def matrix=(matrix : Matrix)
      LibCairo.pattern_set_matrix(@pointer.as(LibCairo::Pattern*), matrix.to_unsafe)
      self
    end

    # Returns the current extend mode for a pattern.
    def extend : Extend
      Extend.new(LibCairo.pattern_get_extend(@pointer.as(LibCairo::Pattern*)).value)
    end

    # Sets the mode to be used for drawing outside the area of a pattern.
    # *ex* : a Cairo::`Extend` describing how the area outside of the pattern will be drawn
    # Returns this pattern.
    def extend=(ex : Extend)
      LibCairo.pattern_set_extend(@pointer.as(LibCairo::Pattern*), LibCairo::Extend.new(ex.value))
      self
    end

    # Returns the current filter for a pattern.
    def filter : Filter
      Filter.new(LibCairo.pattern_get_filter(@pointer.as(LibCairo::Pattern*)).value)
    end

    # Sets the filter to be used for resizing when using this pattern.
    # *filter* : a Cairo::Filter describing the filter to use for resizing the pattern. 
    def filter=(filter : Filter)
      LibCairo.pattern_set_filter(@pointer.as(LibCairo::Pattern*), LibCairo::Filter.new(filter.value))
      self
    end

  end
end

