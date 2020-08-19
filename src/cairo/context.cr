module Cairo

  # The cairo drawing context.
  class Context

    # Creates a new Context with all graphics state parameters set to default values and with target as a target surface.
    # The target surface should be constructed with a backend-specific method.
    # *target* : a target surface for the context.
    def self.create(target : Cairo::Surface)  
      Cairo::Context.new LibCairo.create(target.to_unsafe())
    end 
       
    def finalize
      LibCairo.destroy(@pointer.as(LibCairo::Context*))
    end

    # Increases the reference count on context by one.
    # Returns : the referenced  context.
    def reference : Context
      Context.new LibCairo.reference(@pointer.as(LibCairo::Context*))
    end

    # Returns the current reference count of context.
    def reference_count : UInt32
      LibCairo.get_reference_count(@pointer.as(LibCairo::Context*))
    end

    # Return user data previously attached to context using the specified key.
    # If no user data has been attached with the given key this function returns nil.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to.
    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.get_user_data(@pointer.as(LibCairo::Context*), key)
    end

    # Attach user data to context.
    # To remove user data from a surface, call this method with the key that was used to set it and nil for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the context.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the context is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.
    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.set_user_data(@pointer.as(LibCairo::Context*), key, user_data, destroy).value)
    end

    # Makes a copy of the current state of context and saves it on an internal stack of saved states for context.
    # When `Context#restore()` is called, context will be restored to the saved state.
    # Multiple calls to `Context#save()` and `Context#restore()` can be nested;
    # each call to `Context#restore()` restores the state from the matching paired `Context#save()`.
    # Returns this context.
    def save
      LibCairo.save(@pointer.as(LibCairo::Context*))
      self
    end

    # Restores context to the state saved by a preceding call to `Context#save()` and removes that state from the stack of saved states. 
    # Returns this context.
    def restore
      LibCairo.restore(@pointer.as(LibCairo::Context*))
      self
    end

    # Temporarily redirects drawing to an intermediate surface known as a group.
    # The redirection lasts until the group is completed by a call to `Context#pop_group()` or `Context#pop_group_to_source()`.
    # These calls provide the result of any drawing to the group as a pattern, (either as an explicit object, or set as the source pattern). 
    # This group functionality can be convenient for performing intermediate compositing.
    # One common use of a group is to render objects as opaque within the group, (so that they occlude each other), and then blend the result with translucence onto the destination. 
    # Groups can be nested arbitrarily deep by making balanced calls to `Context#push_group()`/`Context#pop_group()`. Each call pushes/pops the new target group onto/from a stack. 
    # The `Context#push_group()` function calls `Context#save()` so that any changes to the graphics state will not be visible outside the group, (the pop_group methods call `Contexe#restore()`). 
    # By default the intermediate group will have a content type of Cairo::Content::COLOR_ALPHA. Other content types can be chosen for the group by using `Context#push_group_with_content()` instead. 
    # As an example, here is how one might fill and stroke a path with translucence, but without any portion of the fill being visible under the stroke: 
    # ```
    # context.push_group 
    # context.source = fill_pattern
    # context.fill_preserve
    # context.source = stroke_pattern
    # context.stroke
    # context.pop_group_to_source
    # context.paint_with_alpha  alpha
    # ```
    # Returns this context.
    def push_group
      LibCairo.push_group(@pointer.as(LibCairo::Context*))
      self
    end

    # Temporarily redirects drawing to an intermediate surface known as a group.
    # The redirection lasts until the group is completed by a call to `Context#pop_group()` or `Context#pop_group_to_source()`.
    # These calls provide the result of any drawing to the group as a pattern, (either as an explicit object, or set as the source pattern). 
    # The group will have a content type of content.
    # The ability to control this content type is the only distinction between this method and `Context#push_group()` which you should see for a more detailed description of group rendering. 
    # *content* : a `Cairo::Content` indicating the type of group that will be created.
     # Returns this context.
    def push_group_with_content(content : Content)
      LibCairo.push_group_with_content(@pointer.as(LibCairo::Context*), content)
      self
    end

    # Terminates the redirection begun by a call to `Context#push_group()` or `Context#push_group_with_content()`
    # and returns a new pattern containing the results of all drawing operations performed to the group. 
    # The `Context#pop_group()` method calls `Context#restore()`, (balancing a call to `Context#save()` by the push_group method),
    # so that any changes to the graphics state will not be visible outside the group. 
    # Returns : a newly created (surface) pattern containing the results of all drawing operations performed to the group. 
    def pop_group : Pattern
      Pattern.new(LibCairo.pop_group(@pointer.as(LibCairo::Context*)))
    end

    # Terminates the redirection begun by a call to `Context#push_group()` or `Context#push_group_with_content()`
    # and installs the resulting pattern as the source pattern in the given cairo context. 
    # The behavior of this function is equivalent to the sequence of operations: 
    # ```
    # context.source = context.pop_group
    # ```
    # but is more convenient as their is no need for a variable to store the short-lived Pattern.
    # The `Context#pop_group()` method calls `Context#restore()`, (balancing a call to `Context#save()` by the push_group method),
    # so that any changes to the graphics state will not be visible outside the group.
    # Returns : a newly created context containing the resulting pattern as the source pattern.
    def pop_group_to_source : Context
      Context.new(LibCairo.pop_group_to_source(@pointer.as(LibCairo::Context*)))
    end

    # Sets the compositing operator to be used for all drawing operations.
    # *op* : a compositing operator, specified as a Cairo::`Operator`.
    # Returns self.
    def operator=(op : Operator)
      LibCairo.set_operator(@pointer.as(LibCairo::Context*), op)
      self
    end

    # Sets the source pattern within cr to source.
    # This pattern will then be used for any subsequent drawing operation until a new source pattern is set. 
    # Note: The pattern's transformation matrix will be locked to the user space in effect at the time of `Cairo#source=()`.
    # This means that further modifications of the current transformation matrix will not affect the source pattern. See `Cairo::Pattern#matrix=()`. 
    # The default source pattern is a solid pattern that is opaque black, (that is, it is equivalent to Context.set_source_rgb=(0.0, 0.0, 0.0)). 
    # *source* : a `Cairo::Pattern` to be used as the source for subsequent drawing operations.
    # Returns self.
    def source=(source : Pattern)
      LibCairo.set_source(@pointer.as(LibCairo::Context*), source.to_unsafe)
      self
    end

    # Sets the source pattern to an opaque color.
    # This opaque color will then be used for any subsequent drawing operation until a new source pattern is set. 
    # The color components are floating point numbers in the range 0 to 1. If the values passed in are outside that range, they will be clamped. 
    # The default source pattern is opaque black, (that is, it is equivalent to Context.set_source_rgb(0.0, 0.0, 0.0)). 
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # Returns self.
    def set_source_rgb(red : Float64, green : Float64, blue : Float64)
      LibCairo.set_source_rgb(@pointer.as(LibCairo::Context*), red, green, blue)
      self
    end

    # Sets the source pattern to a translucent color.
    # This color will then be used for any subsequent drawing operation until a new source pattern is set. 
    # The color and alpha components are floating point numbers in the range 0 to 1. If the values passed in are outside that range, they will be clamped. 
    # The default source pattern is opaque black, (that is, it is equivalent to Contextset_source_rgba(0.0, 0.0, 0.0, 1.0)). 
    # *red* : red component of the color
    # *green* : green component of the color
    # *blue* : blue component of the color
    # *alpha* : alpha component of the color
    # Returns self.
    def set_source_rgba(red : Float64, green : Float64, blue : Float64, alpha : Float64)
      LibCairo.set_source_rgba(@pointer.as(LibCairo::Context*), red, green, blue, alpha)
      self
    end

    # This is a convenience method for creating a pattern from surface and setting it as the source in context with `Context#set_source()`. 
    # The x and y parameters give the user-space coordinate at which the surface origin should appear.
    # (The surface origin is its upper-left corner before any transformation has been applied.)
    # The x and y patterns are negated and then set as translation values in the pattern matrix. 
    # Other than the initial translation pattern matrix, as described above, all other pattern attributes, (such as its extend mode),
    # are set to the default values as in `Cairo::Pattern#create_for_surface()`.
    # The resulting pattern can be queried with `Context#source()` so that these attributes can be modified if desired,
    # (eg. to create a repeating pattern with `Cairo::Pattern#extend=()`). 
    # *surface* :a surface to be used to set the source pattern
    # *x* : user-space X coordinate for surface origin
    # *y* : user-space Y coordinate for surface origin
    # Returns self.
    def set_source_surface(surface : Surface, x : Float64, y : Float64)
      LibCairo.set_source_surface(@pointer.as(LibCairo::Context*), surface.to_unsafe, x, y)
      self
    end

    # Sets the tolerance used when converting paths into trapezoids.
    # Curved segments of the path will be subdivided until the maximum deviation between the original path and the polygonal approximation is less than tolerance.
    # The default value is 0.1. A larger value will give better performance, a smaller value, better appearance.
    # (Reducing the value from the default value of 0.1 is unlikely to improve appearance significantly.)
    # The accuracy of paths within Cairo is limited by the precision of its internal arithmetic, and the prescribed tolerance is restricted to the smallest representable internal value.
    # *tolerance* : the tolerance, in device units (typically pixels)
    # Returns self.
    def tolerance=(tolerance : Float64)
      LibCairo.set_tolerance(@pointer.as(LibCairo::Context*), tolerance)
      self
    end

    # Sets the antialiasing mode of the rasterizer used for drawing shapes.
    # This value is a hint, and a particular backend may or may not support a particular value.
    # At the current time, no backend supports Cairo::Antialias::SUBPIXEL when drawing shapes. 
    # Note that this option does not affect text rendering, instead see `Cairo::FontOptions#antialias=()`. 
    # *antialias* : the new antialiasing mode.
    # Returns self.
    def antialias=(antialias : Antialias)
      LibCairo.set_antialias(@pointer.as(LibCairo::Context*), antialias)
      self
    end

    # Set the current fill rule within the cairo context.
    # The fill rule is used to determine which regions are inside or outside a complex (potentially self-intersecting) path.
    # The current fill rule affects both `Context#fill()` and `Context#clip()`.
    # See `Cairo::FillRule` for details on the semantics of each available fill rule. 
    # The default fill rule is Cairo::FillRule::WINDING. 
    # *fill_rule* : a fill rule, specified as a `Cairo::FillRule`.
    # Returns self.
    def fill_rule=(fill_rule : FillRule)
      LibCairo.set_fill_rule(@pointer.as(LibCairo::Context*), fill_rule)
      self
    end

    # Sets the current line width within the cairo context.
    # The line width value specifies the diameter of a pen that is circular in user space, (though device-space pen may be an ellipse in general due to scaling/shear/rotation of the CTM). 
    # Note: When the description above refers to user space and CTM it refers to the user space and CTM in effect at the time of the stroking operation,
    # not the user space and CTM in effect at the time of the call to `Context#line_width=()`.
    # The simplest usage makes both of these spaces identical.
    # That is, if there is no change to the CTM between a call to `Context#line_width=()` and the stroking operation,
    # then one can just pass user-space values to `Context#line_width=()` and ignore this note. 
    # As with the other stroke parameters, the current line width is examined by `Context#stroke()`, `Context#stroke_extents()`, but does not have any effect during path construction. 
    # The default line width value is 2.0. 
    # *width* : a line width.
    # Returns self.
    def line_width=(width : Float64)
      LibCairo.set_line_width(@pointer.as(LibCairo::Context*), width)
      self
    end

    # Sets the current line cap style within the cairo context.
    # See `Cairo::LineCap` for details about how the available line cap styles are drawn. 
    # As with the other stroke parameters, the current line cap style is examined by `Context#stroke()`, `Context#stroke_extents()` but does not have any effect during path construction. 
    # The default line cap style is Cairo::LineCap::BUTT. 
    # *line_cap* : a line cap style, specified as a `Cairo::LineCap`
    # Returns self.
    def line_cap=(line_cap : LineCap)
      LibCairo.set_line_cap(@pointer.as(LibCairo::Context*), line_cap)
      self
    end

    # Sets the current line join style within the cairo context.
    # See `Cairo::LineJoin` for details about how the available line join styles are drawn. 
    # As with the other stroke parameters, the current line join style is examined by `Context#stroke()`, `Context#stroke_extents()`, but does not have any effect during path construction. 
    # The default line join style is Cairo::LineJoin::MITER. 
    # *line_join* : a line join style, specified as a `Cairo::LineJoin`
    # Returns self.
    def line_join=(line_join : LineJoin)
      LibCairo.set_line_join(@pointer.as(LibCairo::Context*), line_join)
      self
    end

    # Sets the dash pattern to be used by `Context#stroke()`.
    # A dash pattern is specified by dashes, an array of positive values.
    # Each value provides the length of alternate "on" and "off" portions of the stroke. The *offset* specifies an offset into the pattern at which the stroke begins. 
    # Each "on" segment will have caps applied as if the segment were a separate sub-path.
    # In particular, it is valid to use an "on" length of 0.0 with Cairo::LineCap::ROUND or Cairo::LineCap::SQUARE in order to distributed dots or squares along a path. 
    # Note: The length values are in user-space units as evaluated at the time of stroking. This is not necessarily the same as the user space at the time of `Context#set_dash()`. 
    # If *dashes*.size is 0 dashing is disabled. 
    # If *dashes*.size is 1 a symmetric pattern is assumed with alternating on and off portions of the size specified by the single value in dashes. 
    # If any value in dashes is negative, or if all values are 0, then context will be put into an error state with a status of Cairo::Status::INVALID_DASH. 
    # *dashes* : an array specifying alternate lengths of on and off stroke portions.
    # *offset* : an offset into the dash pattern at which the stroke should start.
    # Returns self.
    def set_dash(dashes : Array(Float64), offset : Float64)
      LibCairo.set_dash(@pointer.as(LibCairo::Context*), dashes.to_unsafe, dashes.size, offset)
      self
    end

    # Sets the current miter limit within the cairo context. 
    # If the current line join style is set to Cairo::LineJoin::MITER (see `Context#line_join=()`),
    # the miter limit is used to determine whether the lines should be joined with a bevel instead of a miter.
    # Cairo divides the length of the miter by the line width. If the result is greater than the miter limit, the style is converted to a bevel. 
    # As with the other stroke parameters, the current line miter limit is examined by `Context#stroke()`, `Context#stroke_extents()`, but does not have any effect during path construction. 
    # The default miter limit value is 10.0, which will convert joins with interior angles less than 11 degrees to bevels instead of miters.
    # For reference, a miter limit of 2.0 makes the miter cutoff at 60 degrees, and a miter limit of 1.414 makes the cutoff at 90 degrees. 
    # A miter limit for a desired angle can be computed as: miter limit = 1/sin(angle/2) 
    # *limit* : miter limit to set
    # Returns self.
    def miter_limit=(limit : Float64)
      LibCairo.set_miter_limit(@pointer.as(LibCairo::Context*), limit)
      self
    end

    # Modifies the current transformation matrix (CTM) by translating the user-space origin by (*tx*, *ty*).
    # This offset is interpreted as a user-space coordinate according to the CTM in place before the new call to `Context#translate()`.
    # In other words, the translation of the user-space origin takes place after any existing transformation.
    # *tx* : amount to translate in the X direction
    # *ty* : amount to translate in the Y direction
    # Returns self.
    def translate(tx : Int32 | Float64, ty : Int32 | Float64)
      LibCairo.translate(@pointer.as(LibCairo::Context*), Float64.new(tx), Float64.new(ty))
      self
    end

    # Modifies the current transformation matrix (CTM) by scaling the X and Y user-space axes by *sx* and *sy* respectively.
    # The scaling of the axes takes place after any existing transformation of user space.
    # *sx* :  scale factor for the X dimension
    # *sy* :  scale factor for the Y dimension
    # Returns self.
    def scale(sx : Int32 | Float64, sy : Int32 | Float64)
      LibCairo.scale(@pointer.as(LibCairo::Context*), Float64.new(sx), Float64.new(sy))
      self
    end

    # Modifies the current transformation matrix (CTM) by rotating the user-space axes by angle radians.
    # The rotation of the axes takes places after any existing transformation of user space.
    # The rotation direction for positive angles is from the positive X axis toward the positive Y axis.
    # *angle* : angle (in radians) by which the user-space axes will be rotated.
    # Returns self.
    def rotate(angle : Float64)
      LibCairo.rotate(@pointer.as(LibCairo::Context*), angle)
      self
    end

    # Modifies the current transformation matrix (CTM) by applying matrix as an additional transformation.
    # The new transformation of user space takes place after any existing transformation.
    # *matrix* :  a transformation to be applied to the user-space axes.
    # Returns self.
    def transform(matrix : Matrix)
      LibCairo.transform(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
    end

    # Modifies the current transformation matrix (CTM) by setting it equal to *matrix*.
    # *matrix* : a transformation matrix from user space to device space.
    # Returns self.
    def matrix=(matrix : Matrix)
      LibCairo.set_matrix(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
      self
    end

    # Resets the current transformation matrix (CTM) by setting it equal to the identity matrix.
    # That is, the user-space and device-space axes will be aligned and one user-space unit will transform to one device-space unit.
    # Returns self.
    def identity_matrix
      LibCairo.identity_matrix(@pointer.as(LibCairo::Context*))
      self
    end

    # Transforms a coordinate from user space to device space by multiplying the given point by the current transformation matrix (CTM).
    # *x* : X value of coordinate (in/out parameter)
    # *y* : Y value of coordinate (in/out parameter)
    def user_to_device(x : Float64*, y : Float64*)  : Void
      LibCairo.user_to_device(@pointer.as(LibCairo::Context*), x, y)
    end

    # Transforms a distance vector from user space to device space.
    # This function is similar to `Context#user_to_device()` except that the translation components of the CTM will be ignored when transforming (*dx*, *dy*).
    # *dx* : X component of a distance vector (in/out parameter)
    # *dy* : Y component of a distance vector (in/out parameter)
    def user_to_device_distance(dx : Float64*, dy : Float64*)  : Void
      LibCairo.user_to_device_distance(@pointer.as(LibCairo::Context*), dx, dy)
    end

    # Transform a coordinate from device space to user space by multiplying the given point by the inverse of the current transformation matrix (CTM).
    # *x* : X value of coordinate (in/out parameter)
    # *y* : Y value of coordinate (in/out parameter)
    def device_to_user(x : Float64*, y : Float64*)  : Void
      LibCairo.device_to_user(@pointer.as(LibCairo::Context*), x, y)
    end

    # Transform a distance vector from device space to user space.
    # This function is similar to `Context#device_to_user()` except that the translation components of the inverse CTM will be ignored when transforming (*dx*, *dy*). 
    # *dx* : X component of a distance vector (in/out parameter)
    # *dy* : Y component of a distance vector (in/out parameter)
    def device_to_user_distance(dx : Float64*, dy : Float64*)  : Void
      LibCairo.device_to_user_distance(@pointer.as(LibCairo::Context*), dx, dy)
    end

    # Clears the current path. After this call there will be no path and no current point.
    # Returns self.
    def new_path
      LibCairo.new_path(@pointer.as(LibCairo::Context*))
      self
    end

    # Begins a new sub-path. After this call the current point will be (*x*, *y*).
    # *x* : the X coordinate of the new position.
    # *y* : the Y coordinate of the new position.
    # Returns self.
    def move_to(x : Int32 | Float64, y : Int32 | Float64)
      LibCairo.move_to(@pointer.as(LibCairo::Context*), Float64.new(x), Float64.new(y))
      self
    end

    # Begins a new sub-path. Note that the existing path is not affected. After this call there will be no current point. 
    # In many cases, this call is not needed since new sub-paths are frequently started with `Context#move_to()`. 
    # A call to `Context#new_sub_path()` is particularly useful when beginning a new sub-path with one of the `Context#arc()` calls.
    # This makes things easier as it is no longer necessary to manually compute the arc's initial coordinates for a call to `Context#move_to()`. 
    # Returns self.
    def new_sub_path
      LibCairo.new_sub_path(@pointer.as(LibCairo::Context*))
      self
    end

    # Adds a line to the path from position(*x1*, *y1*) to position (*x2*, *y2*) in user-space coordinates. After this call the current point will be (*x2*, *y2*).
    # *x1* : the X coordinate of the start of the new line
    # *y1* : the Y coordinate of the start of the new line
    # *x2* : the X coordinate of the end of the new line
    # *y2* : the Y coordinate of the end of the new line
     # Returns self.
    def line(x1 : Int32 | Float64, y1 : Int32 | Float64, x2 : Int32 | Float64, y2 : Int32 | Float64)
      LibCairo.move_to(@pointer.as(LibCairo::Context*), Float64.new(x1), Float64.new(y1))
      LibCairo.line_to(@pointer.as(LibCairo::Context*), Float64.new(x2), Float64.new(y2))
      self
    end

    # Adds a line to the path from the current point to position (*x*, *y*) in user-space coordinates. After this call the current point will be (*x*, *y*). 
    # If there is no current point before the call to `Context#line_to()* this function will behave as `Context#move_to(x, y)`. 
    # *x* : the X coordinate of the end of the new line
    # *y* : the Y coordinate of the end of the new line
    # Returns self.
    def line_to(x : Int32 | Float64, y : Int32 | Float64)
      LibCairo.line_to(@pointer.as(LibCairo::Context*), Float64.new(x), Float64.new(y))
      self
    end

    # Adds a cubic Bézier spline to the path from the current point to position (*x3*, *y3*) in user-space coordinates,
    # using (*x1*, *y1*) and (*x2*, *y2*) as the control points. After this call the current point will be (*x3*, *y3*). 
    # If there is no current point before the call to `Context#curve_to()` this function will behave as if preceded by a call to `Context#move_to(x1, y1)`. 
    # *x1* : the X coordinate of the first control point
    # *y1* : the Y coordinate of the first control point
    # *x2* : the X coordinate of the second control point
    # *y2* : the Y coordinate of the second control point
    # *x3* : the X coordinate of the end of the curve
    # *y3* : the Y coordinate of the end of the curve
    # Returns self.
    def curve_to(x1 : Int32 | Float64, y1 : Int32 | Float64,
                 x2 : Int32 | Float64, y2 : Int32 | Float64,
                 x3 : Int32 | Float64, y3 : Int32 | Float64)
      LibCairo.curve_to(@pointer.as(LibCairo::Context*), Float64.new(x1), Float64.new(y1), Float64.new(x2), Float64.new(y2), Float64.new(x3), Float64.new(y3))
      self
    end

    # Adds a circular arc of the given *radius* to the current path.
    # The arc is centered at (*xc*, *yc*), begins at *angle1* and proceeds in the direction of increasing angles to end at *angle2*.
    # If *angle2* is less than *angle1* it will be progressively increased by 2*Math::PI until it is greater than *angle1*. 
    # If there is a current point, an initial line segment will be added to the path to connect the current point to the beginning of the arc.
    # If this initial line is undesired, it can be avoided by calling `Context#new_sub_path()` before calling `Context#arc()`. 
    # Angles are measured in radians. An angle of 0.0 is in the direction of the positive X axis (in user space).
    # An angle of Math::PI/2.0 radians (90 degrees) is in the direction of the positive Y axis (in user space).
    # Angles increase in the direction from the positive X axis toward the positive Y axis. So with the default transformation matrix, angles increase in a clockwise direction. 
    # (To convert from degrees to radians, use degrees * (Math::PI / 180.).) 
    # This method gives the arc in the direction of increasing angles; see `Context#arc_negative()` to get the arc in the direction of decreasing angles. 
    # The arc is circular in user space. To achieve an elliptical arc, you can scale the current transformation matrix by different amounts in the X and Y directions.
    # For example, to draw an ellipse in the box given by x, y, width, height: 
    # ```
    # context.save
    # context.translate (x + width / 2., y + height / 2.)
    # context.scale (width / 2., height / 2.)
    # context.arc (0., 0., 1., 0., 2 * Math::PI)
    # context.restore 
    # ```
    # *xc* : X position of the center of the arc
    # *yc* : Y position of the center of the arc
    # *radius* : the radius of the arc
    # *angle1* : the start angle, in radians
    # *angle2* : the end angle, in radians
    # Returns self.
    def arc(xc : Int32 | Float64, yc : Int32 | Float64, radius : Int32 | Float64,
            angle1 : Float64, angle2 : Float64)
      LibCairo.arc(@pointer.as(LibCairo::Context*), Float64.new(xc), Float64.new(yc), Float64.new(radius), angle1, angle2)
      self
    end

    # Adds a circular arc of the given *radius* to the current path.
    # The arc is centered at (*xc*, *yc*), begins at *angle1* and proceeds in the direction of decreasing angles to end at *angle2*.
    # If *angle2* is greater than *angle1* it will be progressively decreased by 2*Math::PI until it is less than *angle1*. 
    # See `Context#arc()` for more details. This function differs only in the direction of the arc between the two angles. 
    # *xc* : X position of the center of the arc
    # *yc* : Y position of the center of the arc
    # *radius* : the radius of the arc
    # *angle1* : the start angle, in radians
    # *angle2* : the end angle, in radians
    # Returns self.
    def arc_negative(xc : Int32 | Float64, yc : Int32 | Float64,
                     radius : Int32 | Float64, angle1 : Float64, angle2 : Float64)
      LibCairo.arc_negative(@pointer.as(LibCairo::Context*),  Float64.new(xc), Float64.new(yc), Float64.new(radius), angle1, angle2)
      self
    end

    # Begin a new sub-path. After this call the current point will offset by (*dx*, *dy*). 
    # Given a current point of (x, y), `Context#rel_move_to(dx, dy)` is logically equivalent to `Context#move_to(x + dx, y + dy)`. 
    # It is an error to call this method with no current point. Doing so will cause context to shutdown with a status of `Cairo::Status::NO_CURRENT_POINT`. 
    # *dx* : the X offset
    # *dy* : the Y offset
    # Returns self
    def rel_move_to(dx : Int32 | Float64, dy : Int32 | Float64)
      LibCairo.rel_move_to(@pointer.as(LibCairo::Context*), Float64.new(dx), Float64.new(dy))
      self
    end

    # Relative-coordinate version of `Context#line_to()`.
    # Adds a line to the path from the current point to a point that is offset from the current point by (*dx*, *dy*) in user space.
    # After this call the current point will be offset by (*dx*, *dy*). 
    # Given a current point of (x, y), `Context#rel_line_to(dx, dy)` is logically equivalent to `Context#line_to(x + dx, y + dy)`. 
    # It is an error to call this method with no current point. Doing so will cause context to shutdown with a status of `Cairo::Status::NO_CURRENT_POINT`. 
    # *dx* : the X offset to the end of the new line
    # *dy* : the Y offset to the end of the new line
    # Returns self
    def rel_line_to(dx : Int32 | Float64, dy : Int32 | Float64)
      LibCairo.rel_line_to(@pointer.as(LibCairo::Context*), Float64.new(dx), Float64.new(dy))
      self
    end

    # Relative-coordinate version of `Context#curve_to()`. All offsets are relative to the current point.
    # Adds a cubic Bézier spline to the path from the current point to a point offset from the current point by (*dx3*, *dy3*),
    # using points offset by (*dx1*, *dy1*) and (*dx2*, *dy2*) as the control points. After this call the current point will be offset by (*dx3*, *dy3*). 
    # Given a current point of (x, y), `Context#rel_curve_to(dx1, dy1, dx2, dy2, dx3, dy3)` is logically equivalent to `Context#curve_to(x+dx1, y+dy1, x+dx2, y+dy2, x+dx3, y+dy3)`. 
    # It is an error to call this method with no current point. Doing so will cause context to shutdown with a status of `Cairo::Status::NO_CURRENT_POINT`.
    # *dx1* : the X offset to the first control point
    # *dy1* : the Y offset to the first control point
    # *dx2* : the X offset to the second control point
    # *dy2* : the Y offset to of the second control point
    # *dx3* : the X offset to of the end of the curve
    # *dy3* : the Y offset to of the end of the curve
    # Returns self.
    def rel_curve_to(dx1 : Int32 | Float64, dy1 : Int32 | Float64,
                     dx2 : Int32 | Float64, dy2 : Int32 | Float64,
                     dx3 : Int32 | Float64, dy3 : Int32 | Float64)
      LibCairo.rel_curve_to(@pointer.as(LibCairo::Context*), Float64.new(dx1), Float64.new(dy1), Float64.new(dx2),
                                                             Float64.new(dy2), Float64.new(dx3), Float64.new(dy3))
      self
    end

    # Adds a closed sub-path rectangle of the given size to the current path at position (x, y) in user-space coordinates.
    # *x* : the X coordinate of the top left corner of the rectangle
    # *y* : the Y coordinate to the top left corner of the rectangle
    # *width* : the width of the rectangle
    # *height* : the height of the rectangle
    # Returns self.
    def rectangle(x : Int32 | Float64, y : Int32 | Float64, width : Int32 | Float64, height : Int32 | Float64)
      LibCairo.rectangle(@pointer.as(LibCairo::Context*), Float64.new(x), Float64.new(y), Float64.new(width), Float64.new(height))
      self
    end

    # Adds a line segment to the path from the current point to the beginning of the current sub-path,
    # (the most recent point passed to `Context#move_to()`), and closes this sub-path. After this call the current point will be at the joined endpoint of the sub-path. 
    # The behavior of `Context#close_path()` is distinct from simply calling `Context#line_to()` with the equivalent coordinate in the case of stroking.
    # When a closed sub-path is stroked, there are no caps on the ends of the sub-path. Instead, there is a line join connecting the final and initial segments of the sub-path. 
    # If there is no current point before the call to `Context#close_path()`, this function will have no effect. 
    # Returns self.
    def close_path
      LibCairo.close_path(@pointer.as(LibCairo::Context*))
      self
    end

    # Computes a bounding box in user-space coordinates covering the points on the current path.
    # If the current path is empty, returns an empty rectangle ((0,0), (0,0)). Stroke parameters, fill rule, surface dimensions and clipping are not taken into account. 
    # Contrast with `Context#fill_extents()` and `Context#stroke_extents()` which return the extents of only the area that would be "inked" by the corresponding drawing operations. 
    # The result of `Context#path_extents()` is defined as equivalent to the limit of `Context#stroke_extents()` with Cairo::LineCap::ROUND as the line width approaches 0.0,
    # (but never reaching the empty-rectangle returned by `Context#stroke_extents()` for a line width of 0.0). 
    # Specifically, this means that zero-area sub-paths such as `Context#move_to()`,`Context#line_to()` segments, (even degenerate cases where the coordinates to both calls are identical),
    # will be considered as contributing to the extents. However, a lone `Context#move_to()` will not contribute to the results of `Context#path_extents()`. 
    # *x1* : the left of the resulting extents (in/out parameter)
    # *y1* : the top of the resulting extents (in/out parameter)
    # *x2* : the right of the resulting extents (in/out parameter)
    # *y2* : the bottom of the resulting extents (in/out parameter)
    # Returns self.
    def path_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.path_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    # A drawing operator that paints the current source everywhere within the current clip region.
    # Returns self.
    def paint
      LibCairo.paint(@pointer.as(LibCairo::Context*))
      self
    end

    # A drawing operator that paints the current source everywhere within the current clip region using a mask of constant alpha value *alpha*.
    # The effect is similar to `Context#paint()`, but the drawing is faded out using the alpha value.
    # *alpha* : alpha value, between 0 (transparent) and 1 (opaque)
    # Returns self.
    def paint_with_alpha(alpha : Float64)
      LibCairo.paint_with_alpha(@pointer.as(LibCairo::Context*), alpha)
      self
    end

    # A drawing operator that paints the current source using the alpha channel of *pattern* as a mask.
    # (Opaque areas of *pattern* are painted with the source, transparent areas are not painted.)
    # *pattern* : a `Cairo::Pattern`
    # Returns self.
    def mask(pattern : Pattern)
      LibCairo.mask(@pointer.as(LibCairo::Context*), pattern.to_unsafe)
      self
    end

    # A drawing operator that paints the current source using the alpha channel of *surface* as a mask.
    # (Opaque areas of *surface* are painted with the source, transparent areas are not painted.)
    # *surface* : a `Cairo::Surface`
    # *surface_x* : the X coordinate at which to place the origin of surface
    # *surface_y* : the Y coordinate at which to place the origin of surface
    # Returns self.
    def mask_surface(surface : Surface, surface_x : Int32 | Float64, surface_y : Int32 | Float64)
      LibCairo.mask_surface(surface.to_unsafe, Float64.new(surface_x), Float64.new(surface_y))
      self
    end

    # A drawing operator that strokes the current path according to the current line width, line join, line cap, and dash settings.
    # After `Context#stroke()`, the current path will be cleared from the cairo context.
    # See `Context#line_width=()`, `Context#line_join=()`, `Context#line_cap=()`, `Context#set_dash()`, and `Context#stroke_preserve()`. 
    # Note: Degenerate segments and sub-paths are treated specially and provide a useful result. These can result in two different situations: 
    # 1. Zero-length "on" segments set in `Context#set_dash()` :
    #       If the cap style is Cairo::LineCap::ROUND or  Cairo::LineCap::SQUARE then these segments will be drawn as circular dots or squares respectively.
    #       In the case of Cairo::LineCap::SQUARE, the orientation of the squares is determined by the direction of the underlying path. 
    # 2. A sub-path created by `Context#move_to()` followed by either a `Context#close_path()` or one or more calls to `Context#line_to()` to the same coordinate as the `Context#move_to()`.
    #       If the cap style is Cairo::LineCap::ROUND then these sub-paths will be drawn as circular dots.
    #       Note that in the case of Cairo::LineCap::SQUARE a degenerate sub-path will not be drawn at all, (since the correct orientation is indeterminate). 
    # In no case will a cap style of Cairo::LineCap::BUTT cause anything to be drawn in the case of either degenerate segments or sub-paths. 
    # Returns self.
    def stroke
      LibCairo.stroke(@pointer.as(LibCairo::Context*))
      self
    end

    # A drawing operator that strokes the current path according to the current line width, line join, line cap, and dash settings.
    # Unlike `Context#stroke()`, `Context#stroke_preserve()` preserves the path within the cairo context.
    # See `Context#line_width=()`, `Context#line_join=()`, `Context#line_cap=()`, `Context#set_dash()`, and `Context#stroke()`.
    # Returns self.
    def stroke_preserve
      LibCairo.stroke_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    # A drawing operator that fills the current path according to the current fill rule, (each sub-path is implicitly closed before being filled).
    # After `Context#fill()`, the current path will be cleared from the cairo context. See `Context#fill_rule=()` and `Context#fill_preserve()`.
    # Returns self.
    def fill
      LibCairo.fill(@pointer.as(LibCairo::Context*))
      self
    end

    # A drawing operator that fills the current path according to the current fill rule, (each sub-path is implicitly closed before being filled).
    # Unlike `Context#fill()`, `Context#fill_preserve()` preserves the path within the cairo context. 
    # See `Context#fill_rule=()` and `Context#fill()`. 
    # Returns self.
    def fill_preserve
      LibCairo.fill_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    # Emits the current page for backends that support multiple pages, but doesn't clear it, so, the contents of the current page will be retained for the next page too.
    # Use `Context#show_page()` if you want to get an empty page after the emission. 
    # This is a convenience function that simply calls `Cairo::Surface#copy_page()` on context's target. 
    # Returns self.
    def copy_page
      LibCairo.copy_page(@pointer.as(LibCairo::Context*))
      self
    end

    # Emits and clears the current page for backends that support multiple pages.
    # Use `Context#copy_page()` if you don't want to clear the page. 
    # This is a convenience function that simply calls `Cairo::Surface#show_page()` on context's target. 
    # Returns self.
    def show_page
      LibCairo.show_page(@pointer.as(LibCairo::Context*))
      self
    end

    # Tests whether the given point is inside the area that would be affected by a `Context#stroke()` operation given the current path and stroking parameters.
    # Surface dimensions and clipping are not taken into account.
    # *x* : the X coordinate of the point to test
    # *y* : the Y coordinate of the point to test
    # Returns : a true if the point is inside, or false if outside.  
    def in_stroke(x : Int32 | Float64, y : Int32 | Float64) : Bool
      LibCairo.in_stroke(@pointer.as(LibCairo::Context*), Float64.new(x), Float64.new(y)) == 1
    end

    # Tests whether the given point is inside the area that would be affected by a `Context#fill()` operation given the current path and filling parameters.
    # Surface dimensions and clipping are not taken into account.
    # *x* : the X coordinate of the point to test
    # *y* : the Y coordinate of the point to test
    # Returns : a true if the point is inside, or false if outside.  
    def in_fill(x : Int32 | Float64, y : Int32 | Float64) : Bool
      LibCairo.in_fill(@pointer.as(LibCairo::Context*),Float64.new(x), Float64.new(y)) == 1
    end

    # Tests whether the given point is inside the area that would be visible through the current clip, i.e. the area that would be filled by a `Context#paint()` operation.
    # *x* : the X coordinate of the point to test
    # *y* : the Y coordinate of the point to test
    # Returns : a true if the point is inside, or false if outside. 
    def in_clip(x : Int32 | Float64, y : Int32 | Float64) : Bool
      LibCairo.in_clip(@pointer.as(LibCairo::Context*),Float64.new(x), Float64.new(y)) == 1
    end

    # Computes a bounding box in user coordinates covering the area that would be affected, (the "inked" area),
    # by a `Context#stroke()` operation given the current path and stroke parameters.
    # If the current path is empty, returns an empty rectangle ((0,0), (0,0)). Surface dimensions and clipping are not taken into account. 
    # Note that if the line width is set to exactly zero, then `Context#stroke_extents()` will return an empty rectangle.
    # Contrast with `Context#path_extents()` which can be used to compute the non-empty bounds as the line width approaches zero. 
    # Note that `Context#stroke_extents()` must necessarily do more work to compute the precise inked areas in light of the stroke parameters,
    # so `Context#path_extents()` may be more desirable for sake of performance if non-inked path extents are desired. 
    # *x1* : the left of the resulting extents (in/out parameter)
    # *y1* : the top of the resulting extents (in/out parameter)
    # *x2* : the right of the resulting extents (in/out parameter)
    # *y2* : the bottom of the resulting extents (in/out parameter)
    # Returns self.
    def stroke_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.stroke_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    # Computes a bounding box in user coordinates covering the area that would be affected, (the "inked" area),
    # by a `Context#fill()` operation given the current path and fill parameters.
    # If the current path is empty, returns an empty rectangle ((0,0), (0,0)). Surface dimensions and clipping are not taken into account. 
    # Contrast with `Context#path_extents()`, which is similar, but returns non-zero extents for some paths with no inked area, (such as a simple line segment). 
    # Note that `Context#fill_extents()` must necessarily do more work to compute the precise inked areas in light of the fill rule,
    # so `Context#path_extents()` may be more desirable for sake of performance if the non-inked path extents are desired. 
    # *x1* : the left of the resulting extents (in/out parameter)
    # *y1* : the top of the resulting extents (in/out parameter)
    # *x2* : the right of the resulting extents (in/out parameter)
    # *y2* : the bottom of the resulting extents (in/out parameter)
    # Returns self.
    def fill_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*)
      LibCairo.fill_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    # Resets the current clip region to its original, unrestricted state.
    # That is, set the clip region to an infinitely large shape containing the target surface.
    # Equivalently, if infinity is too hard to grasp, one can imagine the clip region being reset to the exact bounds of the target surface. 
    # Note that code meant to be reusable should not call `Context#reset_clip()` as it will cause results unexpected by higher-level code which calls `Context#clip()`.
    # Consider using `Context#save()` and `Context#restore()` around `Context#clip()` as a more robust means of temporarily restricting the clip region. 
    # Returns self.
    def reset_clip
      LibCairo.reset_clip(@pointer.as(LibCairo::Context*))
      self
    end

    # Establishes a new clip region by intersecting the current clip region
    # with the current path as it would be filled by `Context#fill()` and according to the current fill rule (see `Context#fill_rule=()`). 
    # After `Context#clip()`, the current path will be cleared from the cairo context. 
    # The current clip region affects all drawing operations by effectively masking out any changes to the surface that are outside the current clip region. 
    # Calling `Context#clip()` can only make the clip region smaller, never larger.
    # But the current clip is part of the graphics state, so a temporary restriction of the clip region can be achieved by calling `Context#clip()` within a `Context#save()`/`Context#restore()` pair.
    # The only other means of increasing the size of the clip region is `Context#reset_clip()`. 
    # Returns self.
    def clip
      LibCairo.clip(@pointer.as(LibCairo::Context*))
      self
    end

    # Establishes a new clip region by intersecting the current clip region
    # with the current path as it would be filled by `Context#fill()` and according to the current fill rule (see `Context#fill_rule=()`). 
    # Unlike `Context#clip()`, `Context#clip_preserve()` preserves the path within the cairo context. 
    # The current clip region affects all drawing operations by effectively masking out any changes to the surface that are outside the current clip region. 
    # Calling `Context#clip_preserve()` can only make the clip region smaller, never larger.
    # But the current clip is part of the graphics state, so a temporary restriction of the clip region can be achieved by calling `Context#clip_preserve()` within a `Context#save()`/`Context#restore()` pair.
    # The only other means of increasing the size of the clip region is cairo_reset_clip(). 
    # Returns self.
    def clip_preserve
      LibCairo.clip_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    # Computes a bounding box in user coordinates covering the area inside the current clip.
    # *x1* : the left of the resulting extents (in/out parameter)
    # *y1* : the top of the resulting extents (in/out parameter)
    # *x2* : the right of the resulting extents (in/out parameter)
    # *y2* : the bottom of the resulting extents (in/out parameter)
    # Returns self.
    def clip_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*)
      LibCairo.clip_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    # Selects a family and style of font from a simplified description as a family name, slant and weight.
    # Cairo provides no operation to list available family names on the system,
    # but the standard CSS2 generic family names, ("serif", "sans-serif", "cursive", "fantasy", "monospace"), are likely to work as expected. 
    # If family starts with the string "cairo:", or if no native font backends are compiled in, cairo will use an internal font family.
    # The internal font family recognizes many modifiers in the family string, most notably, it recognizes the string "monospace".
    # That is, the family name "cairo:monospace" will use the monospace version of the internal font family. 
    # *family* : a font family name.
    # *slant* : the slant for the font.
    # *weight* : the weight for the font.
    # Returns self.
    def select_font_face(family : String, slant : FontSlant, weight : FontWeight)
      LibCairo.select_font_face(@pointer.as(LibCairo::Context*), family.to_unsafe, slant, weight)
      self
    end

    # Sets the current font matrix to a scale by a factor of size, replacing any font matrix previously set with `Context#font_size=()` or `Context#font_matrix=()`.
    # This results in a font size of size user space units. (More precisely, this matrix will result in the font's em-square being a size by size square in user space.) 
    # If text is drawn without a call to `Context#font_size=()`, (nor `Context#font_matrix=()` nor `Context#scaled_font=()`), the default font size is 10.0. 
    # *size* : the new font size, in user space units.
    # Returns self.
    def font_size=(size : Float64)
      LibCairo.set_font_size(@pointer.as(LibCairo::Context*), size)
      self
    end

    # Returns the current font matrix. 
    def font_matrix : Matrix
      matrix = Matrix.new
      LibCairo.get_font_matrix(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
      matrix
    end

    # Sets the current font matrix to *matrix*.
    # The font matrix gives a transformation from the design space of the font (in this space, the em-square is 1 unit by 1 unit) to user space.
    # Normally, a simple scale is used (see `Context#font_size=()`), but a more complex font matrix can be used to shear the font or stretch it unequally along the two axes.
    # *matrix* :  a `Cairo::Matrix` describing a transform to be applied to the current font.
    # Returns self.
    def font_matrix=(matrix : Matrix)
      LibCairo.set_font_matrix(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
      self
    end

    # Retrieves font rendering options set via `Context#font_options=()`.
    # Note that the returned options do not include any options derived from the underlying surface; they are literally the options passed to `Context#font_options=()`. 
    def font_options : FontOptions
      font_options = FontOptions.new LibCairo::FontOptions.new
      LibCairo.get_font_options(@pointer.as(LibCairo::Context*), font_options.to_unsafe)
      font_options
    end

    # Sets a set of custom font rendering options for the context.
    # Rendering options are derived by merging these options with the options derived from underlying surface;
    # if the value in options has a default value (like Cairo::Antialias::DEFAULT), then the value from the surface is used.
    # *options* : the font options to use.
    # Returns self.
    def font_options=(options : FontOptions)
      LibCairo.set_font_options(@pointer.as(LibCairo::Context*), options.to_unsafe)
      self
    end

    # Returns the current font face for the context.
    def font_face : FontFace
      font_face = LibCairo.get_font_face(@pointer.as(LibCairo::Context*))
      FontFace.new(font_face)
    end

    # Replaces the current cairo_font_face_t object in the cairo_t with font_face.
    # *font_face* : a `Cairo::FontFace`, or nil to restore to the default font.
    # Returns self.
    def font_face=(font_face : FontFace)
      LibCairo.set_font_face(@pointer.as(LibCairo::Context*), font_face.to_unsafe)
      self
    end

    # Returns current scaled font for the context.
    def scaled_font : ScaledFont
      scaled_font = LibCairo.get_scaled_font(@pointer.as(LibCairo::Context*))
      ScaledFont.new(scaled_font)
    end

    # Replaces the current font face, font matrix, and font options in the context with those of the `Cairo::ScaledFont`.
    # Except for some translation, the current CTM of the context should be the same as that of the `Cairo::ScaledFont`, which can be accessed using `Cairo::ScaledFont#ctm()`.
    # *scaled_font* : a Cairo::ScaledFont.
    # Returns self.
    def scaled_font=(scaled_font : ScaledFont)
      LibCairo.set_scaled_font(@pointer.as(LibCairo::Context*), scaled_font.value)
      self
    end

    # A drawing operator that generates the shape from a string of UTF-8 characters, rendered according to the current font_face, font_size (font_matrix), and font_options. 
    # This function first computes a set of glyphs for the string of text. The first glyph is placed so that its origin is at the current point.
    # The origin of each subsequent glyph is offset from that of the previous glyph by the advance values of the previous glyph. 
    # After this call the current point is moved to the origin of where the next glyph would be placed in this same progression.
    # That is, the current point will be at the origin of the final glyph offset by its advance values.
    # This allows for easy display of a single logical string with multiple calls to `Context#show_text()`. 
    # *text* : string of text.
    # Returns self.
    def show_text(text : String)
      LibCairo.show_text(@pointer.as(LibCairo::Context*), text.to_unsafe)
      self
    end

    # Adds closed paths for text to the current path. The generated path if filled, achieves an effect similar to that of `Context#show_text()`. 
    # Text conversion and positioning is done similar to `Context#show_text()`. 
    # Like `Context#show_text()`, after this call the current point is moved to the origin of where the next glyph would be placed in this same progression.
    # That is, the current point will be at the origin of the final glyph offset by its advance values.
    # This allows for chaining multiple calls to to `Context#text_path()` without having to set current point in between. 
    # *text* : string of text.
    # Returns self.
    def text_path(text : String)
      LibCairo.text_path(@pointer.as(LibCairo::Context*), text.to_unsafe)
      self
    end

    # Returns the current compositing operator for the cairo context. 
    def operator : Operator
      Operator.new(LibCairo.get_operator(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current source pattern for the cairo context.
    def source : Pattern
      Pattern.new(LibCairo.get_source(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current tolerance value, as set by `Context#tolerance=()`
    def tolerance : Float64
      LibCairo.get_tolerance(@pointer.as(LibCairo::Context*))
    end

    # Returns the current shape antialiasing mode, as set by `Context#antialias=()`
    def antialias : Antialias
      Antialias.new(LibCairo.get_antialias(@pointer.as(LibCairo::Context*)).value)
    end

    # Returns whether a current point is defined on the current path.
    def has_current_point? : Bool
      LibCairo.has_current_point(@pointer.as(LibCairo::Context*)) == 1
    end

    # Returns the current point of the current path, which is conceptually the final point reached by the path so far. 
    # The current point is returned in the user-space coordinate system.
    # If there is no defined current point or if the context is in an error status, *x* and *y* will both be set to 0.0.
    # It is possible to check this in advance with `Context#has_current_point()`. 
    # *x* : return value for X coordinate of the current point.
    # *y* : return value for Y coordinate of the current point.
    def current_point(x : Float64*, y : Float64*) : Void
      LibCairo.get_current_point(@pointer.as(LibCairo::Context*), x, y)
    end

    # Returns the current fill rule, as set by `Context#fill_rule=()`
    def fill_rule : FillRule
      FillRule.new(LibCairo.get_fill_rule(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current line width value exactly as set by `Context#line_width=()`.
    # Note that the value is unchanged even if the CTM has changed between the calls to `Context#line_width=()` and `Context#line_width()`.
    def line_width : Float64
      LibCairo.get_line_width(@pointer.as(LibCairo::Context*))
    end

    # Returns the current line cap style, as set by `Context#line_cap=()`.
    def line_cap : LineCap
      LineCap.new(LibCairo.get_line_cap(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current line join style, as set by `Context#line_join=()`.
    def line_join : LineJoin
      LineJoin.new(LibCairo.get_line_join(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current miter limit, as set by `Context#miter_limit=()`.
    def miter_limit : Float64
      LibCairo.get_miter_limit(@pointer.as(LibCairo::Context*))
    end

    # Returns the length of the dash array in context (0 if dashing is not currently in effect). 
    def dash_count : Int32
      LibCairo.get_dash_count(@pointer.as(LibCairo::Context*))
    end

    # Returns the current transformation matrix (CTM).     
    def matrix : Matrix
      LibCairo.get_matrix(@pointer.as(LibCairo::Context*), out matrix)
      Matrix.new(matrix)
    end

    # Returns the target surface for the cairo context as passed to `Context#create()`. 
    # This method will always return a valid pointer, but the result can be a "nil" surface if the context is already in an error state,
    # (ie. context.status != Cairo::Status::SUCCESS).
    # A nil surface is indicated by Cairo::Surface.status != Cairo::Status::SUCCESS. 
    def target : Surface
      Surface.new(LibCairo.get_target(@pointer.as(LibCairo::Context*)))
    end

    # Returns the current destination surface for the context.
    # This is either the original target surface as passed to `Context#create()` or the target surface for the current group as started
    # by the most recent call to `Context#push_group()` or `Context#push_group_with_content()`. 
    # This method will always return a valid pointer, but the result can be a "nil" surface if the context is already in an error state,
    # (ie. context.status != Cairo::Status::SUCCESS).
    # A nil surface is indicated by Cairo::Surface.status != Cairo::Status::SUCCESS.
    def group_target : Surface
      Surface.new(LibCairo.get_group_target(@pointer.as(LibCairo::Context*)))
    end

    # Creates a copy of the current path and returns it to the user as a `Cairo::Path`. 
    # This method will always return a valid pointer, but the result will have no data (data==NULL and num_data==0), if either of the following conditions hold: 
    #     1.If there is insufficient memory to copy the path. In this case path.status will be set to Cairo::Status::NO_MEMORY.
    #     2.If the context is already in an error state. In this case path.status will contain the same status that would be returned by `Context#status()`
    def copy_path : Path
      Path.new(LibCairo.copy_path(@pointer.as(LibCairo::Context*)))
    end

    # Returns a flattened copy of the current path and returns it to the user as a `Cairo::Path`. 
    # This function is like `Context#copy_path()` except that any curves in the path will be approximated with piecewise-linear approximations, (accurate to within the current tolerance value).
    # That is, the result is guaranteed to not have any elements of type CAIRO_PATH_CURVE_TO which will instead be replaced by a series of CAIRO_PATH_LINE_TO elements. 
    def copy_path_flat : Path
      Path.new(LibCairo.copy_path_flat(@pointer.as(LibCairo::Context*)))
    end

    # Appends the *path* onto the current path.
    # The path may be either the return value from one of `Context#copy_path()` or `Contex#copy_path_flat()` or it may be constructed manually.
    # See `Cairo::Path` for details on how the path data structure should be initialized, and note that path.status must be initialized to Cairo::Status::SUCCESS.
    # *path* : a Cairo::Path to be appended.
    # Returns self.
    def append(path : Path)
      LibCairo.append_path(@pointer.as(LibCairo::Context*), path.to_unsafe)
      self
    end

    # Checks whether an error has previously occurred for this context.
    def status : Status
      Status.new(LibCairo.status(@pointer.as(LibCairo::Context*)))
    end

    # Returns the extents for a string of text.
    def text_extents(text : String) : TextExtents
      t_e = TextExtents.new  
      LibCairo.text_extents(@pointer.as(LibCairo::Context*), text.to_unsafe, t_e.to_unsafe)
      t_e
    end 

  end
end

