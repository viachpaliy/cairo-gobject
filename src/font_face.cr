module Cairo
  class FontFace
    include GObject::WrappedType

    @pointer : Void*
    def initialize(pointer : LibCairo::FontFace*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::FontFace*)
    end

    def finalize
      LibCairo.font_face_destroy(@pointer.as(LibCairo::FontFace*))
    end

    def reference : FontFace
      FontFace.new(LibCairo.font_face_reference(@pointer.as(LibCairo::FontFace*)))
    end

    def reference_count : UInt32
      LibCairo.font_face_get_reference_count(@pointer.as(LibCairo::FontFace*))
    end

    def status : Status
      Status.new(LibCairo.font_face_status(@pointer.as(LibCairo::FontFace*)).value)
    end

    def type : FontType
      FontType.new(LibCairo.font_face_get_type(@pointer.as(LibCairo::FontFace*)).value)
    end

    def user_data(key : LibCairo::UserDataKey) : Void*
      LibCairo.font_face_get_user_data(@pointer.as(LibCairo::FontFace*), key)
    end

    def set_user_data(key : LibCairo::UserDataKey, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.font_face_set_user_data(@pointer.as(LibCairo::FontFace*), key, user_data, destroy).value)
    end

    def create_scaled_font(font_matrix : Matrix, ctm : Matrix, options : FontOptions) : ScaledFont
      ScaledFont.new(LibCairo.scaled_font_create(@pointer.as(LibCairo::FontFace*), font_matrix.to_unsafe, ctm.to_unsafe, options.to_unsafe))
    end

    # Create Toy Font Face
    def initialize(family : String, slant : FontSlant, weight : FontWeight)
      @pointer= LibCairo.toy_font_face_create(family.to_unsafe,
        LibCairo::FontSlant.new(slant.value),
        LibCairo::FontWeight.new(weight.value)).as(LibCairo::FontFace*)
    end

    def family : String
      String.new(LibCairo.toy_font_face_get_family(@pointer.as(LibCairo::FontFace*)))
    end

    def slant : FontSlant
      FontSlant.new(LibCairo.toy_font_face_get_slant(@pointer.as(LibCairo::FontFace*)).value)
    end

    def weight : FontWeight
      FontWeight.new(LibCairo.toy_font_face_get_weight(@pointer.as(LibCairo::FontFace*)).value)
    end

    def init_func : LibCairo::UserScaledFontInitFunc
      LibCairo.user_font_face_get_init_func(@pointer.as(LibCairo::FontFace*))
    end

    def init_func=(init_func : LibCairo::UserScaledFontInitFunc)
      LibCairo.user_font_face_set_init_func(@pointer.as(LibCairo::FontFace*), init_func)
      self
    end

    def render_glyph_func : LibCairo::UserScaledFontRenderGlyphFunc
      LibCairo.user_font_face_get_render_glyph_func(@pointer.as(LibCairo::FontFace*))
    end

    def render_glyph_func=(render_glyph_func : LibCairo::UserScaledFontRenderGlyphFunc)
      LibCairo.user_font_face_set_render_glyph_func(@pointer.as(LibCairo::FontFace*), render_glyph_func)
      self
    end
      
    def user_font_face_get_unicode_to_glyph_func : LibCairo::UserScaledFontUnicodeToGlyphFunc
      LibCairo.user_font_face_get_unicode_to_glyph_func(@pointer.as(LibCairo::FontFace*))
    end

    def unicode_to_glyph_func=(unicode_to_glyph_func : LibCairo::UserScaledFontUnicodeToGlyphFunc)
      LibCairo.user_font_face_set_unicode_to_glyph_func(@pointer.as(LibCairo::FontFace*), unicode_to_glyph_func)
      self
    end



  end
end

