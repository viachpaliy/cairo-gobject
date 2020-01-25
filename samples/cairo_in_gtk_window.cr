require "gobject/gtk/autorun"
require "../src/cairo"

class CairoApp
  @window : Gtk::Window
  

  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Simple drawing"
    @window.resize 600,150
    @window.connect "destroy", &->Gtk.main_quit
    darea = Gtk::DrawingArea.new
    darea.connect "draw",&->drawfun 
    @window.add darea
  end

  def drawfun
    context = Gdk.cairo_create(@window.window.not_nil!)
    context.set_source_rgb(0, 0, 100) 
    context.select_font_face("Sans", Cairo::FontSlant::NORMAL , Cairo::FontWeight::NORMAL)
    context.font_size=40 
    context.move_to(10,50)
    context.show_text("Cairo draw on a GTK window!")
  end

end

app=CairoApp.new
app.show_all
