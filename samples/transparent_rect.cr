require "gobject/gtk/autorun"
require "../src/cairo"

class CairoApp
  @window : Gtk::Window
 
  delegate show_all, to: @window

  def initialize
    @window = Gtk::Window.new
    @window.title = "Cairo transparent example"
    @window.resize 500,150
    @window.connect "destroy", &->Gtk.main_quit
    darea = Gtk::DrawingArea.new
    darea.connect "draw",&->drawfun 
    @window.add darea
  end

  def drawfun
    context = Gdk.cairo_create(@window.window.not_nil!)
    i=1
    while i < 10
      context.set_source_rgba(0, 0, 1, i*0.1)
      context.rectangle(Float64.new(50*i), 20.0, 40.0, 40.0)
      context.fill
      i = i + 1
    end
  end

end

app=CairoApp.new
app.show_all
