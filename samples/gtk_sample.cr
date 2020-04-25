require "gobject/gtk/autorun"
require "cairo/cairo"

class CairoApp
  @window : Gtk::Window
  
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Cairo drawing"
    @window.resize 600,300
    @window.connect "destroy", &->Gtk.main_quit
    hb = Gtk::Box.new :horizontal, 2
    bbox = Gtk::ButtonBox.new :vertical
    btn1 = Gtk::Button.new_with_label "draw text"
    btn1.on_clicked { draw_text }
    bbox.pack_start(btn1, expand = true, fill = true, padding = 2)
    btn2 = Gtk::Button.new_with_label "fill and stroke"
    btn2.on_clicked { fill_and_stroke }
    bbox.pack_start(btn2, expand = true, fill = true, padding = 2)
    btn3 = Gtk::Button.new_with_label "line caps"
    btn3.on_clicked { line_caps }
    bbox.pack_start(btn3, expand = true, fill = true, padding = 2)
    btn4 = Gtk::Button.new_with_label "line joins"
    btn4.on_clicked { line_joins }
    bbox.pack_start(btn4, expand = true, fill = true, padding = 2)
    btn5 = Gtk::Button.new_with_label "pen dashes"
    btn5.on_clicked { pen_dashes }
    bbox.pack_start(btn5, expand = true, fill = true, padding = 2)
    btn6 = Gtk::Button.new_with_label "transparent"
    btn6.on_clicked { transparent }
    bbox.pack_start(btn6, expand = true, fill = true, padding = 2)
    btn7 = Gtk::Button.new_with_label "clip"
    btn7.on_clicked { clip }
    bbox.pack_start(btn7, expand = true, fill = true, padding = 2)
    btn8 = Gtk::Button.new_with_label "clip image"
    btn8.on_clicked { clip_image }
    bbox.pack_start(btn8, expand = true, fill = true, padding = 2)
    scrolledwindow = Gtk::ScrolledWindow.new nil, nil
    scrolledwindow.hexpand = true
    scrolledwindow.vexpand = true 
    darea = Gtk::DrawingArea.new
    @darea = darea.as Gtk::DrawingArea
    darea.connect "draw",&->draw_white_rect 
    scrolledwindow.add darea
    hb.add bbox
    hb.add scrolledwindow
    @window.add hb
  end

  def draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.set_source_rgb( 1.0, 1.0, 1.0)
    context.rectangle(0, 0, 1600, 1300)
    context.stroke_preserve
    context.fill
  end

  def draw_text
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.set_source_rgb(0, 0, 100) 
    context.select_font_face("Sans", Cairo::FontSlant::NORMAL , Cairo::FontWeight::NORMAL)
    context.font_size=40
    t_e = context.text_extents("Cairo draw text!")
    x = (@darea.allocated_width - t_e.width)/2 
    y = (@darea.allocated_height - t_e.height)/2 
    context.move_to(x,y)
    context.show_text("Cairo draw text!")
  end

  def fill_and_stroke
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.line_width=9
    context.set_source_rgb( 0.69, 0.19, 0) 
    context.translate(250,150)
    context.arc(0,0,50,0,6.283)
    context.stroke_preserve
    context.set_source_rgb( 0.30, 0.40, 0.60)
    context.fill
  end 

  def line_caps
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.set_source_rgb( 0.3, 0.19, 0.4) 
    context.line_width= 20
    context.font_size= 20
    context.line_cap=Cairo::LineCap::BUTT
    context.move_to(100, 50)
    context.line_to(300, 50)
    context.stroke 
    context.move_to(320,50).show_text("BUTT")
    context.line_cap=Cairo::LineCap::ROUND
    context.move_to(100, 150)
    context.line_to(300, 150)
    context.stroke
    context.move_to(320,150).show_text("ROUND")
    context.line_cap=Cairo::LineCap::SQUARE
    context.move_to(100, 250)
    context.line_to(300, 250)
    context.stroke
    context.move_to(320,250).show_text("SQUARE")
    context.line_width=1.5
    context.move_to(100, 50)
    context.line_to(100, 250)
    context.stroke
    context.move_to(300, 50)
    context.line_to(300, 250)
    context.stroke
    context.move_to(310, 50)
    context.line_to(310, 250)
    context.stroke
  end 

  def line_joins
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.set_source_rgb( 0.3, 0.19, 0.4)
    context.font_size= 20 
    context.rectangle(130, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::MITER
    context.stroke
    context.move_to(150,80).show_text("MITER")
    context.rectangle(260, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::BEVEL
    context.stroke
    context.move_to(280,80).show_text("BEVEL")
    context.rectangle(200, 160, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::ROUND
    context.stroke
    context.move_to(210,210).show_text("ROUND")
  end 

  def pen_dashes
    draw_white_rect 
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.set_source_rgb( 0.69, 0.19, 0) 
    dashed1 = [4.0, 21.0, 2.0]
    dashed2 = [14.0, 6.0]
    dashed3 = [1.0]
    context.line_width=1.5
    context.set_dash(dashed1, 0)
    context.move_to(100, 30)
    context.line_to(400, 30)
    context.stroke 
    context.set_dash(dashed2, 0)
    context.move_to(100,150)
    context.line_to(400,150)
    context.stroke
    context.set_dash(dashed3, 0)
    context.move_to(100,250)
    context.line_to(400,250)
    context.stroke
  end 

  def transparent
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    i=1
    while i < 10
      context.set_source_rgba(0, 0, 1, i*0.1)
      context.rectangle(Float64.new(20+50*(i-1)), Float64.new(20+25*(i-1)), 40.0, 40.0)
      context.fill
      context.set_source_rgba(1, 0, 0, 1-i*0.1)
      context.rectangle(Float64.new(20+50*(i-1)), Float64.new(245-25*(i-1)), 40.0, 40.0)
      context.fill
      i = i + 1
    end
  end

  def clip
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.arc(@darea.allocated_width/2,@darea.allocated_height/2, @darea.allocated_height/2.5 , 0, 6.283)
    context.clip
    context.new_path
    context.rectangle(0, 0, @darea.allocated_width, @darea.allocated_height)
    context.fill
    context.set_source_rgb(0, 1, 0)
    context.move_to(0, 0)
    context.line_to(@darea.allocated_width, @darea.allocated_height)
    context.move_to(@darea.allocated_width, 0)
    context.line_to(0, @darea.allocated_height)
    context.line_width = 10
    context.stroke
  end

  def clip_image
    draw_white_rect
    context = Gdk.cairo_create(@darea.window.not_nil!)
    context.arc(@darea.allocated_width / 2, @darea.allocated_height / 2, @darea.allocated_height / 2.5 , 0, 6.283)
    context.clip
    context.new_path
    image = Cairo::Surface.create_from_png("samples/image.png")
    w = image.width
    h = image.height
    context.scale(Float64.new(@darea.allocated_width / w),Float64.new(@darea.allocated_height / h))
    context.set_source_surface(image, 0, 0)
    context.paint
  end

end

app=CairoApp.new
app.show_all

