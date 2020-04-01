module Cairo

  # Filter is used to indicate what filtering should be applied when reading pixel values from patterns.
  #    Fast       - a high-performance filter, with quality similar to Cairo::Filter::NEAREST 
  #    Good       - a reasonable-performance filter, with quality similar to Cairo::Filter::BILINEAR
  #    Best       - the highest-quality available, performance may not be suitable for interactive use. 
  #    Nearest    - nearest-neighbor filtering. 
  #    Bilinear   - linear interpolation in two dimensions. 
  #    Gaussian   - this filter value is currently unimplemented, and should not be used in current code. 
  enum Filter : UInt32
    Fast
    Good
    Best
    Nearest
    Bilinear
    Gaussian
  end

end

