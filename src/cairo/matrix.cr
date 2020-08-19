module Cairo

  # Class for generic matrix operations
  class Matrix

    # Returns a new Cairo::Matrix
    def self.new : self
      ptr = Pointer(UInt8).malloc(48, 0u8)
      new(ptr.as(LibCairo::Matrix*)) 
    end
 
    # Returns a new Cairo::Matrix
    # *xx* : xx component of the affine transformation
    # *yx* : yx component of the affine transformation
    # *xy* : xy component of the affine transformation
    # *yy* : yy component of the affine transformation
    # *x0* : X translation component of the affine transformation
    # *y0* : Y translation component of the affine transformation
    def self.new(xx : Float64, yx : Float64, xy : Float64, yy : Float64, x0 : Float64, y0 : Float64) : self
      ptr = Pointer(UInt8).malloc(48, 0u8)
      LibCairo.matrix_init(ptr.as(LibCairo::Matrix*), xx, yx, xy, yy, x0, y0)
      new(ptr.as(LibCairo::Matrix*))
    end

    # Sets matrix to be the affine transformation given by xx, yx, xy, yy, x0, y0.
    # The transformation is given by:
    #    x_new = xx * x + xy * y + x0;
    #    y_new = yx * x + yy * y + y0;
    # *xx* : xx component of the affine transformation
    # *yx* : yx component of the affine transformation
    # *xy* : xy component of the affine transformation
    # *yy* : yy component of the affine transformation
    # *x0* : X translation component of the affine transformation
    # *y0* : Y translation component of the affine transformation
    # Returns this matrix after modification. 
    def init(xx : Float64, yx : Float64, xy : Float64, yy : Float64, x0 : Float64, y0 : Float64)
      LibCairo.matrix_init(to_unsafe, xx, yx, xy, yy, x0, y0)
      self
    end

    # Modifies matrix to be an identity transformation.
    # Returns this matrix after modification.
    def init_identity
      LibCairo.matrix_init_identity(to_unsafe)
      self
    end

    # Initializes matrix to a transformation that translates by tx and ty in the X and Y dimensions, respectively.
    # *tx* : amount to translate in the X direction
    # *ty* : amount to translate in the Y direction 
    # Returns this matrix.
    def init_translate(tx : Float64, ty : Float64)
      LibCairo.matrix_init_translate(to_unsafe, tx, ty)
      self
    end

    # Initializes matrix to a transformation that scales by sx and sy in the X and Y dimensions, respectively.
    # *sx* : scale factor in the X direction
    # *sy* : scale factor in the Y direction
    # Returns this matrix.
    def init_scale(sx : Float64, sy : Float64)
      LibCairo.matrix_init_scale(to_unsafe, sx, sy)
      self
    end

    # Initialized matrix to a transformation that rotates by radians.
    # *radians* : angle of rotation, in radians.
    # The direction of rotation is defined such that positive angles rotate in the direction from the positive X axis toward the positive Y axis.
    # With the default axis orientation of cairo, positive angles rotate in a clockwise direction.
    # Returns this matrix.
    def init_rotate(radians : Float64)
      LibCairo.matrix_init_rotate(to_unsafe, radians)
      self
    end

    # Applies a translation by tx, ty to the transformation in matrix.
    # The effect of the new transformation is to first translate the coordinates by tx and ty,
    # then apply the original transformation to the coordinates.
    # *tx* : amount to translate in the X direction
    # *ty* : amount to translate in the Y direction
    # Returns this matrix.
    def translate(tx : Float64, ty : Float64)
      LibCairo.matrix_translate(to_unsafe, tx, ty)
      self
    end

    # Applies scaling by sx, sy to the transformation in matrix.
    # The effect of the new transformation is to first scale the coordinates by sx and sy,
    # then apply the original transformation to the coordinates.
    # *sx* : scale factor in the X direction
    # *sy* : scale factor in the Y direction
    # Returns this matrix.
    def scale(sx : Float64, sy : Float64)
      LibCairo.matrix_scale(to_unsafe, sx, sy)
      self
    end

    # Applies rotation by radians to the transformation in matrix.
    # The effect of the new transformation is to first rotate the coordinates by radians,
    # then apply the original transformation to the coordinates.
    # *radians* : angle of rotation, in radians.
    # The direction of rotation is defined such that positive angles rotate in the direction from the positive X axis toward the positive Y axis.
    # With the default axis orientation of cairo, positive angles rotate in a clockwise direction.
    # Returns this matrix.
    def rotate(radians : Float64)
      LibCairo.matrix_rotate(to_unsafe, radians)
      self
    end

    # Changes matrix to be the inverse of its original value. Not all transformation matrices have inverses;
    # if the matrix collapses points together (it is degenerate), then it has no inverse and this function will fail.
    # Returns : If matrix has an inverse, modifies matrix to be the inverse matrix and returns Cairo::`Status`::SUCCESS. Otherwise, returns Cairo::`Status`::INVALID_MATRIX.  
    def invert : Status
      Status.new(LibCairo.matrix_invert(to_unsafe))
    end

    # Multiplies the affine transformations in *a* and *b* together and stores the result in self.
    # The effect of the resulting transformation is to first apply the transformation in *a* to the coordinates and then apply the transformation in *b* to the coordinates. 
    # It is allowable for this matrix to be identical to either *a* or *b*. 
    # *a* : a Cairo::Matrix
    # *b* : a Cairo::Matrix
    # Returns this matrix.
    def multiply(a : Matrix, b : Matrix)
      LibCairo.matrix_multiply(to_unsafe, a.to_unsafe, b.to_unsafe)
      self
    end

    # Transforms the distance vector (dx,dy) by matrix.
    # This is similar to `Matrix#transform_point()` except that the translation components of the transformation are ignored.
    # The calculation of the returned vector is as follows:
    #     dx = dx * xx + dy * xy;
    #     dy = dx * yx + dy * yy;
    # Affine transformations are position invariant, so the same vector always transforms to the same vector.
    # If (x1,y1) transforms to (x2,y2) then (x1+dx1,y1+dy1) will transform to (x1+dx2,y1+dy2) for all values of x1 and x2.
    # *dx* : X component of a distance vector. An in/out parameter
    # *dy* : Y component of a distance vector. An in/out parameter 
    def transform_distance(dx : Float64*, dy : Float64*) : Void
      LibCairo.matrix_transform_distance(to_unsafe,dx,dy)
    end

    # Transforms the point (x, y) by matrix.
    # *x* : X position. An in/out parameter
    # *y* : Y position. An in/out parameter 
    def transform_point(x : Float64*, y : Float64*) : Void
      LibCairo.matrix_transform_point(to_unsafe,x,y)
    end
 
  end
end

