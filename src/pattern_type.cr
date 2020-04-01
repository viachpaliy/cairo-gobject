module Cairo

  # PatternType is used to describe the type of a given pattern.
  #   Solid    -  The pattern is a solid (uniform) color. It may be opaque or translucent.
  #   Surface  -  The pattern is a based on a surface (an image).
  #   Linear   -  The pattern is a linear gradient. 
  #   Radial   -  The pattern is a radial gradient. 
  enum PatternType : UInt32
    Solid
    Surface
    Linear
    Radial
    Mesh
    RasterSource
  end
end

