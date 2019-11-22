module Cairo
  class Surface
    include GObject::WrappedType

    @pointer : Void*
    def initialize(pointer : LibCairo::Surface*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::Surface*)
    end
    
    def finalize
      LibCairo.surface_destroy(@pointer.as(LibCairo::Surface*))
    end

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

    def create_for_rectangle(x : Float64, y : Float64, width : Float64, height : Float64) : Surface
      Surface.new(LibCairo.surface_create_for_rectangle(@pointer, x, y, width, height))
    end


    def write_to_png( filename ) : Status
      __return_value = LibCairo.surface_write_to_png(@pointer.as(LibCairo::Surface*) , filename.to_unsafe)
      __return_value
    end
    
    def reference : Surface
      Surface.new(LibCairo.surface_reference(@pointer))
    end

    def finish
      LibCairo.surface_finish(@pointer)
      self
    end

    def device : Device
      Device.new(LibCairo.surface_get_device(@pointer))
    end

    def reference_count : UInt32
      LibCairo.surface_get_reference_count(@pointer)
    end

    def status : Status
      Status.new(LibCairo.surface_status(@pointer).value)
    end

    def get_type : SurfaceType
      SurfaceType.new(LibCairo.surface_get_type(@pointer).value)
    end

    def content : Content
      Content.new(LibCairo.surface_get_content(@pointer).value)
    end

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

