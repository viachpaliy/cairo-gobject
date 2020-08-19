@[Link("cairo-gobject")]
lib LibCairo

  # Version for Ubuntu 19.10 and gir1.2-freedesktop(1.62.0-1)
  # For Linux Mint 19 and Ubuntu 18.04 uncomment Rectangle struct

  #struct Rectangle 
  #  x : Float64
  #  y : Float64
  #  width : Float64
  #  height : Float64
  #end
  

  struct UserDataKey
    unused : Int32
  end

  struct Glyph
    index : UInt64
    x : Float64
    y : Float64
  end

  struct RectangleList
    status : LibCairo::Status
    rectangles : LibCairo::Rectangle*
    num_rectangles : Int32
  end

  struct PathDataHeader
    type : LibCairo::PathDataType
    length : Int32
  end

  struct PathDataPoint
    x, y : Float64
  end

  struct TextExtents
    x_bearing : Float64
    y_bearing : Float64
    width : Float64
    height : Float64
    x_advance : Float64
    y_advance : Float64
  end

  struct FontExtents
    ascent : Float64
    descent : Float64
    height : Float64
    max_x_advance : Float64
    max_y_advance : Float64
  end


  union PathData
    header : LibCairo::PathDataHeader
    point : LibCairo::PathDataPoint
  end

  struct TextCluster
    num_bytes : Int32
    num_glyphs : Int32
  end

  ###########################################
  ##    Functions
  ###########################################

  alias DestroyFunc = Void* -> Void

  alias WriteFunc = Void*, UInt8*, UInt32 -> LibCairo::Status

  alias ReadFunc = Void*, UInt8*, Int32 -> LibCairo::Status

  alias UserScaledFontInitFunc = LibCairo::ScaledFont*, LibCairo::Context*, LibCairo::FontExtents* -> LibCairo::Status

  alias UserScaledFontRenderGlyphFunc = LibCairo::ScaledFont*, UInt64, LibCairo::Context*, LibCairo::TextExtents* -> LibCairo::Status

  alias UserScaledFontUnicodeToGlyphFunc = LibCairo::ScaledFont*, UInt64, UInt64* -> LibCairo::Status
  
  fun create = cairo_create(target : LibCairo::Surface*) : LibCairo::Context*

  fun reference = cairo_reference(cr : LibCairo::Context*) : LibCairo::Context*
  
  fun destroy = cairo_destroy(this : LibCairo::Context*)

  fun get_reference_count = cairo_get_reference_count(cr: LibCairo::Context*) : UInt32
  
  fun get_user_data = cairo_get_user_data(
    cr : LibCairo::Context*,
    key : LibCairo::UserDataKey*
  ) : Void*

    fun set_user_data = cairo_set_user_data(
      cr : LibCairo::Context*,
      key : LibCairo::UserDataKey*,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

  
  fun save = cairo_save(cr : LibCairo::Context*) : Void

  fun restore = cairo_restore(cr : LibCairo::Context*) : Void

  fun push_group = cairo_push_group(cr : LibCairo::Context*) : Void

  fun push_group_with_content = cairo_push_group_with_content( 
    cr : LibCairo::Context*, 
    content : LibCairo::Content 
  ) : Void 

  fun pop_group = cairo_pop_group(cr : LibCairo::Context*) : LibCairo::PatternType

  fun pop_group_to_source = cairo_pop_group_to_source(cr : LibCairo::Context*) : LibCairo::Context*
  
  fun set_operator = cairo_set_operator( 
    cr : LibCairo::Context*, 
    op : LibCairo::Operator
  ) : Void 

  fun set_source = cairo_set_source( 
    cr : LibCairo::Context*, 
    source : LibCairo::Pattern* 
  ) : Void 

  fun set_source_rgb = cairo_set_source_rgb(
    cr : LibCairo::Context*,
    red : Float64,
    green : Float64,
    blue : Float64
  ) : Void 
  
  fun set_source_rgba = cairo_set_source_rgba(
    cr : LibCairo::Context*,
    red : Float64,
    green : Float64,
    blue : Float64,
    alfa : Float64
  ) : Void 

  fun set_source_surface = cairo_set_source_surface( 
    cr : LibCairo::Context*, 
    surface : LibCairo::Surface*, 
    x : Float64, 
    y : Float64 
  ) : Void 

  fun set_tolerance = cairo_set_tolerance( 
    cr : LibCairo::Context*, 
    tolerance : Float64 
  ) : Void 

  fun set_antialias = cairo_set_antialias( 
    cr : LibCairo::Context*, 
    antialias : LibCairo::Antialias 
  ) : Void 

  fun set_fill_rule = cairo_set_fill_rule( 
    cr : LibCairo::Context*, 
    fill_rule : LibCairo::FillRule 
  ) : Void 

  fun set_line_width = cairo_set_line_width(
    cr : LibCairo::Context*,
    width : Float64
  ) : Void 
  
  fun set_line_cap = cairo_set_line_cap( 
    cr : LibCairo::Context*, 
    line_cap : LibCairo::LineCap
  ) : Void 

  fun set_line_join = cairo_set_line_join( 
    cr : LibCairo::Context*, 
    line_join : LibCairo::LineJoin
  ) : Void 

  fun set_dash = cairo_set_dash( 
    cr : LibCairo::Context*, 
    dashes : Float64*, 
    num_dashes : Int32, 
    offset : Float64 
  ) : Void 

  fun set_miter_limit = cairo_set_miter_limit( 
    cr : LibCairo::Context*, 
    limit : Float64 
  ) : Void 

  fun translate = cairo_translate(
    cr : LibCairo::Context*,
     x : Float64 ,
     y : Float64
  ) : Void 
  
  fun scale = cairo_scale( 
    cr : LibCairo::Context*, 
    sx : Float64, 
    sy : Float64 
  ) : Void 

  fun rotate = cairo_rotate( 
    cr : LibCairo::Context*, 
    angle : Float64 
  ) : Void 

  fun transform = cairo_transform( 
    cr : LibCairo::Context*, 
    matrix : LibCairo::Matrix*
  ) : Void 

  fun set_matrix = cairo_set_matrix( 
    cr : LibCairo::Context*, 
    matrix : LibCairo::Matrix* 
  ) : Void 

  fun identity_matrix = cairo_identity_matrix(cr : LibCairo::Context*) : Void

  fun user_to_device = cairo_user_to_device( 
    cr : LibCairo::Context*, 
    x : Float64*, 
    y : Float64* 
  ) : Void 

  fun user_to_device_distance = cairo_user_to_device_distance( 
    cr : LibCairo::Context*, 
    dx : Float64*, 
    dy : Float64* 
  ) : Void 

  fun device_to_user = cairo_device_to_user(
    cr : LibCairo::Context*, 
    x : Float64*, 
    y : Float64* 
  ) : Void

  fun device_to_user_distance = cairo_device_to_user_distance(
    cr : LibCairo::Context*, 
    dx : Float64*, 
    dy : Float64* 
  ) : Void

  fun new_path = cairo_new_path(cr : LibCairo::Context*) : Void

  fun move_to = cairo_move_to(cr : LibCairo::Context*, x : Float64, y : Float64) : Void
  
  fun new_sub_path = cairo_new_sub_path(cr : LibCairo::Context*) : Void

  fun line_to = cairo_line_to(cr : LibCairo::Context*, x : Float64 ,y : Float64) : Void
  
  fun curve_to = cairo_curve_to( 
    cr : LibCairo::Context*, 
    x1 : Float64, 
    y1 : Float64, 
    x2 : Float64, 
    y2 : Float64, 
    x3 : Float64, 
    y3 : Float64 
  ) : Void 
 
  fun arc = cairo_arc(
    cr : LibCairo::Context*,
    xc : Float64,
    yc : Float64,
    radius : Float64,
    angle1 : Float64,
    angle2 : Float64
  ) : Void
  
  fun arc_negative = cairo_arc_negative(
    cr : LibCairo::Context*,
    xc : Float64,
    yc : Float64,
    radius : Float64,
    angle1 : Float64,
    angle2 : Float64
  ) : Void

  fun rel_move_to = cairo_rel_move_to( 
    cr : LibCairo::Context*, 
    dx : Float64, 
    dy : Float64 
  ) : Void 

  fun rel_line_to = cairo_rel_line_to(
    cr : LibCairo::Context*, 
    dx : Float64, 
    dy : Float64 
  ) : Void

  fun rel_curve_to = cairo_rel_curve_to( 
    cr : LibCairo::Context*, 
    dx1 : Float64, 
    dy1 : Float64, 
    dx2 : Float64, 
    dy2 : Float64, 
    dx3 : Float64, 
    dy3 : Float64 
  ) : Void 

  fun rectangle = cairo_rectangle(
    cr : LibCairo::Context*,
    x : Float64,
    y : Float64,
    width : Float64,
    height : Float64
  ) : Void

  fun close_path = cairo_close_path(cr : LibCairo::Context*) : Void

  fun path_extents = cairo_path_extents(
    cr : LibCairo::Context*,
    x1 : Float64*,
    y1 : Float64*,
    x2 : Float64*,
    y2 : Float64*
  ) : Void

  fun paint = cairo_paint(cr : LibCairo::Context*) : Void

  fun paint_with_alpha = cairo_paint_with_alpha(
    cr : LibCairo::Context*,
    alpha : Float64
  ) : Void

  fun mask = cairo_mask(
    cr : LibCairo::Context*,
    pattern : LibCairo::PatternType
  ) : Void

  fun mask_surface = cairo_mask_surface(
    cr : LibCairo::Context*,
    surface : LibCairo::Context*,
    surface_x : Float64,
    surface_y : Float64
  ) : Void

  fun stroke = cairo_stroke(cr : LibCairo::Context*) : Void 
  
  fun stroke_preserve = cairo_stroke_preserve(cr : LibCairo::Context* ) : Void 
  
  fun fill = cairo_fill(cr : LibCairo::Context*) : Void 

  fun fill_preserve = cairo_fill_preserve(cr : LibCairo::Context*) : Void 
  
  fun copy_page = cairo_copy_page(cr : LibCairo::Context*) : Void

  fun show_page = cairo_show_page(cr : LibCairo::Context*) : Void
  
  fun in_stroke = cairo_in_stroke(
    cr : LibCairo::Context*,
    x : Float64,
    y : Float64
  ) : Int32

  fun in_fill = cairo_in_fill(
    cr : LibCairo::Context*,
    x : Float64,
    y : Float64
  ) : Int32

  fun in_clip = cairo_in_clip(
    cr : LibCairo::Context*,
    x : Float64,
    y : Float64
  ) : Int32

  fun stroke_extents = cairo_stroke_extents(
    cr : LibCairo::Context*,
    x1 : Float64*,
    y1 : Float64*,
    x2 : Float64*,
    y2 : Float64*
  ) : Void

  fun fill_extents = cairo_fill_extents(
    cr : LibCairo::Context*,
    x1 : Float64,
    y1 : Float64,
    x2 : Float64,
    y2 : Float64
  ) : Void

  fun reset_clip = cairo_reset_clip(cr : LibCairo::Context*) : Void

  fun clip = cairo_clip(cr : LibCairo::Context*) : Void

  fun clip_preserve = cairo_clip_preserve(cr : LibCairo::Context*) : Void

  fun copy_clip_rectangle_list = cairo_copy_clip_rectangle_list(
    cr : LibCairo::Context*
  ) : LibCairo::RectangleList*

  fun rectangle_list_destroy = cairo_rectangle_list_destroy(
      rectangle_list : LibCairo::RectangleList*
  ) : Void

  fun glyph_allocate = cairo_glyph_allocate(num_glyphs : Int32) : LibCairo::Glyph*

  fun glyph_free = cairo_glyph_free(glyphs : LibCairo::Glyph*) : Void
 
  fun text_cluster_allocate = cairo_text_cluster_allocate(
    num_clusters : Int32
  ) : LibCairo::TextCluster*

  fun text_cluster_free = cairo_text_cluster_free(
    clusters : LibCairo::TextCluster*
  ) : Void
 
  fun font_options_create = cairo_font_options_create(
    ) : LibCairo::FontOptions*

    fun font_options_copy = cairo_font_options_copy(
      original : LibCairo::FontOptions*
    ) : LibCairo::FontOptions*

    fun font_options_destroy = cairo_font_options_destroy(
      options : LibCairo::FontOptions*
    ) : Void

    fun font_options_status = cairo_font_options_status(
      options : LibCairo::FontOptions*
    ) : LibCairo::Status

    fun font_options_merge = cairo_font_options_merge(
      options : LibCairo::FontOptions*,
      other : LibCairo::FontOptions*
    ) : Void

    fun font_options_equal = cairo_font_options_equal(
      options : LibCairo::FontOptions*,
      other : LibCairo::FontOptions*
    ) : Int32

    fun font_options_hash = cairo_font_options_hash(
      options : LibCairo::FontOptions*
    ) : UInt64

    fun font_options_set_antialias = cairo_font_options_set_antialias(
      options : LibCairo::FontOptions*,
      antialias : LibCairo::Antialias
    ) : Void

    fun font_options_get_antialias = cairo_font_options_get_antialias(
      options : LibCairo::FontOptions*
    ) : LibCairo::Antialias

    fun font_options_set_subpixel_order = cairo_font_options_set_subpixel_order(
      options : LibCairo::FontOptions*,
      subpixel_order : LibCairo::SubpixelOrder
    ) : Void

    fun font_options_get_subpixel_order = cairo_font_options_get_subpixel_order(
      options : LibCairo::FontOptions*
    ) : LibCairo::SubpixelOrder

    fun font_options_set_hint_style = cairo_font_options_set_hint_style(
      options : LibCairo::FontOptions*,
      hint_style : LibCairo::HintStyle
    ) : Void

    fun font_options_get_hint_style = cairo_font_options_get_hint_style(
      options : LibCairo::FontOptions*
    ) : LibCairo::HintStyle

    fun font_options_set_hint_metrics = cairo_font_options_set_hint_metrics(
      options : LibCairo::FontOptions*,
      hint_metrics : LibCairo::HintMetrics
    ) : Void

    fun font_options_get_hint_metrics = cairo_font_options_get_hint_metrics(
      options : LibCairo::FontOptions*
    ) : LibCairo::HintMetrics

    fun select_font_face = cairo_select_font_face(
      cr : LibCairo::Context*,
      family : UInt8*,
      slant : LibCairo::FontSlant,
      weight : LibCairo::FontWeight
    ) : Void

    fun set_font_size = cairo_set_font_size(
      cr : LibCairo::Context*,
      size : Float64
    ) : Void

    fun set_font_matrix = cairo_set_font_matrix(
      cr : LibCairo::Context*,
      matrix : LibCairo::Matrix*
    ) : Void

    fun get_font_matrix = cairo_get_font_matrix(
      cr : LibCairo::Context*,
      matrix : LibCairo::Matrix*
    ) : Void

    fun set_font_options = cairo_set_font_options(
      cr : LibCairo::Context*,
      options : LibCairo::FontOptions*
    ) : Void

    fun get_font_options = cairo_get_font_options(
      cr : LibCairo::Context*,
      options : LibCairo::FontOptions*
    ) : Void

    fun set_font_face = cairo_set_font_face(
      cr : LibCairo::Context*,
      font_face : LibCairo::FontFace*
    ) : Void

    fun get_font_face = cairo_get_font_face(
      cr : LibCairo::Context*
    ) : LibCairo::FontFace*

    fun set_scaled_font = cairo_set_scaled_font(
      cr : LibCairo::Context*,
      scaled_font : LibCairo::ScaledFont*
    ) : Void

    fun get_scaled_font = cairo_get_scaled_font(
      cr : LibCairo::Context*
    ) : LibCairo::ScaledFont*

    fun show_text = cairo_show_text(
      cr : LibCairo::Context*,
      utf8 : UInt8*
    ) : Void

    fun show_glyphs = cairo_show_glyphs(
      cr : LibCairo::Context*,
      glyphs : LibCairo::Glyph*,
      num_glyphs : Int32
    ) : Void

    fun show_text_glyphs = cairo_show_text_glyphs(
      cr : LibCairo::Context*,
      utf8 : UInt8*,
      utf8_len : Int32,
      glyphs : LibCairo::Glyph*,
      num_glyphs : Int32,
      clusters : LibCairo::TextCluster*,
      num_clusters : Int32,
      cluster_flags : LibCairo::TextClusterFlags
    ) : Void

    fun text_path = cairo_text_path(
      cr : LibCairo::Context*,
      utf8 : UInt8*
    ) : Void

    fun glyph_path = cairo_glyph_path(
      cr : LibCairo::Context*,
      glyphs : LibCairo::Glyph*,
      num_glyphs : Int32
    ) : Void

    fun text_extents = cairo_text_extents(
      cr : LibCairo::Context*,
      utf8 : UInt8*,
      extents : LibCairo::TextExtents*
    ) : Void

    fun glyph_extents = cairo_glyph_extents(
      cr : LibCairo::Context*,
      glyphs : LibCairo::Glyph*,
      num_glyphs : Int32,
      extents : LibCairo::TextExtents*
    ) : Void

    fun font_extents = cairo_font_extents(
      cr : LibCairo::Context*,
      extents : LibCairo::FontExtents*
    ) : Void

    # Generic identifier for a font style

    fun font_face_reference = cairo_font_face_reference(
      font_face : LibCairo::FontFace*
    ) : LibCairo::FontFace*

    fun font_face_destroy = cairo_font_face_destroy(
      font_face : LibCairo::FontFace*
    ) : Void

    fun font_face_get_reference_count = cairo_font_face_get_reference_count(
      font_face : LibCairo::FontFace*
    ) : UInt32

    fun font_face_status = cairo_font_face_status(
      font_face : LibCairo::FontFace*
    ) : LibCairo::Status

    fun font_face_get_type = cairo_font_face_get_type(
      font_face : LibCairo::FontFace*
    ) : LibCairo::FontType

    fun font_face_get_user_data = cairo_font_face_get_user_data(
      font_face : LibCairo::FontFace*,
      key : LibCairo::UserDataKey*
    ) : Void*

    fun font_face_set_user_data = cairo_font_face_set_user_data(
      font_face : LibCairo::FontFace*,
      key : LibCairo::UserDataKey*,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

    # Portable interface to general font features.

    fun scaled_font_create = cairo_scaled_font_create(
      font_face : LibCairo::FontFace*,
      font_matrix : LibCairo::Matrix*,
      ctm : LibCairo::Matrix*,
      options : LibCairo::FontOptions*
    ) : LibCairo::ScaledFont*

    fun scaled_font_reference = cairo_scaled_font_reference(
      scaled_font : LibCairo::ScaledFont*
    ) : LibCairo::ScaledFont*

    fun scaled_font_destroy = cairo_scaled_font_destroy(
      scaled_font : LibCairo::ScaledFont*
    ) : Void

    fun scaled_font_get_reference_count = cairo_scaled_font_get_reference_count(
      scaled_font : LibCairo::ScaledFont*
    ) : UInt32

    fun scaled_font_status = cairo_scaled_font_status(
      scaled_font : LibCairo::ScaledFont*
    ) : LibCairo::Status

    fun scaled_font_get_type = cairo_scaled_font_get_type(
      scaled_font : LibCairo::ScaledFont*
    ) : LibCairo::FontType

    fun scaled_font_get_user_data = cairo_scaled_font_get_user_data(
      scaled_font : LibCairo::ScaledFont*,
      key : LibCairo::UserDataKey*
    ) : Void*

    fun scaled_font_set_user_data = cairo_scaled_font_set_user_data(
      scaled_font : LibCairo::ScaledFont*,
      key : LibCairo::UserDataKey*,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

    fun scaled_font_extents = cairo_scaled_font_extents(
      scaled_font : LibCairo::ScaledFont*,
      extents : LibCairo::FontExtents*
    ) : Void

    fun scaled_font_text_extents = cairo_scaled_font_text_extents(
      scaled_font : LibCairo::ScaledFont*,
      utf8 : UInt8*,
      extents : LibCairo::TextExtents*
    ) : Void

    fun scaled_font_glyph_extents = cairo_scaled_font_glyph_extents(
      scaled_font : LibCairo::ScaledFont*,
      glyphs : LibCairo::Glyph*,
      num_glyphs : Int32,
      extents : LibCairo::TextExtents*
    ) : Void
       
    fun scaled_font_get_font_face = cairo_scaled_font_get_font_face(
      scaled_font : LibCairo::ScaledFont*
    ) : LibCairo::FontFace*

    fun scaled_font_get_font_matrix = cairo_scaled_font_get_font_matrix(
      scaled_font : LibCairo::ScaledFont*,
      font_matrix : LibCairo::Matrix*
    ) : Void

    fun scaled_font_get_ctm = cairo_scaled_font_get_ctm(
      scaled_font : LibCairo::ScaledFont*,
      ctm : LibCairo::Matrix*
    ) : Void

    fun scaled_font_get_scale_matrix = cairo_scaled_font_get_scale_matrix(
      scaled_font : LibCairo::ScaledFont*,
      scale_matrix : LibCairo::Matrix*
    ) : Void

    fun scaled_font_get_font_options = cairo_scaled_font_get_font_options(
      scaled_font : LibCairo::ScaledFont*,
      options : LibCairo::FontOptions*
    ) : Void

    # Toy fonts

    fun toy_font_face_create = cairo_toy_font_face_create(
      family : UInt8*,
      slant : LibCairo::FontSlant,
      weight : LibCairo::FontWeight
    ) : LibCairo::FontFace*

    fun toy_font_face_get_family = cairo_toy_font_face_get_family(
      font_face : LibCairo::FontFace*
    ) : UInt8*

    fun toy_font_face_get_slant = cairo_toy_font_face_get_slant(
      font_face : LibCairo::FontFace*
    ) : LibCairo::FontSlant

    fun toy_font_face_get_weight = cairo_toy_font_face_get_weight(
      font_face : LibCairo::FontFace*
    ) : LibCairo::FontWeight

    # User-font method setters

    fun user_font_face_set_init_func = cairo_user_font_face_set_init_func(
      font_face : LibCairo::FontFace*,
      init_func : UserScaledFontInitFunc
    ) : Void

    fun user_font_face_set_render_glyph_func = cairo_user_font_face_set_render_glyph_func(
      font_face : LibCairo::FontFace*,
      render_glyph_func : UserScaledFontRenderGlyphFunc
    ) : Void
       
    fun user_font_face_set_unicode_to_glyph_func = cairo_user_font_face_set_unicode_to_glyph_func(
      font_face : LibCairo::FontFace*,
      unicode_to_glyph_func : UserScaledFontUnicodeToGlyphFunc
    ) : Void

    # User-font method getters

    fun user_font_face_get_init_func = cairo_user_font_face_get_init_func(
      font_face : LibCairo::FontFace*
    ) : UserScaledFontInitFunc

    fun user_font_face_get_render_glyph_func = cairo_user_font_face_get_render_glyph_func(
      font_face : LibCairo::FontFace*
    ) : UserScaledFontRenderGlyphFunc
       
    fun user_font_face_get_unicode_to_glyph_func = cairo_user_font_face_get_unicode_to_glyph_func(
      font_face : LibCairo::FontFace*
    ) : UserScaledFontUnicodeToGlyphFunc
         
    ##########################################################

    fun region_create = cairo_region_create() : LibCairo::Region*

    fun region_create_rectangle = cairo_region_create_rectangle(
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::Region*

    fun region_create_rectangles = cairo_region_create_rectangles(
      rects : LibCairo::RectangleInt*,
      count : Int32
    ) : LibCairo::Region*

    fun region_copy = cairo_region_copy(
      original : LibCairo::Region*
    ) : LibCairo::Region*

    fun region_reference = cairo_region_reference(
      region : LibCairo::Region*
    ) : LibCairo::Region*

    fun region_destroy = cairo_region_destroy(
      region : LibCairo::Region*
    ) : Void

    fun region_equal = cairo_region_equal(
      a : LibCairo::Region*,
      b : LibCairo::Region*
    ) : Int32

    fun region_status = cairo_region_status(
      region : LibCairo::Region*
    ) : LibCairo::Status

    fun region_get_extents = cairo_region_get_extents(
      region : LibCairo::Region*,
      extents : LibCairo::RectangleInt*
    ) : Void

    fun region_num_rectangles = cairo_region_num_rectangles(
      region : LibCairo::Region*
    ) : Int32

    fun region_get_rectangle = cairo_region_get_rectangle(
      region : LibCairo::Region*,
      nth : Int32,
      rectangle : LibCairo::RectangleInt*
    ) : Void

    fun region_is_empty = cairo_region_is_empty(
      region : LibCairo::Region*
    ) : Int32

    fun region_contains_rectangle = cairo_region_contains_rectangle(
      region : LibCairo::Region*,
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::RegionOverlap

    fun region_contains_point = cairo_region_contains_point(
      region : LibCairo::Region*,
      x : Int32,
      y : Int32
    ) : Int32

    fun region_translate = cairo_region_translate(
      region : LibCairo::Region*,
      dx : Int32,
      dy : Int32
    ) : Void

    fun region_subtract = cairo_region_subtract(
      dst : LibCairo::Region*,
      other : LibCairo::Region*
    ) : LibCairo::Status

    fun region_subtract_rectangle = cairo_region_subtract_rectangle(
      dst : LibCairo::Region*,
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::Status

    fun region_intersect = cairo_region_intersect(
      dst : LibCairo::Region*,
      other : LibCairo::Region*
    ) : LibCairo::Status

    fun region_intersect_rectangle = cairo_region_intersect_rectangle(
      dst : LibCairo::Region*,
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::Status

    fun region_union = cairo_region_union(
      dst : LibCairo::Region*,
      other : LibCairo::Region*
    ) : LibCairo::Status

    fun region_union_rectangle = cairo_region_union_rectangle(
      dst : LibCairo::Region*,
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::Status

    fun region_xor = cairo_region_xor(
      dst : LibCairo::Region*,
      other : LibCairo::Region*
    ) : LibCairo::Status

    fun region_xor_rectangle = cairo_region_xor_rectangle(
      dst : LibCairo::Region*,
      rectangle : LibCairo::RectangleInt*
    ) : LibCairo::Status

    fun matrix_init = cairo_matrix_init(
      matrix : LibCairo::Matrix*,
      xx : Float64,
      yx : Float64,
      xy : Float64,
      yy : Float64,
      x0 : Float64,
      y0 : Float64
    ) : Void

    fun matrix_init_identity = cairo_matrix_init_identity(
      matrix : LibCairo::Matrix*,
    ) : Void

    fun matrix_init_translate = cairo_matrix_init_translate(
      matrix : LibCairo::Matrix*,
      tx : Float64,
      ty : Float64
    ) : Void

    fun matrix_init_scale = cairo_matrix_init_scale(
      matrix : LibCairo::Matrix*,
      sx : Float64,
      sy : Float64
    ) : Void

    fun matrix_init_rotate = cairo_matrix_init_rotate(
      matrix : LibCairo::Matrix*,
      radians : Float64
    ) : Void

    fun matrix_translate = cairo_matrix_translate(
      matrix : LibCairo::Matrix*,
      tx : Float64,
      ty : Float64
    ) : Void

    fun matrix_scale = cairo_matrix_scale(
      matrix : LibCairo::Matrix*,
      sx : Float64,
      sy : Float64
    ) : Void

    fun matrix_rotate = cairo_matrix_rotate(
      matrix : LibCairo::Matrix*,
      radians : Float64
    ) : Void

    fun matrix_invert = cairo_matrix_invert(
      matrix : LibCairo::Matrix*,
    ) : LibCairo::Status

    fun matrix_multiply = cairo_matrix_multiply(
      result : LibCairo::Matrix*,
      a : LibCairo::Matrix*,
      b : LibCairo::Matrix*
    ) : Void

    fun matrix_transform_distance = cairo_matrix_transform_distance(
      matrix : LibCairo::Matrix*,
      dx : Float64*,
      dy : Float64*
    ) : Void

    fun matrix_transform_point = cairo_matrix_transform_point(
      matrix : LibCairo::Matrix*,
      x : Float64*,
      y : Float64*
    ) : Void

    fun pattern_set_filter = cairo_pattern_set_filter(
      pattern :  LibCairo::Pattern*,
      filter : LibCairo::Filter
    ) : Void

    fun pattern_get_filter = cairo_pattern_get_filter(
      pattern :  LibCairo::Pattern*,
    ) : LibCairo::Filter

    fun pattern_get_rgba = cairo_pattern_get_rgba(
      pattern :  LibCairo::Pattern*,
      red : Float64*,
      green : Float64*,
      blue : Float64*,
      alpha : Float64*
    ) : LibCairo::Status

    fun pattern_get_surface = cairo_pattern_get_surface(
      pattern :  LibCairo::Pattern*,
      surface : LibCairo::Surface**
    ) : LibCairo::Status

    fun pattern_get_color_stop_rgba = cairo_pattern_get_color_stop_rgba(
      pattern :  LibCairo::Pattern*,
      index : Int32,
      offset : Float64*,
      red : Float64*,
      green : Float64*,
      blue : Float64*,
      alpha : Float64*
    ) : LibCairo::Status

    fun pattern_get_color_stop_count = cairo_pattern_get_color_stop_count(
      pattern :  LibCairo::Pattern*,
      count : Int32*
    ) : LibCairo::Status

    fun pattern_get_linear_points = cairo_pattern_get_linear_points(
      pattern :  LibCairo::Pattern*,
      x0 : Float64*,
      y0 : Float64*,
      x1 : Float64*,
      y1 : Float64*
    ) : LibCairo::Status

    fun pattern_get_radial_circles = cairo_pattern_get_radial_circles(
      pattern :  LibCairo::Pattern*,
      x0 : Float64*,
      y0 : Float64*,
      r0 : Float64*,
      x1 : Float64*,
      y1 : Float64*,
      r1 : Float64*
    ) : LibCairo::Status

    fun mesh_pattern_get_patch_count = cairo_mesh_pattern_get_patch_count(
      pattern :  LibCairo::Pattern*,
      count : UInt32*
    ) : LibCairo::Status

    fun mesh_pattern_get_path = cairo_mesh_pattern_get_path(
      pattern :  LibCairo::Pattern*,
      patch_num : UInt32
    ) : LibCairo::Path*

    fun mesh_pattern_get_corner_color_rgba = cairo_mesh_pattern_get_corner_color_rgba(
      pattern :  LibCairo::Pattern*,
      patch_num : UInt32,
      corner_num : UInt32,
      red : Float64*,
      green : Float64*,
      blue : Float64*,
      alpha : Float64*
    ) : LibCairo::Status

    fun mesh_pattern_get_control_point = cairo_mesh_pattern_get_control_point(
      pattern :  LibCairo::Pattern*,
      patch_num : UInt32,
      point_num : UInt32,
      x : Float64*,
      y : Float64*
    ) : LibCairo::Status

    fun pattern_set_extend = cairo_pattern_set_extend(
      pattern : LibCairo::Pattern*,
      extend : LibCairo::Extend
    ) : Void

    fun pattern_get_extend = cairo_pattern_get_extend(
      pattern : LibCairo::Pattern*,
    ) : LibCairo::Extend
  
    fun pattern_get_type = cairo_pattern_get_type(
      pattern : LibCairo::Pattern*,
    ) : LibCairo::PatternType

    fun pattern_add_color_stop_rgb = cairo_pattern_add_color_stop_rgb(
      pattern : LibCairo::Pattern*,
      offset : Float64,
      red : Float64,
      green : Float64,
      blue : Float64
    ) : Void

    fun pattern_add_color_stop_rgba = cairo_pattern_add_color_stop_rgba(
      pattern : LibCairo::Pattern*,
      offset : Float64,
      red : Float64,
      green : Float64,
      blue : Float64,
      alpha : Float64
    ) : Void

    fun mesh_pattern_begin_patch = cairo_mesh_pattern_begin_patch(
      pattern : LibCairo::Pattern*,
    ) : Void

    fun mesh_pattern_end_patch = cairo_mesh_pattern_end_patch(
      pattern : LibCairo::Pattern*,
    ) : Void

    fun mesh_pattern_curve_to = cairo_mesh_pattern_curve_to(
      pattern : LibCairo::Pattern*,
      x1 : Float64,
      y1 : Float64,
      x2 : Float64,
      y2 : Float64,
      x3 : Float64,
      y3 : Float64
    ) : Void

    fun mesh_pattern_line_to = cairo_mesh_pattern_line_to(
      pattern : LibCairo::Pattern*,
      x : Float64,
      y : Float64
    ) : Void

    fun mesh_pattern_move_to = cairo_mesh_pattern_move_to(
      pattern : LibCairo::Pattern*,
      x : Float64,
      y : Float64
    ) : Void

    fun mesh_pattern_set_control_point = cairo_mesh_pattern_set_control_point(
      pattern : LibCairo::Pattern*,
      point_num : UInt32,
      x : Float64,
      y : Float64
    ) : Void

    fun mesh_pattern_set_corner_color_rgb = cairo_mesh_pattern_set_corner_color_rgb(
      pattern : LibCairo::Pattern*,
      corner_num : UInt32,
      red : Float64,
      green : Float64,
      blue : Float64
    ) : Void

    fun mesh_pattern_set_corner_color_rgba = cairo_mesh_pattern_set_corner_color_rgba(
      pattern : LibCairo::Pattern*,
      corner_num : UInt32,
      red : Float64,
      green : Float64,
      blue : Float64,
      alpha : Float64
    ) : Void

    fun pattern_set_matrix = cairo_pattern_set_matrix(
      pattern : LibCairo::Pattern*,
      matrix : LibCairo::Matrix*
    ) : Void

    fun pattern_get_matrix = cairo_pattern_get_matrix(
      pattern : LibCairo::Pattern*,
      matrix : LibCairo::Matrix*
    ) : Void

    fun pattern_create_rgb = cairo_pattern_create_rgb(
      red : Float64,
      green : Float64,
      blue : Float64
    ) : LibCairo::Pattern*

    fun pattern_create_rgba = cairo_pattern_create_rgba(
      red : Float64,
      green : Float64,
      blue : Float64,
      alpha : Float64
    ) : LibCairo::Pattern*

    fun pattern_create_for_surface = cairo_pattern_create_for_surface(
      surface : LibCairo::Surface*
    ) : LibCairo::Pattern*

    fun pattern_create_linear = cairo_pattern_create_linear(
      x0 : Float64,
      y0 : Float64,
      x1 : Float64,
      y1 : Float64
    ) : LibCairo::Pattern*

    fun pattern_create_radial = cairo_pattern_create_radial(
      cx0 : Float64,
      cy0 : Float64,
      radius0 : Float64,
      cx1 : Float64,
      cy1 : Float64,
      radius1 : Float64
    ) : LibCairo::Pattern*

    fun pattern_create_mesh = cairo_pattern_create_mesh(
    ) : LibCairo::Pattern*

    fun pattern_reference = cairo_pattern_reference(
      pattern : LibCairo::Pattern*
    ) : LibCairo::Pattern*

    fun pattern_destroy = cairo_pattern_destroy(
      pattern : LibCairo::Pattern*
    ) : Void

    fun pattern_get_reference_count = cairo_pattern_get_reference_count(
      pattern : LibCairo::Pattern*
    ) : UInt32

    fun pattern_status = cairo_pattern_status(
      pattern : LibCairo::Pattern*
    ) : LibCairo::Status

    fun pattern_get_user_data = cairo_pattern_get_user_data(
      pattern : LibCairo::Pattern*,
      key : LibCairo::UserDataKey*
    ) : Void*

    fun pattern_set_user_data = cairo_pattern_set_user_data(
      pattern : LibCairo::Pattern*,
      key : LibCairo::UserDataKey*,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

    fun copy_path = cairo_copy_path(
      cr : LibCairo::Context*
    ) : LibCairo::Path*

    fun copy_path_flat = cairo_copy_path_flat(
      cr : LibCairo::Context*
    ) : LibCairo::Path*

    fun append_path = cairo_append_path(
      cr : LibCairo::Context*,
      path : LibCairo::Path*
    ) : Void

    fun path_destroy = cairo_path_destroy(
      path : LibCairo::Path*
    ) : Void

    # Error status queries

    fun status = cairo_status(
      cr : LibCairo::Context*
    ) : LibCairo::Status

    fun status_to_string = cairo_status_to_string(
      status : LibCairo::Status
    ) : UInt8*

    # Query functions

    fun get_operator = cairo_get_operator(
      cr : LibCairo::Context*
    ) : LibCairo::Operator

    fun get_source = cairo_get_source(
      cr : LibCairo::Context*
    ) : LibCairo::Pattern*

    fun get_tolerance = cairo_get_tolerance(
      cr : LibCairo::Context*
    ) : Float64

    fun get_antialias = cairo_get_antialias(
      cr : LibCairo::Context*
    ) : LibCairo::Antialias

    fun has_current_point = cairo_has_current_point(
      cr : LibCairo::Context*
    ) : Int32

    fun get_current_point = cairo_get_current_point(
      cr : LibCairo::Context*,
      x : Float64*,
      y : Float64*
    ) : Void

    fun get_fill_rule = cairo_get_fill_rule(
      cr : LibCairo::Context*
    ) : LibCairo::FillRule

    fun get_line_width = cairo_get_line_width(
      cr : LibCairo::Context*
    ) : Float64

    fun get_line_cap = cairo_get_line_cap(
      cr : LibCairo::Context*
    ) : LibCairo::LineCap

    fun get_line_join = cairo_get_line_join(
      cr : LibCairo::Context*
    ) : LibCairo::LineJoin

    fun get_miter_limit = cairo_get_miter_limit(
      cr : LibCairo::Context*
    ) : Float64

    fun get_dash_count = cairo_get_dash_count(
      cr : LibCairo::Context*
    ) : Int32

    fun get_dash = cairo_get_dash(
      cr : LibCairo::Context*,
      dashes : Float64*,
      offset : Float64*
    ) : Void

    fun get_matrix = cairo_get_matrix(
      cr : LibCairo::Context*,
      matrix : LibCairo::Matrix*
    ) : Void

    fun get_target = cairo_get_target(
      cr : LibCairo::Context*
    ) : LibCairo::Surface*

    fun get_group_target = cairo_get_group_target(
      cr : LibCairo::Context*
    ) : LibCairo::Surface*

    # Backend device manipulation

    fun device_reference = cairo_device_reference(
      device : LibCairo::Device*
    ) : LibCairo::Device*

      fun device_get_type = cairo_device_get_type(
      device : LibCairo::Device*
    ) : LibCairo::DeviceType

    fun device_status = cairo_device_status(
      device : LibCairo::Device*
    ) : LibCairo::Status

    fun device_acquire = cairo_device_acquire(
      device : LibCairo::Device*
    ) : LibCairo::Status

    fun device_release = cairo_device_release(
      device : LibCairo::Device*
    ) : Void

    fun device_flush = cairo_device_flush(
      device : LibCairo::Device*
    ) : Void

    fun device_finish = cairo_device_finish(
      device : LibCairo::Device*
    ) : Void

    fun device_destroy = cairo_device_destroy(
      device : LibCairo::Device*
    ) : Void

    fun device_get_reference_count = cairo_device_get_reference_count(
      device : LibCairo::Device*
    ) : UInt32

    fun device_get_user_data = cairo_device_get_user_data(
      device : LibCairo::Device*,
      key : LibCairo::UserDataKey*
    ) : Void*

    fun device_set_user_data = cairo_device_set_user_data(
      device : LibCairo::Device*,
      key : LibCairo::UserDataKey*,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

     # Surface manipulation

    fun surface_create_similar = cairo_surface_create_similar(
      other : LibCairo::Surface*,
      content : LibCairo::Content,
      width : Int32,
      height : Int32
    ) : LibCairo::Surface*

    fun surface_create_similar_image = cairo_surface_create_similar_image(
      other : LibCairo::Surface*,
      format : LibCairo::Format,
      width : Int32,
      height : Int32
    ) : LibCairo::Surface*

    fun surface_map_to_image = cairo_surface_map_to_image(
      surface : LibCairo::Surface*,
      extents : LibCairo::RectangleInt*
    ) : LibCairo::Surface*

    fun surface_unmap_image = cairo_surface_unmap_image(
      surface : LibCairo::Surface*,
      image : LibCairo::Surface*
    ) : Void

    fun surface_create_for_rectangle = cairo_surface_create_for_rectangle(
      target : LibCairo::Surface*,
      x : Float64,
      y : Float64,
      width : Float64,
      height : Float64
    ) : LibCairo::Surface*

    fun surface_reference = cairo_surface_reference(
      surface : LibCairo::Surface*
    ) : LibCairo::Surface*

    fun surface_finish = cairo_surface_finish(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_destroy = cairo_surface_destroy(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_get_device = cairo_surface_get_device(
      surface : LibCairo::Surface*
    ) : LibCairo::Device*

    fun surface_get_reference_count = cairo_surface_get_reference_count(
      surface : LibCairo::Surface*
    ) : UInt32

    fun surface_status = cairo_surface_status(
      surface : LibCairo::Surface*
    ) : LibCairo::Status

     fun surface_get_type = cairo_surface_get_type(
      surface : LibCairo::Surface*
    ) : LibCairo::SurfaceType

    fun surface_get_content = cairo_surface_get_content(
      surface : LibCairo::Surface*
    ) : LibCairo::Content

    fun surface_create_from_png = cairo_image_surface_create_from_png(filename : UInt8*) : LibCairo::Surface*

    fun surface_write_to_png = cairo_surface_write_to_png(
      surface : LibCairo::Surface*,
      filename : UInt8*
    ) : LibCairo::Status

    fun surface_write_to_png_stream = cairo_surface_write_to_png_stream(
      surface : LibCairo::Surface*,
      write_func : WriteFunc,
      closure : Void*
    ) : LibCairo::Status

        fun surface_get_user_data = cairo_surface_get_user_data(
      surface : LibCairo::Surface*,
      key : LibCairo::UserDataKey*
    ) : Void*

    fun surface_set_user_data = cairo_surface_set_user_data(
      surface : LibCairo::Surface*,
      key : LibCairo::UserDataKey,
      user_data : Void*,
      destroy : DestroyFunc
    ) : LibCairo::Status

    fun surface_get_mime_data = cairo_surface_get_mime_data(
      surface : LibCairo::Surface*,
      mime_type : UInt8*,
      data : UInt8**,
      length : UInt64*
    ) : Void

    fun surface_set_mime_data = cairo_surface_set_mime_data(
      surface : LibCairo::Surface*,
      mime_type : UInt8*,
      data : UInt8*,
      length : UInt64,
      destroy : DestroyFunc,
      closure : Void*
    ) : LibCairo::Status

    fun surface_supports_mime_type = cairo_surface_supports_mime_type(
      surface : LibCairo::Surface*,
      mime_type : UInt8*
    ) : Int32

    fun surface_get_font_options = cairo_surface_get_font_options(
      surface : LibCairo::Surface*,
      options : LibCairo::FontOptions*
    ) : Void

    fun surface_flush = cairo_surface_flush(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_mark_dirty = cairo_surface_mark_dirty(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_mark_dirty_rectangle = cairo_surface_mark_dirty_rectangle(
      surface : LibCairo::Surface*,
      x : Int32,
      y : Int32,
      width : Int32,
      height : Int32
    ) : Void

    fun surface_set_device_scale = cairo_surface_set_device_scale(
      surface : LibCairo::Surface*,
      x_scale : Float64,
      y_scale : Float64
    ) : Void

    fun surface_get_device_scale = cairo_surface_get_device_scale(
      surface : LibCairo::Surface*,
      x_scale : Float64*,
      y_scale : Float64*
    ) : Void

    fun surface_set_device_offset = cairo_surface_set_device_offset(
      surface : LibCairo::Surface*,
      x_offset : Float64,
      y_offset : Float64
    ) : Void

    fun surface_get_device_offset = cairo_surface_get_device_offset(
      surface : LibCairo::Surface*,
      x_offset : Float64*,
      y_offset : Float64*
    ) : Void

    fun surface_set_fallback_resolution = cairo_surface_set_fallback_resolution(
      surface : LibCairo::Surface*,
      x_pixels_per_inch : Float64,
      y_pixels_per_inch : Float64
    ) : Void

    fun surface_get_fallback_resolution = cairo_surface_get_fallback_resolution(
      surface : LibCairo::Surface*,
      x_pixels_per_inch : Float64*,
      y_pixels_per_inch : Float64*
    ) : Void

    fun surface_copy_page = cairo_surface_copy_page(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_show_page = cairo_surface_show_page(
      surface : LibCairo::Surface*
    ) : Void

    fun surface_has_show_text_glyphs = cairo_surface_has_show_text_glyphs(
      surface : LibCairo::Surface*
    ) : Int32

    fun image_surface_get_width = cairo_image_surface_get_width(
      surface : LibCairo::Surface*
    ) : Int32

    fun image_surface_get_height = cairo_image_surface_get_height(
      surface : LibCairo::Surface*
    ) : Int32

    fun image_surface_get_stride = cairo_image_surface_get_stride(
      surface : LibCairo::Surface*
    ) : Int32

end
