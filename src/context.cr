module Cairo
  class Context
    include GObject::WrappedType

    @pointer : Void*
    
    def initialize(pointer : LibCairo::Context*)
      @pointer = pointer.as(Void*)
    end

    def to_unsafe
      @pointer.not_nil!.as(LibCairo::Context*)
    end
   
    def finalize
      LibCairo.destroy(@pointer.as(LibCairo::Context*))
    end

    def finalize
      LibCairo.destroy(@pointer)
    end

    def reference : Context
      Context.new LibCairo.reference(@pointer)
    end

    def reference_count : UInt32
      LibCairo.get_reference_count(@pointer)
    end

    def user_data(key : LibCairo::UserDataKey*) : Void*
      LibCairo.get_user_data(@pointer, key)
    end

    def set_user_data(key : LibCairo::UserDataKey*, user_data : Void*, destroy : LibCairo::DestroyFunc) : Status
      Status.new(LibCairo.set_user_data(@pointer, key, user_data, destroy).value)
    end

    def save
      LibCairo.save(@pointer)
      self
    end

    def restore
      LibCairo.restore(@pointer)
      self
    end

    def push_group
      LibCairo.push_group(@pointer)
      self
    end

    def push_group_with_content(content : Content)
      LibCairo.push_group_with_content(@pointer, content)
      self
    end

    def pop_group : Pattern
      Pattern.new(LibCairo.pop_group(@pointer))
    end

    def pop_group_to_source : Context
      Context.new(LibCairo.pop_group_to_source(@pointer))
    end

    def operator=(op : Operator)
      LibCairo.set_operator(@pointer, op)
      self
    end

    def source=(source : Pattern)
      LibCairo.set_source(@pointer, source.to_unsafe)
      self
    end

    def set_source_rgb(red : Float64, green : Float64, blue : Float64)
      LibCairo.set_source_rgb(@pointer, red, green, blue)
      self
    end

    def set_source_rgba(red : Float64, green : Float64, blue : Float64, alpha : Float64)
      LibCairo.set_source_rgba(@pointer, red, green, blue, alpha)
      self
    end

    def set_source_surface(surface : Surface, x : Float64, y : Float64)
      LibCairo.set_source_surface(surface.to_unsafe, x, y)
      self
    end

    def tolerance=(tolerance : Float64)
      LibCairo.set_tolerance(@pointer, tolerance)
      self
    end

    def antialias=(antialias : Antialias)
      LibCairo.set_antialias(@pointer, antialias)
      self
    end

    def fill_rule=(fill_rule : FillRule)
      LibCairo.set_fill_rule(@pointer, fill_rule)
      self
    end

    def line_width=(width : Float64)
      LibCairo.set_line_width(@pointer, width)
      self
    end

    def line_cap=(line_cap : LineCap)
      LibCairo.set_line_cap(@pointer, line_cap)
      self
    end

    def line_join=(line_join : LineJoin)
      LibCairo.set_line_join(@pointer, line_join)
      self
    end

    def set_dash(dashes : Array(Float64), offset : Float64)
      LibCairo.set_dash(@pointer, dashes.to_unsafe, dashes.size, offset)
      self
    end

    def miter_limit=(limit : Float64)
      LibCairo.set_miter_limit(@pointer, limit)
      self
    end

    def translate(tx : Float64, ty : Float64)
      LibCairo.translate(@pointer, tx, ty)
      self
    end

    def scale(sx : Float64, sy : Float64)
      LibCairo.scale(@pointer, sx, sy)
      self
    end

    def rotate(angle : Float64)
      LibCairo.rotate(@pointer, angle)
      self
    end

    def transform(matrix : Matrix)
      LibCairo.transform(@pointer, matrix.to_unsafe)
    end

    def matrix=(matrix : Matrix)
      LibCairo.set_matrix(@pointer, matrix.to_unsafe)
      self
    end

    def identity_matrix
      LibCairo.identity_matrix(@pointer)
      self
    end

    def user_to_device(x : Float64*, y : Float64*)  : Void
      LibCairo.user_to_device(@pointer, x, y)
    end

    def user_to_device_distance(x : Float64*, y : Float64*)  : Void
      LibCairo.user_to_device_distance(@pointer, x, y)
    end

    def device_to_user(x : Float64*, y : Float64*)  : Void
      LibCairo.device_to_user(@pointer, x, y)
    end

    def device_to_user_distance(x : Float64*, y : Float64*)  : Void
      LibCairo.device_to_user_distance(@pointer, x, y)
    end

    def new_path
      LibCairo.new_path(@pointer)
      self
    end

    def move_to(x : Float64, y : Float64)
      LibCairo.move_to(@pointer, x, y)
      self
    end
   
    def new_sub_path
      LibCairo.new_sub_path(@pointer)
      self
    end

    def line(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64)
      LibCairo.move_to(@pointer, x1, y1)
      LibCairo.line_to(@pointer, x2, y2)
      self
    end

    def line_to(x : Float64, y : Float64)
      LibCairo.line_to(@pointer, x, y)
      self
    end

    def curve_to(x1 : Float64, y1 : Float64,
                 x2 : Float64, y2 : Float64,
                 x3 : Float64, y3 : Float64)
      LibCairo.curve_to(@pointer, x1, y1, x2, y2, x3, y3)
      self
    end

    def arc(xc : Int32 | Float64, yc : Int32 | Float64, radius : Int32 | Float64,
            angle1 : Float64, angle2 : Float64)
      LibCairo.arc(@pointer, xc, yc, radius, angle1, angle2)
      self
    end

    def arc_negative(xc : Float64, yc : Float64,
                     radius : Float64, angle1 : Float64, angle2 : Float64)
      LibCairo.arc_negative(@pointer, xc, yc, radius, angle1, angle2)
      self
    end

    def rel_move_to(dx : Float64, dy : Float64)
      LibCairo.rel_move_to(@pointer, dx, dy)
      self
    end

    def rel_line_to(dx : Float64, dy : Float64)
      LibCairo.rel_line_to(@pointer, dx, dy)
      self
    end

    def rel_curve_to(dx1 : Float64, dy1 : Float64,
                     dx2 : Float64, dy2 : Float64,
                     dx3 : Float64, dy3 : Float64)
      LibCairo.rel_curve_to(@pointer, dx1, dy1, dx2, dy2, dx3, dy3)
      self
    end

    def rectangle(x : Float64, y : Float64, width : Float64, height : Float64)
      LibCairo.rectangle(@pointer, x, y, width, height)
      self
    end

    def close_path
      LibCairo.close_path(@pointer)
      self
    end

    def path_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.path_extents(@pointer, x1, y1, x2, y2)
      self
    end

    def paint
      LibCairo.paint(@pointer)
      self
    end

    def paint_with_alpha(alpha : Float64)
      LibCairo.paint_with_alpha(@pointer, alpha)
      self
    end

    def mask(pattern : Pattern)
      LibCairo.mask(@pointer, pattern.to_unsafe)
      self
    end

    def mask_surface(surface : Surface, surface_x : Float64, surface_y : Float64)
      LibCairo.mask_surface(surface.to_unsafe, surface_x, surface_y)
      self
    end

    def stroke
      LibCairo.stroke(@pointer)
      self
    end

    def stroke_preserve
      LibCairo.stroke_preserve(@pointer)
      self
    end

    def fill
      LibCairo.fill(@pointer)
      self
    end

    def fill_preserve
      LibCairo.fill_preserve(@pointer)
      self
    end

    def copy_page
      LibCairo.copy_page(@pointer)
      self
    end

    def show_page
      LibCairo.show_page(@pointer)
      self
    end

    def in_stroke(x : Float64, y : Float64) : Bool
      LibCairo.in_stroke(@pointer, x, y) == 1
    end

    def in_fill(x : Float64, y : Float64) : Bool
      LibCairo.in_fill(@pointer, x, y) == 1
    end
     
    def in_clip(x : Float64, y : Float64) : Bool
      LibCairo.in_clip(@pointer, x, y) == 1
    end

    def stroke_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*) 
      LibCairo.stroke_extents(@pointer, x1, y1, x2, y2)
      self
    end

    def fill_extents(x1 : Float64, y1 : Float64, x2 : Float64, y2 : Float64)
      LibCairo.fill_extents(@pointer, x1, y1, x2, y2)
      self
    end

    def reset_clip
      LibCairo.reset_clip(@pointer)
      self
    end

    def clip
      LibCairo.clip(@pointer)
      self
    end

    def clip_preserve
      LibCairo.clip_preserve(@pointer)
      self
    end

    def clip_extents(x1 : Float64*, y1 : Float64*, x2 : Float64*, y2 : Float64*)
      LibCairo.clip_extents(@pointer, x1, y1, x2, y2)
      self
    end
    
    def select_font_face(family : String, slant : FontSlant, weight : FontWeight)
      LibCairo.select_font_face(@pointer, family.to_unsafe, slant, weight)
      self
    end

    def font_size=(size : Float64)
      LibCairo.set_font_size(@pointer, size)
      self
    end

    def font_matrix : Matrix
      matrix = Matrix.new
      LibCairo.get_font_matrix(@pointer, matrix.to_unsafe)
      matrix
    end

    def font_matrix=(matrix : Matrix)
      LibCairo.set_font_matrix(@pointer, matrix.to_unsafe)
      self
    end

    def font_options : FontOptions
      font_options = FontOptions.new
      LibCairo.get_font_options(@pointer, font_options.to_unsafe)
      font_options
    end

    def font_options=(options : FontOptions)
      LibCairo.set_font_options(@pointer, options.to_unsafe)
      self
    end

    def font_face : FontFace
      font_face = LibCairo.get_font_face(@pointer)
      FontFace.new(font_face)
    end

    def font_face=(font_face : FontFace)
      LibCairo.set_font_face(@pointer, font_face.to_unsafe)
      self
    end

    def scaled_font : ScaledFont
      scaled_font = LibCairo.get_scaled_font(@pointer)
      ScaledFont.new(scaled_font)
    end

    def scaled_font=(scaled_font : ScaledFont)
      LibCairo.set_scaled_font(@pointer, scaled_font.value)
      self
    end

    def show_text(text : String)
      LibCairo.show_text(@pointer, text.to_unsafe)
      self
    end
       
    def text_path(text : String)
      LibCairo.text_path(@pointer, text.to_unsafe)
      self
    end
 
    # Query functions

    def operator : Operator
      Operator.new(LibCairo.get_operator(@pointer).value)
    end

    def source : Pattern
      Pattern.new(LibCairo.get_source(@pointer))
    end

    def tolerance : Float64
      LibCairo.get_tolerance(@pointer)
    end

    def antialias : Antialias
      Antialias.new(LibCairo.get_antialias(@pointer).value)
    end

    def has_current_point? : Bool
      LibCairo.has_current_point(@pointer) == 1
    end

    def current_point(x : Float64*, y : Float64*) : Void
      LibCairo.get_current_point(@pointer, x, y)
    end

    def fill_rule : FillRule
      FillRule.new(LibCairo.get_fill_rule(@pointer).value)
    end

    def line_width : Float64
      LibCairo.get_line_width(@pointer)
    end

    def line_cap : LineCap
      LineCap.new(LibCairo.get_line_cap(@pointer).value)
    end

    def line_join : LineJoin
      LineJoin.new(LibCairo.get_line_join(@pointer).value)
    end

    def miter_limit : Float64
      LibCairo.get_miter_limit(@pointer)
    end

    def dash_count : Int32
      LibCairo.get_dash_count(@pointer)
    end
     
    def matrix : Matrix
      LibCairo.get_matrix(@pointer, out matrix)
      Matrix.new(matrix)
    end

    def target : Surface
      Surface.new(LibCairo.get_target(@pointer))
    end

    def group_target : Surface
      Surface.new(LibCairo.get_group_target(@pointer))
    end

    def copy_path : Path
      Path.new(LibCairo.copy_path(@pointer))
    end

    def copy_path_flat : Path
      Path.new(LibCairo.copy_path_flat(@pointer))
    end

    def append(path : Path)
      LibCairo.append_path(@pointer, path.to_unsafe)
      self
    end

    def status : Status
      Status.new(LibCairo.status(@pointer).value)
    end


  end
end

