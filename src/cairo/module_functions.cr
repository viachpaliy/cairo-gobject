module Cairo
  
  # Creates a PDF surface of the specified size in points to be written to *filename*. 
  # Returns - a instance of Cairo::Surface.
  # Parameters :
  #   *filename* - a filename for the PDF output
  #   *width* - width of the surface, in points (1 point == 1/72.0 inch)
  #   *height* - height of the surface, in points (1 point == 1/72.0 inch)
  def self.pdf_surface_create(filename, width, height)
    __return_value = LibCairo.pdf_surface_create(filename.to_unsafe, Float64.new(width), Float64.new(height))
    Cairo::Surface.new(__return_value)
  end
  
  # Creates a SVG surface of the specified size in points to be written to *filename*. 
  # Returns - a instance of Cairo::Surface.
  # Parameters :
  #   *filename* - a filename for the SVG output
  #   *width* - width of the surface, in points (1 point == 1/72.0 inch)
  #   *height* - height of the surface, in points (1 point == 1/72.0 inch)
  def self.svg_surface_create(filename, width, height)
    __return_value = LibCairo.svg_surface_create(filename.to_unsafe, Float64.new(width), Float64.new(height))
    Cairo::Surface.new(__return_value)
  end

end

