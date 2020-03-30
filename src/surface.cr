module Cairo

  # Base class for surfaces.
  class Surface
    
    def finalize
      LibCairo.surface_destroy(@pointer.as(LibCairo::Surface*))
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
      Surface.new(LibCairo.surface_create_similar(@pointer, content, width, height))
    end

    def create_similar_image(format : Format, width : Int32, height : Int32) : Surface
      Surface.new(LibCairo.surface_create_similar_image(@pointer, format, width, height))
    end

    def map_to_image(extents : RectangleInt?) : Surface
      if extents.is_a(RectangleInt)
        Surface.new(LibCairo.surface_map_to_image(@pointer, extents.as(RectangleInt).to_unsafe))
      else
        Surface.new(LibCairo.surface_map_to_image(@pointer, nil))
      end
    end

    def unmap_image(image : Surface)
      LibCairo.surface_unmap_image(@pointer, image.to_unsafe)
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
      Surface.new(LibCairo.surface_create_for_rectangle(@pointer, x, y, width, height))
    end

    # Writes the contents of surface to a new file *filename* as a PNG image.
    # Returns : Cairo::`Status`::SUCCESS if the PNG file was written successfully.
    # Otherwise, Cairo::`Status`::NO_MEMORY if memory could not be allocated for the operation
    # or Cairo::`Status`::SURFACE_TYPE_MISMATCH if the surface does not have pixel contents,
    # or Cairo::`Status`::WRITE_ERROR if an I/O error occurs while attempting to write the file. 
    def write_to_png( filename ) : Status
      __return_value = LibCairo.surface_write_to_png(@pointer.as(LibCairo::Surface*) , filename.to_unsafe)
      __return_value
    end

    # Increases the reference count on surface by one.
    def reference : Surface
      Surface.new(LibCairo.surface_reference(@pointer))
    end

    # This method finishes the surface and drops all references to external resources.
    # For example, for the Xlib backend it means that cairo will no longer access the drawable,
    # which can be freed. After calling cairo_surface_finish() the only valid operations on a surface are getting and setting user,
    # referencing and destroying, and flushing and finishing it.
    # Further drawing to the surface will not affect the surface but will instead trigger a Cairo::Status::SURFACE_FINISHED error.
    # Returns this surface.
    def finish
      LibCairo.surface_finish(@pointer)
      self
    end

    # Returns the device for a surface.
    def device : Device
      Device.new(LibCairo.surface_get_device(@pointer))
    end

    # Returns the current reference count of surface. 
    def reference_count : UInt32
      LibCairo.surface_get_reference_count(@pointer)
    end

    # Checks whether an error has previously occurred for this surface.
    # Returns a new Cairo::Status.
    def status : Status
      Status.new(LibCairo.surface_status(@pointer).value)
    end

    # Returns the type of the backend used to create a surface.
    def get_type : SurfaceType
      SurfaceType.new(LibCairo.surface_get_type(@pointer).value)
    end

    # Returns the `Content` type of surface which indicates whether the surface contains color and/or alpha information.
    def content : Content
      Content.new(LibCairo.surface_get_content(@pointer).value)
    end

    # Writes the image surface to the write function.
    # *write_func* : LibCairo::WriteFunc is the type of function which is called when a backend needs to write data to an output stream.
    # *write_func* is passed the *closure* which was specified by the user at the time the write function was registered, the data to write and the length of the data in bytes.
    # Returns : Cairo::Status::SUCCESS if the PNG file was written successfully. Otherwise, Cairo::Status::NO_MEMORY is returned if memory could not be allocated for the operation,
    # Cairo::Status::SURFACE_TYPE_MISMATCH if the surface does not have pixel contents. 
    def write_to_png_stream(write_func : LibCairo::WriteFunc, closure : Void*) : Status
      Status.new(LibCairo.surface_write_to_png_stream(@pointer, write_func, closure).value)
    end

    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.surface_get_user_data(@pointer, key)
    end

    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.surface_set_user_data(@pointer, key, user_data, destroy).value)
    end

    def mime_data(mime_type : String) : Bytes
      LibCairo.surface_get_mime_data(@pointer, mime_type.to_unsafe, out data, out length)
      Bytes.new(data, length)
    end

    def set_mime_data(mime_type : String, data : Bytes, destroy : LibCairo::DestroyFunc, closure : Void*) : Status
      Status.new(LibCairo.surface_set_mime_data(@pointer, mime_type.to_unsafe,
        data.to_unsafe, data.size, destroy, closure).value)
    end

    def supports_mime_type?(mime_type : String) : Bool
      LibCairo.surface_supports_mime_type(@pointer, mime_type.to_unsafe) == 1
    end

    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.surface_get_font_options(@pointer, font_options.to_unsafe)
      font_options
    end

    def flush
      LibCairo.surface_flush(@pointer)
      self
    end

    def mark_dirty
      LibCairo.surface_mark_dirty(@pointer)
      self
    end

    def mark_dirty_rectangle(x : Int32, y : Int32, width : Int32, height : Int32)
      LibCairo.surface_mark_dirty_rectangle(@pointer, x, y, width, height)
      self
    end

    def set_device_scale(x_scale : Float64, y_scale : Float64)
      LibCairo.surface_set_device_scale(@pointer, x_scale, y_scale)
      self
    end

    def device_scale(x_scale : Float64*, y_scale : Float64*) : Void
      LibCairo.surface_get_device_scale(@pointer, x_scale, y_scale)
    end
       
    def set_device_offset(x_offset : Float64, y_offset : Float64)
      LibCairo.surface_set_device_offset(@pointer, x_offset, y_offset)
      self
    end

    def device_offset(x_offset : Float64*, y_offset : Float64*) : Void
      LibCairo.surface_get_device_offset(@pointer, x_offset, y_offset)
    end
        
    def set_fallback_resolution(x_pixels_per_inch : Float64, y_pixels_per_inch : Float64)
      LibCairo.surface_set_fallback_resolution(@pointer, x_pixels_per_inch, y_pixels_per_inch)
      self
    end

    def fallback_resolution(x_pixels_per_inch : Float64*, y_pixels_per_inch : Float64*) : Point
      LibCairo.surface_get_fallback_resolution(@pointer, x_pixels_per_inch, y_pixels_per_inch)
      Point.new(x_ppi, y_ppi)
    end
      
    def copy_page
      LibCairo.surface_copy_page(@pointer)
      self
    end

    def surface_show_page
      LibCairo.surface_show_page(@pointer)
      self
    end

    def has_show_text_glyphs? : Bool
      LibCairo.surface_has_show_text_glyphs(@pointer) == 1
    end

    def data : String
      String.new(LibCairo.image_surface_get_data(@pointer))
    end

    def format : Format
      Format.new(LibCairo.image_surface_get_format(@pointer).value)
    end

    def width : Int32
      LibCairo.image_surface_get_width(@pointer)
    end

    def height : Int32
      LibCairo.image_surface_get_height(@pointer)
    end

    def stride : Int32
      LibCairo.image_surface_get_stride(@pointer)
    end

  end
end

