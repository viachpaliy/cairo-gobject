module Cairo

  # Represents a particular font at a particular weight, slant, and other characteristic but no size, transformation, or size. 
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

    # Increases the reference count on FontFace by one.
    # Returns : the referenced FontFace.
    def reference : FontFace
      FontFace.new(LibCairo.font_face_reference(@pointer.as(LibCairo::FontFace*)))
    end

    # Returns the current reference count of FontFace. 
    def reference_count : UInt32
      LibCairo.font_face_get_reference_count(@pointer.as(LibCairo::FontFace*))
    end

    # Checks whether an error has previously occurred for this font face.
    # Returns : Cairo::Status::SUCCESS or another error such as Cairo::Status::NO_MEMORY.  
    def status : Status
      Status.new(LibCairo.font_face_status(@pointer.as(LibCairo::FontFace*)))
    end

    # Returns the type of the backend used to create a FontFace.
    def type : FontType
      FontType.new(LibCairo.font_face_get_type(@pointer.as(LibCairo::FontFace*)))
    end

    # Return user data previously attached to FontFace using the specified key.
    # If no user data has been attached with the given key this function returns NULL.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to.
    def user_data(key : LibCairo::UserDataKey) : Void*
      LibCairo.font_face_get_user_data(@pointer.as(LibCairo::FontFace*), key)
    end

    # Attach user data to Font_Face. To remove user data from a font face, call this method with the key that was used to set it and nil for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the FontFace.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the FontFace is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.
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
      FontSlant.new(LibCairo.toy_font_face_get_slant(@pointer.as(LibCairo::FontFace*)))
    end

    def weight : FontWeight
      FontWeight.new(LibCairo.toy_font_face_get_weight(@pointer.as(LibCairo::FontFace*)))
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

