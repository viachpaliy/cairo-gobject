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
    # It is an error to call this function with no current point. Doing so will cause context to shutdown with a status of `Cairo::Status::NO_CURRENT_POINT`. 
    # *dx* : the X offset
    # *dy* : the Y offset
    # Returns self
    def rel_move_to(dx : Int32 | Float64, dy : Int32 | Float64)
      LibCairo.rel_move_to(@pointer.as(LibCairo::Context*), Float64.new(dx), Float64.new(dy))
      self
    end

    def rel_line_to(dx : Int32 | Float64, dy : Int32 | Float64)
      LibCairo.rel_line_to(@pointer.as(LibCairo::Context*), Float64.new(dx), Float64.new(dy))
      self
    end

    def rel_curve_to(dx1 : Int32 | Float64, dy1 : Int32 | Float64,
                     dx2 : Int32 | Float64, dy2 : Int32 | Float64,
                     dx3 : Int32 | Float64, dy3 : Int32 | Float64)
      LibCairo.rel_curve_to(@pointer.as(LibCairo::Context*), Float64.new(dx1), Float64.new(dy1), Float64.new(dx2),
                                                             Float64.new(dy2), Float64.new(dx3), Float64.new(dy3))
      self
    end

    def rectangle(x : Int32 | Float64, y : Int32 | Float64, width : Int32 | Float64, height : Int32 | Float64)
      LibCairo.rectangle(@pointer.as(LibCairo::Context*), Float64.new(x), Float64.new(y), Float64.new(width), Float64.new(height))
      self
    end

    def close_path
      LibCairo.close_path(@pointer.as(LibCairo::Context*))
      self
    end

    def path_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.path_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    def paint
      LibCairo.paint(@pointer.as(LibCairo::Context*))
      self
    end

    def paint_with_alpha(alpha : Float64)
      LibCairo.paint_with_alpha(@pointer.as(LibCairo::Context*), alpha)
      self
    end

    def mask(pattern : Pattern)
      LibCairo.mask(@pointer.as(LibCairo::Context*), pattern.to_unsafe)
      self
    end

    def mask_surface(surface : Surface, surface_x : Float64, surface_y : Float64)
      LibCairo.mask_surface(surface.to_unsafe, surface_x, surface_y)
      self
    end

    def stroke
      LibCairo.stroke(@pointer.as(LibCairo::Context*))
      self
    end

    def stroke_preserve
      LibCairo.stroke_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    def fill
      LibCairo.fill(@pointer.as(LibCairo::Context*))
      self
    end

    def fill_preserve
      LibCairo.fill_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    def copy_page
      LibCairo.copy_page(@pointer.as(LibCairo::Context*))
      self
    end

    def show_page
      LibCairo.show_page(@pointer.as(LibCairo::Context*))
      self
    end

    def in_stroke(x : Float64, y : Float64) : Bool
      LibCairo.in_stroke(@pointer.as(LibCairo::Context*), x, y) == 1
    end

    def in_fill(x : Float64, y : Float64) : Bool
      LibCairo.in_fill(@pointer.as(LibCairo::Context*), x, y) == 1
    end
     
    def in_clip(x : Float64, y : Float64) : Bool
      LibCairo.in_clip(@pointer.as(LibCairo::Context*), x, y) == 1
    end

    def stroke_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.stroke_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    def fill_extents(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64)
      LibCairo.fill_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end

    def reset_clip
      LibCairo.reset_clip(@pointer.as(LibCairo::Context*))
      self
    end

    def clip
      LibCairo.clip(@pointer.as(LibCairo::Context*))
      self
    end

    def clip_preserve
      LibCairo.clip_preserve(@pointer.as(LibCairo::Context*))
      self
    end

    def clip_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*)
      LibCairo.clip_extents(@pointer.as(LibCairo::Context*), x1, y1, x2, y2)
      self
    end
    
    def select_font_face(family : String, slant : FontSlant, weight : FontWeight)
      LibCairo.select_font_face(@pointer.as(LibCairo::Context*), family.to_unsafe, slant, weight)
      self
    end

    def font_size=(size : Float64)
      LibCairo.set_font_size(@pointer.as(LibCairo::Context*), size)
      self
    end

    def font_matrix : Matrix
      matrix = Matrix.new
      LibCairo.get_font_matrix(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
      matrix
    end

    def font_matrix=(matrix : Matrix)
      LibCairo.set_font_matrix(@pointer.as(LibCairo::Context*), matrix.to_unsafe)
      self
    end

    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.get_font_options(@pointer.as(LibCairo::Context*), font_options.to_unsafe)
      font_options
    end

    def font_options=(options : FontOptions)
      LibCairo.set_font_options(@pointer.as(LibCairo::Context*), options.to_unsafe)
      self
    end

    def font_face : FontFace
      font_face = LibCairo.get_font_face(@pointer.as(LibCairo::Context*))
      FontFace.new(font_face)
    end

    def font_face=(font_face : FontFace)
      LibCairo.set_font_face(@pointer.as(LibCairo::Context*), font_face.to_unsafe)
      self
    end

    def scaled_font : ScaledFont
      scaled_font = LibCairo.get_scaled_font(@pointer.as(LibCairo::Context*))
      ScaledFont.new(scaled_font)
    end

    def scaled_font=(scaled_font : ScaledFont)
      LibCairo.set_scaled_font(@pointer.as(LibCairo::Context*), scaled_font.value)
      self
    end

    def show_text(text : String)
      LibCairo.show_text(@pointer.as(LibCairo::Context*), text.to_unsafe)
      self
    end
       
    def text_path(text : String)
      LibCairo.text_path(@pointer.as(LibCairo::Context*), text.to_unsafe)
      self
    end
 
    # Query functions

    def operator : Operator
      Operator.new(LibCairo.get_operator(@pointer.as(LibCairo::Context*)).value)
    end

    def source : Pattern
      Pattern.new(LibCairo.get_source(@pointer.as(LibCairo::Context*)))
    end

    def tolerance : Float64
      LibCairo.get_tolerance(@pointer.as(LibCairo::Context*))
    end

    def antialias : Antialias
      Antialias.new(LibCairo.get_antialias(@pointer.as(LibCairo::Context*)).value)
    end

    def has_current_point? : Bool
      LibCairo.has_current_point(@pointer.as(LibCairo::Context*)) == 1
    end

    def current_point(x : Float64*, y : Float64*) : Void
      LibCairo.get_current_point(@pointer.as(LibCairo::Context*), x, y)
    end

    def fill_rule : FillRule
      FillRule.new(LibCairo.get_fill_rule(@pointer.as(LibCairo::Context*)).value)
    end

    def line_width : Float64
      LibCairo.get_line_width(@pointer.as(LibCairo::Context*))
    end

    def line_cap : LineCap
      LineCap.new(LibCairo.get_line_cap(@pointer.as(LibCairo::Context*)).value)
    end

    def line_join : LineJoin
      LineJoin.new(LibCairo.get_line_join(@pointer.as(LibCairo::Context*)).value)
    end

    def miter_limit : Float64
      LibCairo.get_miter_limit(@pointer.as(LibCairo::Context*))
    end

    def dash_count : Int32
      LibCairo.get_dash_count(@pointer.as(LibCairo::Context*))
    end
     
    def matrix : Matrix
      LibCairo.get_matrix(@pointer.as(LibCairo::Context*), out matrix)
      Matrix.new(matrix)
    end

    def target : Surface
      Surface.new(LibCairo.get_target(@pointer.as(LibCairo::Context*)))
    end

    def group_target : Surface
      Surface.new(LibCairo.get_group_target(@pointer.as(LibCairo::Context*)))
    end

    def copy_path : Path
      Path.new(LibCairo.copy_path(@pointer.as(LibCairo::Context*)))
    end

    def copy_path_flat : Path
      Path.new(LibCairo.copy_path_flat(@pointer.as(LibCairo::Context*)))
    end

    def append(path : Path)
      LibCairo.append_path(@pointer.as(LibCairo::Context*), path.to_unsafe)
      self
    end

    def status : Status
      Status.new(LibCairo.status(@pointer.as(LibCairo::Context*)))
    end


  end
end

