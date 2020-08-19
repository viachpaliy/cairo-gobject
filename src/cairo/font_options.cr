module Cairo

  # The font options specify how fonts should be rendered.
  class FontOptions

    include GObject::WrappedType

    @pointer : Void*
    def initialize(pointer : LibCairo::FontOptions*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::FontOptions*)
    end

    def finalize
      LibCairo.font_options_destroy(@pointer.as(LibCairo::FontOptions*))
    end

    def dup : FontOptions
      FontOptions.new(LibCairo.font_options_copy(@pointer.as(LibCairo::FontOptions*)))
    end

    # Checks whether an error has previously occurred for this font options object.
    # Returns : Cairo::Status::SUCCESS or another error such as Cairo::Status::NO_MEMORY.
    def status : Status
      Status.new(LibCairo.font_options_status(@pointer.as(LibCairo::FontOptions*)))
    end

    # Merges non-default options from other into self, replacing existing values.
    # *other* : another FontOptions.
    # Returns this FontOptions.
    def merge(other : FontOptions)
      LibCairo.font_options_merge(@pointer.as(LibCairo::FontOptions*), other.to_unsafe)
      self
    end

    # Compares two font options objects for equality.
    # *other* : another FontOptions.
    # Returns : true if all fields of the two font options objects match. Note that this function will return false if either object is in error.  
    def equals(other : FontOptions) : Bool
      LibCairo.font_options_equal(@pointer.as(LibCairo::FontOptions*), other.to_unsafe) == 1
    end

    # Compute a hash for the font options object; this value will be useful when storing an object containing a FontOptions in a hash table.
    # Returns : the hash value for the font options object.  
    def hash : UInt64
      LibCairo.font_options_hash(@pointer.as(LibCairo::FontOptions*))
    end

    # Returns the antialiasing mode for the font options object. 
    def antialias : Antialias
      Antialias.new(LibCairo.font_options_get_antialias(@pointer.as(LibCairo::FontOptions*)))
    end

    # Sets the antialiasing mode for the font options object. This specifies the type of antialiasing to do when rendering text.
    # *antialias* : the new antialiasing mode. 
    def antialias=(antialias : Antialias)
      LibCairo.font_options_set_antialias(@pointer.as(LibCairo::FontOptions*), LibCairo::Antialias.new(antialias.value))
      self
    end

    # Returns the subpixel order for the font options object.
    def subpixel_order : SubpixelOrder
      SubpixelOrder.new(LibCairo.font_options_get_subpixel_order(@pointer.as(LibCairo::FontOptions*)))
    end

    # Sets the subpixel order for the font options object.
    # The subpixel order specifies the order of color elements within each pixel on the display device
    # when rendering with an antialiasing mode of Cairo::Antialias::SUBPIXEL.
    # *subpixel_order* : the new subpixel order.
    def subpixel_order=(subpixel_order : SubpixelOrder)
      LibCairo.font_options_set_subpixel_order(@pointer.as(LibCairo::FontOptions*), LibCairo::SubpixelOrder.new(subpixel_order.value))
      self
    end

    # Returns the hint style for font outlines for the font options object. 
    def hint_style : HintStyle
      HintStyle.new(LibCairo.font_options_get_hint_style(@pointer.as(LibCairo::FontOptions*)))
    end

    # Sets the hint style for font outlines for the font options object.
    # This controls whether to fit font outlines to the pixel grid, and if so, whether to optimize for fidelity or contrast.
    # *hint_style* :  the new hint style.  
    def hint_style=(hint_style : HintStyle)
      LibCairo.font_options_set_hint_style(@pointer.as(LibCairo::FontOptions*), LibCairo::HintStyle.new(hint_style.value))
      self
    end

    # Returns the metrics hinting mode for the font options object.
    def hint_metrics : HintMetrics
      HintMetrics.new(LibCairo.font_options_get_hint_metrics(@pointer.as(LibCairo::FontOptions*)))
    end

    # Sets the metrics hinting mode for the font options object.
    # This controls whether metrics are quantized to integer values in device units.
    # *hint_metrics* : the new metrics hinting mode.
    def hint_metrics=(hint_metrics : HintMetrics)
      LibCairo.font_options_set_hint_metrics(@pointer.as(LibCairo::FontOptions*), LibCairo::HintMetrics.new(hint_metrics.value))
      self
    end

  end
end

