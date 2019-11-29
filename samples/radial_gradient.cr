require "gobject/gtk/autorun"
require "../src/cairo"

class CairoApp
  @window : Gtk::Window
  

  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Radial gradient"
    @window.resize 250,150
    @window.connect "destroy", &->Gtk.main_quit
    darea = Gtk::DrawingArea.new
    darea.connect "draw",&->drawfun 
    @window.add darea
  end

  def draw_gradient1(cr : Cairo::Context)
    cr.set_source_rgba(0, 0, 0, 1)
    cr.line_width= 12  
    cr.translate(60, 60)
    r1 = Cairo::Pattern.create_radial(30, 30, 10, 30, 30, 90)
    r1.add_color_stop(0, 1, 1, 1, 1);
    r1.add_color_stop(1, 0.6, 0.6, 0.6, 1)
    cr.source= r1
    cr.arc(0, 0, 40, 0, 6.283)
    cr.fill
  end

  def draw_gradient2(cr : Cairo::Context)
    cr.translate(120, 0)
    r2 = Cairo::Pattern.create_radial(0, 0, 10, 0, 0, 40)
    r2.add_color_stop(0, 1, 1, 0);
    r2.add_color_stop(1, 0.8, 0, 0, 0)
    cr.source= r2
    cr.arc(0, 0, 40, 0, 6.283)
    cr.fill
  end

  def drawfun
    context = Gdk.cairo_create(@window.window.not_nil!)
    draw_gradient1(context)
    draw_gradient2(context)
  end

end

app=CairoApp.new
app.show_all
