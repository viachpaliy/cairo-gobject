require "gobject/gtk/autorun"
require "../src/cairo"

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
    darea = Gtk::DrawingArea.new
    hb.add bbox
    hb.add darea
    @window.add hb
  end

  def draw_text
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.set_source_rgb(0, 0, 100) 
    context.select_font_face("Sans", Cairo::FontSlant::NORMAL , Cairo::FontWeight::NORMAL)
    context.font_size=40 
    context.move_to(150,150)
    context.show_text("Cairo draw text!")
  end

 def fill_and_stroke
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.line_width=9
    context.set_source_rgb( 0.69, 0.19, 0) 
    context.translate(300,150)
    context.arc(0,0,50,0,6.283)
    context.stroke_preserve
    context.set_source_rgb( 0.30, 0.40, 0.60)
    context.fill
  end 

def line_caps
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.set_source_rgb( 0.3, 0.19, 0.4) 
    context.line_width= 20
    context.font_size= 20
    context.line_cap=Cairo::LineCap::BUTT
    context.move_to(200, 50)
    context.line_to(400, 50)
    context.stroke 
    context.move_to(420,50).show_text("BUTT")
    context.line_cap=Cairo::LineCap::ROUND
    context.move_to(200, 150)
    context.line_to(400, 150)
    context.stroke
    context.move_to(420,150).show_text("ROUND")
    context.line_cap=Cairo::LineCap::SQUARE
    context.move_to(200, 250)
    context.line_to(400, 250)
    context.stroke
    context.move_to(420,250).show_text("SQUARE")
    context.line_width=1.5
    context.move_to(200, 50)
    context.line_to(200, 250)
    context.stroke
    context.move_to(400, 50)
    context.line_to(400, 250)
    context.stroke
    context.move_to(410, 50)
    context.line_to(410, 250)
    context.stroke
  end 

  def line_joins
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.set_source_rgb( 0.3, 0.19, 0.4) 
    context.rectangle(230, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::MITER
    context.stroke
    context.rectangle(360, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::BEVEL
    context.stroke
    context.rectangle(300, 160, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::ROUND
    context.stroke
  end 

def pen_dashes
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.set_source_rgb( 0.69, 0.19, 0) 
    dashed1 = [4.0, 21.0, 2.0]
    dashed2 = [14.0, 6.0]
    dashed3 = [1.0]
    context.line_width=1.5
    context.set_dash(dashed1, 0)
    context.move_to(140, 30)
    context.line_to(400, 30)
    context.stroke 
    context.set_dash(dashed2, 0)
    context.move_to(140,150)
    context.line_to(400,150)
    context.stroke
    context.set_dash(dashed3, 0)
    context.move_to(140,250)
    context.line_to(400,250)
    context.stroke
  end 

  def transparent
    context = Gdk.cairo_create(@window.window.not_nil!)
    i=1
    while i < 10
      context.set_source_rgba(0, 0, 1, i*0.1)
      context.rectangle(Float64.new(100+50*i), Float64.new(20*i), 40.0, 40.0)
      context.fill
      i = i + 1
    end
  end

end

app=CairoApp.new
app.show_all

