module Cairo

  # Represents a realization of a font face at a particular size and transformation and a certain set of font options. 
  class ScaledFont

    include GObject::WrappedType

    @pointer : Void*
    def initialize(pointer : LibCairo::ScaledFont*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::ScaledFont*)
    end

    def finalize
      LibCairo.scaled_font_destroy(@pointer.as(LibCairo::ScaledFont*))
    end

    # Increases the reference count on ScaledFont by one.
    # Returns : the referenced Cairo::ScaledFont 
    def reference : ScaledFont
      ScaledFont.new(LibCairo.scaled_font_reference(@pointer.as(LibCairo::ScaledFont*)))
    end

    # Returns the current reference count of ScaledFont. 
    def reference_count : UInt32
      LibCairo.scaled_font_get_reference_count(@pointer.as(LibCairo::ScaledFont*))
    end

    # Checks whether an error has previously occurred for this ScaledFont.
    # Returns : Cairo::Status::SUCCESS or another error such as Cairo::Status::NO_MEMORY.  
    def status : Status
      Status.new(LibCairo.scaled_font_status(@pointer.as(LibCairo::ScaledFont*)))
    end

    # Returns the type of the backend used to create a scaled font. 
    def type : FontType
      FontType.new(LibCairo.scaled_font_get_type(@pointer.as(LibCairo::ScaledFont*)))
    end

    # Return user data previously attached to ScaledFont using the specified key.
    # If no user data has been attached with the given key this function returns nil.
    # *key* : the address of the LibCairo::UserDataKey the user data was attached to.
    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.scaled_font_get_user_data(@pointer.as(LibCairo::ScaledFont*), key)
    end

    # Attach user data to ScaledFont.
    # To remove user data from a surface, call this method with the key that was used to set it and nil for data.
    # *key* : the address of a LibCairo::UserDataKey to attach the user data to.
    # *user_data* :  the user data to attach to the ScaledFont.
    # *destroy* : a LibCairo::DestroyFunc which will be called when the ScaledFont is destroyed or when new user data is attached using the same key.
    # Returns : Cairo::Status::SUCCESS or Cairo::Status::NO_MEMORY if a slot could not be allocated for the user data.
    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : DestroyFunc) : Status
      Status.new(LibCairo.scaled_font_set_user_data(@pointer.as(LibCairo::ScaledFont*), key, user_data, destroy).value)
    end

    # Returns a Cairo::`FontExtents` which to store the metrics for a Cairo::ScaledFont.
    def extents : Cairo::FontExtents
      LibCairo.scaled_font_extents(@pointer.as(LibCairo::ScaledFont*), out font_extents)
      FontExtents.new(font_extents.as(LibCairo::FontExtents*))
    end

    # Returns a Cairo::`TextExtents` which to store the extents for a string of text.
    # The extents describe a user-space rectangle that encloses the "inked" portion of the text drawn at the origin (0,0)
    # (as it would be drawn by `Context#show_text()` if the cairo graphics state were set
    #  to the same `#font_face`, `#font_matrix`, `#ctm`, and `#font_options` as scaled_font).
    # Additionally, the `TextExtents#x_advance` and `TextExtents#y_advance` values indicate the amount
    # by which the current point would be advanced by `Context#show_text()`.
    # Note that whitespace characters do not directly contribute to the size of the rectangle (extents.width and extents.height).
    #  They do contribute indirectly by changing the position of non-whitespace characters.
    #  In particular, trailing whitespace characters are likely to not affect the size of the rectangle, though they will affect the x_advance and y_advance values.
    #  *text* : a string of text.  
    def text_extents(text : String) : Cairo::TextExtents
      LibCairo.scaled_font_text_extents(@pointer.as(LibCairo::ScaledFont*), text.to_unsafe, out text_extents)
      TextExtents.new(text_extents.as(LibCairo::TextExtents*))
    end

    # Returns the FontFace that this ScaledFont uses.
    def font_face : FontFace
      FontFace.new(LibCairo.scaled_font_get_font_face(@pointer.as(LibCairo::ScaledFont*)))
    end

    # Returns the font Matrix with which ScaledFont was created. 
    def font_matrix : Matrix
      LibCairo.scaled_font_get_font_matrix(@pointer.as(LibCairo::ScaledFont*), out matrix)
      Matrix.new(matrix)
    end

    # Returns the current transformation matrix (CTM) with which ScaledFont was created. 
    def ctm : Matrix
      LibCairo.scaled_font_get_ctm(@pointer.as(LibCairo::ScaledFont*), out ctm)
      Matrix.new(ctm)
    end

    # Returns the scale Matrix of ScaledFont.
    def scale_matrix : Matrix
      LibCairo.scaled_font_get_scale_matrix(@pointer.as(LibCairo::ScaledFont*), out matrix)
      Matrix.new(matrix)
    end

    # Returns the font options with which ScaledFont was created.
    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.scaled_font_get_font_options(@pointer.as(LibCairo::ScaledFont*), font_options.to_unsafe)
      font_options
    end

  end
end

