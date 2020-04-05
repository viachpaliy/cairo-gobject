module Cairo

  # Base class for surfaces.
  class Surface
    
    def finalize
      LibCairo.surface_destroy(@pointer.as(LibCairo::Surface*))
    end
    
    # Reads PNG file and cretes new surface for image.
    # *filename* - the PNG file name.
    # Returns a new Cairo::Surface.
    def self.create_from_png(filename : String)
      Surface.new(LibCairo.surface_create_from_png(filename.to_unsafe))
    end

    # Creates a new surface that is as compatible as possible with an existing surface.
    # For example the new surface will have the same fallback resolution and font options as **self**.
    # Generally, the new surface will also use the same backend as **self**, unless that is not possible for some reason.
    # The type of the returned surface may be examined with `#get_type()`.
    # Initially the surface contents are all 0 (transparent if contents have transparency, black otherwise.)
    #  *content* : the `Content` for the new surface.
    #  *width* : width of the new surface, (in device-space units).
    #  *height* : height of the new surface (in device-space units).
    # Returns a new surface.
    def create_similar(content : Content, width : Int32, height : Int32) : Surface
      Surface.new(LibCairo.surface_create_similar(@pointer.as(LibCairo::Surface*), content, width, height))
    end

    def create_similar_image(format : Format, width : Int32, height : Int32) : Surface
      Surface.new(LibCairo.surface_create_similar_image(@pointer.as(LibCairo::Surface*), format, width, height))
    end

    def map_to_image(extents : RectangleInt?) : Surface
      if extents.is_a(RectangleInt)
        Surface.new(LibCairo.surface_map_to_image(@pointer.as(LibCairo::Surface*), extents.as(RectangleInt).to_unsafe))
      else
        Surface.new(LibCairo.surface_map_to_image(@pointer.as(LibCairo::Surface*), nil))
      end
    end

    def unmap_image(image : Surface)
      LibCairo.surface_unmap_image(@pointer.as(LibCairo::Surface*), image.to_unsafe)
      self
    end

    # Creates a new surface that is a rectangle within the target surface.
    # All operations drawn to this surface are then clipped and translated onto the target surface.
    # Nothing drawn via this sub-surface outside of its bounds is drawn onto the target surface,
    # making this a useful method for passing constrained child surfaces to library routines that draw directly onto the parent surface,
    # i.e. with no further backend allocations, double buffering or copies.
    # The semantics of subsurfaces have not been finalized yet unless the rectangle is in full device units,
    # is contained within the extents of the target surface, and the target or subsurface's device transforms are not changed.
    #   *x*      : the x-origin of the sub-surface from the top-left of the target surface (in device-space units)
    #   *y*      : the y-origin of the sub-surface from the top-left of the target surface (in device-space units)
    #   *width*  : width of the sub-surface (in device-space units) 
    #   *height* : height of the sub-surface (in device-space units)
    # Returns a new surface.
    def create_for_rectangle(x : Float64, y : Float64, width : Float64, height : Float64) : Surface
      Surface.new(LibCairo.surface_create_for_rectangle(@pointer.as(LibCairo::Surface*), x, y, width, height))
    end

    # Writes the contents of surface to a new file *filename* as a PNG image.
    # Returns : Cairo::`Status`::SUCCESS if the PNG file was written successfully.
    # Otherwise, Cairo::`Status`::NO_MEMORY if memory could not be allocated for the operation
    # or Cairo::`Status`::SURFACE_TYPE_MISMATCH if the surface does not have pixel contents,
    # or Cairo::`Status`::WRITE_ERROR if an I/O error occurs while attempting to write the file. 
    def write_to_png( filename : String ) : Status
      Status.new( LibCairo.surface_write_to_png(@pointer.as(LibCairo::Surface*) , filename.to_unsafe))
    end

    # Increases the reference count on surface by one.
    # Returns : the referenced Cairo::Surface.
    def reference : Surface
      Surface.new(LibCairo.surface_reference(@pointer.as(LibCairo::Surface*)))
    end

    # This method finishes the surface and drops all references to external resources.
    # For example, for the Xlib backend it means that cairo will no longer access the drawable,
    # which can be freed. After calling cairo_surface_finish() the only valid operations on a surface are getting and setting user,
    # referencing and destroying, and flushing and finishing it.
    # Further drawing to the surface will not affect the surface but will instead trigger a Cairo::Status::SURFACE_FINISHED error.
    # Returns this surface.
    def finish
      LibCairo.surface_finish(@pointer.as(LibCairo::Surface*))
      self
    end

    # Returns the device for a surface.
    def device : Device
      Device.new(LibCairo.surface_get_device(@pointer.as(LibCairo::Surface*)))
    end

    # Returns the current reference count of surface. 
    def reference_count : UInt32
      LibCairo.surface_get_reference_count(@pointer.as(LibCairo::Surface*))
    end

    # Checks whether an error has previously occurred for this surface.
    # Returns a new Cairo::Status.
    def status : Status
      Status.new(LibCairo.surface_status(@pointer.as(LibCairo::Surface*)))
    end

    # Returns the type of the backend used to create a surface.
    def get_type : SurfaceType
      SurfaceType.new(LibCairo.surface_get_type(@pointer.as(LibCairo::Surface*)).value)
    end

    # Returns the `Content` type of surface which indicates whether the surface contains color and/or alpha information.
    def content : Content
      Content.new(LibCairo.surface_get_content(@pointer.as(LibCairo::Surface*)))
    end

    # Writes the image surface to the write function.
    # *write_func* : LibCairo::WriteFunc is the type of function which is called when a backend needs to write data to an output stream.
    # *write_func* is passed the *closure* which was specified by the user at the time the write function was registered, the data to write and the length of the data in bytes.
    # *closure* : closure data for the write function.
    # Returns : Cairo::Status::SUCCESS if the PNG file was written successfully. Otherwise, Cairo::Status::NO_MEMORY is returned if memory could not be allocated for the operation,
    # Cairo::Status::SURFACE_TYPE_MISMATCH if the surface does not have pixel contents. 
    def write_to_png_stream(write_func : LibCairo::WriteFunc, closure : Void*) : Status
      Status.new(LibCairo.surface_write_to_png_stream(@pointer.as(LibCairo::Surface*), write_func, closure))
    end

    # Returns user data previously attached to surface using the specified key.
    # If no user data has been attached with the given key this function returns nil.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to. 
    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.surface_get_user_data(@pointer.as(LibCairo::Surface*), key)
    end

    # Attaches user data to surface. To remove user data from a surface, call this function with the key that was used to set it and nil for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the surface.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the surface is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.  
    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.surface_set_user_data(@pointer.as(LibCairo::Surface*), key, user_data, destroy))
    end

    # Returns mime data previously attached to surface using the specified mime type.
    # If no data has been attached with the given mime type, data is set nil.
    # *mime_type* :  the MIME type of the image data 
    def mime_data(mime_type : String) : Bytes
      LibCairo.surface_get_mime_data(@pointer.as(LibCairo::Surface*), mime_type.to_unsafe, out data, out length)
      Bytes.new(data, length)
    end

    # Attach an image in the format mime_type to surface. To remove the data from a surface, call this function with same mime type and NULL for data. 
    # The attached image (or filename) data can later be used by backends which support it (currently: PDF, PS, SVG and Win32 Printing surfaces)
    # to emit this data instead of making a snapshot of the surface. This approach tends to be faster and requires less memory and disk space. 
    # The recognized MIME types are the following: CAIRO_MIME_TYPE_JPEG, CAIRO_MIME_TYPE_PNG, CAIRO_MIME_TYPE_JP2, CAIRO_MIME_TYPE_URI. 
    # See corresponding backend surface docs for details about which MIME types it can handle.
    # Caution: the associated MIME data will be discarded if you draw on the surface afterwards. Use this function with care.
    # *mime_type* : the MIME type of the image data .
    # *data* : the image data to attach to the surface.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the surface is destroyed or when new image data is attached using the same mime type.
    # *closure* : the data to be passed to the destroy notifier .
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.  
    def set_mime_data(mime_type : String, data : Bytes, destroy : LibCairo::DestroyFunc, closure : Void*) : Status
      Status.new(LibCairo.surface_set_mime_data(@pointer.as(LibCairo::Surface*), mime_type.to_unsafe,
                 data.to_unsafe, data.size, destroy, closure))
    end
    
    def supports_mime_type?(mime_type : String) : Bool
      LibCairo.surface_supports_mime_type(@pointer.as(LibCairo::Surface*), mime_type.to_unsafe) == 1
    end
    
    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.surface_get_font_options(@pointer.as(LibCairo::Surface*), font_options.to_unsafe)
      font_options
    end

    # Do any pending drawing for the surface and also restore any temporary modifications cairo has made to the surface's state.
    # This method must be called before switching from drawing on the surface with cairo to drawing on it directly with native APIs.
    # If the surface doesn't support direct access, then this function does nothing.
    # Returns this surface.
    def flush
      LibCairo.surface_flush(@pointer.as(LibCairo::Surface*))
      self
    end

    # Tells cairo that drawing has been done to surface using means other than cairo, and that cairo should reread any cached areas.
    # Note that you must call `#flush()` before doing such drawing.
    # Returns this surface.
    def mark_dirty
      LibCairo.surface_mark_dirty(@pointer.as(LibCairo::Surface*))
      self
    end

    # Like `#mark_dirty()`, but drawing has been done only to the specified rectangle, so that cairo can retain cached contents for other parts of the surface. 
    # Any cached clip set on the surface will be reset by this method, to make sure that future cairo calls have the clip set that they expect. 
    # *x* : X coordinate of dirty rectangle.
    # *y* : Y coordinate of dirty rectangle.
    # *width* : width of dirty rectangle.
    # *height* : height of dirty rectangle.
    # Returns this surface.
    def mark_dirty_rectangle(x : Int32, y : Int32, width : Int32, height : Int32)
      LibCairo.surface_mark_dirty_rectangle(@pointer.as(LibCairo::Surface*), x, y, width, height)
      self
    end

    def set_device_scale(x_scale : Float64, y_scale : Float64)
      LibCairo.surface_set_device_scale(@pointer.as(LibCairo::Surface*), x_scale, y_scale)
      self
    end

    def device_scale(x_scale : Float64*, y_scale : Float64*) : Void
      LibCairo.surface_get_device_scale(@pointer.as(LibCairo::Surface*), x_scale, y_scale)
    end

    # Sets an offset that is added to the device coordinates determined by the CTM when drawing to surface.
    # One use case for this function is when we want to create a cairo_surface_t that redirects drawing for a portion of an onscreen surface
    # to an offscreen surface in a way that is completely invisible to the user of the cairo API.
    # Setting a transformation via `Context#translate()` isn't sufficient to do this, since functions like `Context#device_to_user()` will expose the hidden offset. 
    # Note that the offset affects drawing to the surface as well as using the surface in a source pattern.
    # *x_offset* :  the offset in the X direction, in device units.
    # *y_offset* : the offset in the Y direction, in device units.
    # Returns this surface.
    def set_device_offset(x_offset : Float64, y_offset : Float64)
      LibCairo.surface_set_device_offset(@pointer.as(LibCairo::Surface*), x_offset, y_offset)
      self
    end

    # Returns the previous device offset set by `Surface#set_device_offset()`.
    # *x_offset* :  the offset in the X direction, in device units.
    # *y_offset* : the offset in the Y direction, in device units.
    def device_offset(x_offset : Float64*, y_offset : Float64*) : Void
      LibCairo.surface_get_device_offset(@pointer.as(LibCairo::Surface*), x_offset, y_offset)
    end

    # Sets the horizontal and vertical resolution for image fallbacks. 
    # When certain operations aren't supported natively by a backend,
    # cairo will fallback by rendering operations to an image and then overlaying that image onto the output.
    # For backends that are natively vector-oriented, this function can be used to set the resolution used for these image fallbacks,
    # (larger values will result in more detailed images, but also larger file sizes). 
    # Some examples of natively vector-oriented backends are the ps, pdf, and svg backends. 
    # For backends that are natively raster-oriented, image fallbacks are still possible, but they are always performed at the native device resolution.
    # So this function has no effect on those backends. 
    # Note: The fallback resolution only takes effect at the time of completing a page (with `Context#_show_page()` or `Context#copy_page()`)
    # so there is currently no way to have more than one fallback resolution in effect on a single page. 
    # The default fallback resoultion is 300 pixels per inch in both dimensions. 
    # *x_pixels_per_inch* : horizontal setting for pixels per inch.
    # *y_pixels_per_inch* : vertical setting for pixels per inch.
    # Returns this surface.
    def set_fallback_resolution(x_pixels_per_inch : Float64, y_pixels_per_inch : Float64)
      LibCairo.surface_set_fallback_resolution(@pointer.as(LibCairo::Surface*), x_pixels_per_inch, y_pixels_per_inch)
      self
    end

    # Returns the previous fallback resolution set by `Surface#set_fallback_resolution()`, or default fallback resolution if never set.
    # *x_pixels_per_inch* : horizontal setting for pixels per inch.
    # *y_pixels_per_inch* : vertical setting for pixels per inch. 
    def fallback_resolution(x_pixels_per_inch : Float64*, y_pixels_per_inch : Float64*) : Point
      LibCairo.surface_get_fallback_resolution(@pointer.as(LibCairo::Surface*), x_pixels_per_inch, y_pixels_per_inch)
    end

    # Emits the current page for backends that support multiple pages, but doesn't clear it,
    # so that the contents of the current page will be retained for the next page.
    # Use `Surface#show_page()` if you want to get an empty page after the emission. 
    # There is a convenience method for this that takes a `Context`, namely `Context#copy_page()`.
    # Returns this surface.
    def copy_page
      LibCairo.surface_copy_page(@pointer.as(LibCairo::Surface*))
      self
    end

    # Emits and clears the current page for backends that support multiple pages. Use `Surface#copy_page()` if you don't want to clear the page. 
    # There is a convenience function for this that takes a `Context`, namely `Context#show_page()`. 
    # Returns this surface.
    def show_page
      LibCairo.surface_show_page(@pointer.as(LibCairo::Surface*))
      self
    end

    # Returns whether the surface supports sophisticated `Context#show_text_glyphs()` operations.
    # That is, whether it actually uses the provided text and cluster data to a `Context#show_text_glyphs()` call. 
    # Note: Even if this function returns false, a `Context#show_text_glyphs()` operation targeted at surface will still succeed.
    # It just will act like a `Context#show_glyphs()` operation. Users can use this function to avoid computing UTF-8 text and cluster mapping if the target surface does not use it. 
    # Returns : true if surface supports `Context#_show_text_glyphs()`, false otherwise.  
    def has_show_text_glyphs? : Bool
      LibCairo.surface_has_show_text_glyphs(@pointer.as(LibCairo::Surface*)) == 1
    end

    def data : String
      String.new(LibCairo.image_surface_get_data(@pointer.as(LibCairo::Surface*)))
    end

    def format : Format
      Format.new(LibCairo.image_surface_get_format(@pointer.as(LibCairo::Surface*)))
    end

    # Returns the width of the surface in pixels.
    def width : Int32
      LibCairo.image_surface_get_width(@pointer.as(LibCairo::Surface*))
    end

    # Returns the height of the surface in pixels.
    def height : Int32
      LibCairo.image_surface_get_height(@pointer.as(LibCairo::Surface*))
    end

    # Returns the stride of the image surface in bytes.
    def stride : Int32
      LibCairo.image_surface_get_stride(@pointer.as(LibCairo::Surface*))
    end

  end
end

