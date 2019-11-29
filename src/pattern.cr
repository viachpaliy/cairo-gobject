module Cairo
  class Pattern

    def finalize
      LibCairo.pattern_destroy(@pointer.as(LibCairo::Pattern*))
    end

        # Create RGB Pattern
    def self.create_rgb(red : Float64, green : Float64, blue : Float64)
      Pattern.new(LibCairo.pattern_create_rgb(red, green, blue))
    end

    # Create RGBA Pattern
    def create_rgba(red : Float64, green : Float64, blue : Float64, alpha : Float64)
      Pattern.new(LibCairo.pattern_create_rgb(red, green, blue, alpha))
    end

    # Create Pattern for Surface
    def self.create_for_surface(surface : Surface)
      Pattern.new(LibCairo.pattern_create_for_surface(surface.to_unsafe))
    end

    # Create Linear Pattern
    def self.create_linear(x0 : Float64, y0 : Float64, x1 : Float64, y1 : Float64)
      Pattern.new(LibCairo.pattern_create_linear(x0, y0, x1, y1))
    end

    # Create Radial Pattern
    def self.create_radial(cx0 : Float64, cy0 : Float64, radius0 : Float64, cx1 : Float64, cy1 : Float64, radius1 : Float64)
      Pattern.new(LibCairo.pattern_create_radial(cx0, cy0, radius0, cx1, cy1, radius1))
    end

    def reference : Pattern
      Pattern.new(LibCairo.pattern_reference(@pointer.as(LibCairo::Pattern*)))
    end

    def reference_count : UInt32
      LibCairo.pattern_get_reference_count(@pointer.as(LibCairo::Pattern*))
    end

    def status : Status
      Status.new(LibCairo.pattern_status(@pointer.as(LibCairo::Pattern*)).value)
    end

    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.pattern_get_user_data(@pointer.as(LibCairo::Pattern*), key)
    end

    def set_user_data(key : LibCairo::UserDataKey, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.pattern_set_user_data(@pointer.as(LibCairo::Pattern*), key, user_data, destroy).value)
    end

    def type : PatternType
      PatternType.new(LibCairo.pattern_get_type(@pointer.as(LibCairo::Pattern*)))
    end

    def add_color_stop(offset : Float64, red : Float64, green : Float64, blue : Float64)
      LibCairo.pattern_add_color_stop_rgb(@pointer.as(LibCairo::Pattern*), offset, red, green, blue)
      self
    end

    def add_color_stop(offset : Float64, red : Float64, green : Float64, blue : Float64, alpha : Float64)
      LibCairo.pattern_add_color_stop_rgba(@pointer.as(LibCairo::Pattern*), offset, red, green, blue, alpha)
      self
    end

    def matrix : Matrix
      matrix = Matrix.new
      LibCairo.pattern_get_matrix(@pointer.as(LibCairo::Pattern*), matrix.to_unsafe)
      matrix
    end

    def matrix=(matrix : Matrix)
      LibCairo.pattern_set_matrix(@pointer.as(LibCairo::Pattern*), matrix.to_unsafe)
      self
    end

    def extend : Extend
      Extend.new(LibCairo.pattern_get_extend(@pointer.as(LibCairo::Pattern*)).value)
    end

    def extend=(ex : Extend)
      LibCairo.pattern_set_extend(@pointer.as(LibCairo::Pattern*), LibCairo::Extend.new(ex.value))
      self
    end

    def filter : Filter
      Filter.new(LibCairo.pattern_get_filter(@pointer.as(LibCairo::Pattern*)).value)
    end

    def filter=(filter : Filter)
      LibCairo.pattern_set_filter(@pointer.as(LibCairo::Pattern*), LibCairo::Filter.new(filter.value))
      self
    end

  end
end

