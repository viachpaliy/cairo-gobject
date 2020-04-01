module Cairo

  # Extend is used to describe how pattern color/alpha will be determined for areas "outside" the pattern's natural area,
  # (for example, outside the surface bounds or outside the gradient geometry). 
  # The default extend mode is Cairo::Extend::NONE for surface patterns and Cairo::Extend::PAD for gradient patterns. 
  #    None      -  pixels outside of the source pattern are fully transparent
  #    Repeat    -  the pattern is tiled by repeating
  #    Reflect   -  the pattern is tiled by reflecting at the edges (Implemented for surface patterns since 1.6) 
  #    Pad       -  pixels outside of the pattern copy the closest pixel from the source (Since 1.2; but only implemented for surface patterns since 1.6) 
  enum Extend : UInt32
    None
    Repeat
    Reflect
    Pad
  end
end

