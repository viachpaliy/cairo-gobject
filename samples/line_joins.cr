require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Cairo line joins example",
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
    context.set_source_rgb( 0.3, 0.19, 0.4) 
    context.rectangle(30, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::MITER
    context.stroke
    context.rectangle(160, 30, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::BEVEL
    context.stroke
    context.rectangle(100, 160, 100, 100)
    context.line_width=14
    context.line_join=Cairo::LineJoin::ROUND
    context.stroke
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

 









