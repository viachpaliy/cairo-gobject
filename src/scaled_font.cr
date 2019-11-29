module Cairo
  class ScaledFont

    def finalize
      LibCairo.scaled_font_destroy(@pointer.as(LibCairo::ScaledFont*))
    end

    def reference : ScaledFont
      ScaledFont.new(LibCairo.scaled_font_reference(@pointer.as(LibCairo::ScaledFont*)))
    end

    def reference_count : UInt32
      LibCairo.scaled_font_get_reference_count(@pointer.as(LibCairo::ScaledFont*))
    end

    def status : Status
      Status.new(LibCairo.scaled_font_status(@pointer.as(LibCairo::ScaledFont*)).value)
    end

    def type : FontType
      FontType.new(LibCairo.scaled_font_get_type(@pointer.as(LibCairo::ScaledFont*)).value)
    end

    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.scaled_font_get_user_data(@pointer.as(LibCairo::ScaledFont*), key)
    end

    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : DestroyFunc) : Status
      Status.new(LibCairo.scaled_font_set_user_data(@pointer.as(LibCairo::ScaledFont*), key, user_data, destroy).value)
    end

    def extents : LibCairo::FontExtents
      LibCairo.scaled_font_extents(@pointer.as(LibCairo::ScaledFont*), out font_extents)
      font_extents.as(LibCairo::FontExtents)
    end

    def text_extents(text : String) : LibCairo::TextExtents
      LibCairo.scaled_font_text_extents(@pointer.as(LibCairo::ScaledFont*), text.to_unsafe, out text_extents)
      text_extents.as(LibCairo::TextExtents)
    end
 
    def font_face : FontFace
      FontFace.new(LibCairo.scaled_font_get_font_face(@pointer.as(LibCairo::ScaledFont*)))
    end

    def font_matrix : Matrix
      LibCairo.scaled_font_get_font_matrix(@pointer.as(LibCairo::ScaledFont*), out matrix)
      Matrix.new(matrix)
    end

    def ctm : Matrix
      LibCairo.scaled_font_get_ctm(@pointer.as(LibCairo::ScaledFont*), out ctm)
      Matrix.new(ctm)
    end

    def scale_matrix : Matrix
      LibCairo.scaled_font_get_scale_matrix(@pointer.as(LibCairo::ScaledFont*), out matrix)
      Matrix.new(matrix)
    end

    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.scaled_font_get_font_options(@pointer.as(LibCairo::ScaledFont*), font_options.to_unsafe)
      font_options
    end

  end
end

