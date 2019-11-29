module Cairo
  class FontOptions

    def finalize
      LibCairo.font_options_destroy(@pointer.as(LibCairo::FontOptions*))
    end

    def dup : FontOptions
      FontOptions.new(LibCairo.font_options_copy(@pointer.as(LibCairo::FontOptions*)))
    end

    def status : Status
      Status.new(LibCairo.font_options_status(@pointer.as(LibCairo::FontOptions*)))
    end

    def merge(other : FontOptions)
      LibCairo.font_options_merge(@pointer.as(LibCairo::FontOptions*), other.to_unsafe)
      self
    end

    def equals(other : FontOptions) : Bool
      LibCairo.font_options_equal(@pointer.as(LibCairo::FontOptions*), other.to_unsafe) == 1
    end

    def hash : UInt64
      LibCairo.font_options_hash(@pointer.as(LibCairo::FontOptions*))
    end

    def antialias : Antialias
      Antialias.new(LibCairo.font_options_get_antialias(@pointer.as(LibCairo::FontOptions*)).value)
    end

    def antialias=(antialias : Antialias)
      LibCairo.font_options_set_antialias(@pointer.as(LibCairo::FontOptions*), LibCairo::Antialias.new(antialias.value))
      self
    end

    def subpixel_order : SubpixelOrder
      SubpixelOrder.new(LibCairo.font_options_get_subpixel_order(@pointer.as(LibCairo::FontOptions*)).value)
    end

    def subpixel_order=(subpixel_order : SubpixelOrder)
      LibCairo.font_options_set_subpixel_order(@pointer.as(LibCairo::FontOptions*), LibCairo::SubpixelOrder.new(subpixel_order.value))
      self
    end

    def hint_style : HintStyle
      HintStyle.new(LibCairo.font_options_get_hint_style(@pointer.as(LibCairo::FontOptions*)).value)
    end

    def hint_style=(hint_style : HintStyle)
      LibCairo.font_options_set_hint_style(@pointer.as(LibCairo::FontOptions*), LibCairo::HintStyle.new(hint_style.value))
      self
    end

    def hint_metrics : HintMetrics
      HintMetrics.new(LibCairo.font_options_get_hint_metrics(@pointer.as(LibCairo::FontOptions*)).value)
    end

    def hint_metrics=(hint_metrics : HintMetrics)
      LibCairo.font_options_set_hint_metrics(@pointer.as(LibCairo::FontOptions*), LibCairo::HintMetrics.new(hint_metrics.value))
      self
    end

  end
end

