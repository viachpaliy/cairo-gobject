require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Cairo solid colors example",
      window_type: Gdk::WindowType::TOPLEVEL,
      wclass: Gdk::WindowWindowClass::INPUT_OUTPUT,
      width: 600,
      height: 400
      ),
      Gdk::WindowAttributesType.flags(TITLE)
      )
    
    @window.events = Gdk::EventMask::ZERO_NONE

    @main_loop=GLib::MainLoop.new(nil, true)
  end 
  
  def draw(context)
    context.set_source_rgb( 1.0, 1.0, 1.0)
    context.rectangle(0, 0, 600, 400)
    context.fill
    context.set_source_rgb(0.5, 0.5, 1) 
    context.rectangle(20, 20, 100, 100)
    context.fill
    context.set_source_rgb(0.6, 0.6, 0.6) 
    context.rectangle(150, 20, 100, 100)
    context.fill
    context.set_source_rgb(0, 0.3, 0) 
    context.rectangle(20, 140, 100, 100)
    context.fill
    context.set_source_rgb(1, 0, 0.5) 
    context.rectangle(150, 140, 100, 100)
    context.fill
  end 

  def run()
    @window.show
    Gdk::Event.on_event do |event|
      case event.event_type
        when Gdk::EventType::VISIBILITY_NOTIFY
          draw((Gdk.cairo_create(@window)))
        when Gdk::EventType::DELETE
          @main_loop.quit
      end
    end
    @main_loop.run
  end
end

app=CairoApp.new
app.run

 









