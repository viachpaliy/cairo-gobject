module Cairo
  class Matrix

    def initialize 
      @pointer = LibCairo::Matrix.new 
    end 

    def init(xx : Float64, yx : Float64, xy : Float64, yy : Float64, x0 : Float64, y0 : Float64)
      LibCairo.matrix_init(to_unsafe, xx, yx, xy, yy, x0, y0)
      self
    end

    def init_identity
      LibCairo.matrix_init_identity(to_unsafe)
      self
    end

    def init_translate(tx : Float64, ty : Float64)
      LibCairo.matrix_init_translate(to_unsafe, tx, ty)
      self
    end

    def init_scale(sx : Float64, sy : Float64)
      LibCairo.matrix_init_scale(to_unsafe, sx, sy)
      self
    end

    def init_rotate(radians : Float64)
      LibCairo.matrix_init_rotate(to_unsafe, radians)
      self
    end

    def translate(tx : Float64, ty : Float64)
      LibCairo.matrix_translate(to_unsafe, tx, ty)
      self
    end

    def scale(sx : Float64, sy : Float64)
      LibCairo.matrix_scale(to_unsafe, sx, sy)
      self
    end

    def rotate(radians : Float64)
      LibCairo.matrix_rotate(to_unsafe, radians)
      self
    end

    def invert : Status
      Status.new(LibCairo.matrix_invert(to_unsafe).value)
    end

    def multiply(a : Matrix, b : Matrix)
      LibCairo.matrix_multiply(to_unsafe, a.to_unsafe, b.to_unsafe)
      self
    end

    def transform_distance(dx : Float64*, dy : Float64*) : Void
      LibCairo.matrix_transform_distance(to_unsafe,dx,dy)
    end

    def transform_point(x : Float64*, y : Float64*) : Void
      LibCairo.matrix_transform_point(to_unsafe,x,y)
    end

  end
end

