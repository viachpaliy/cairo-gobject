require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Cairo line caps example",
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
    context.line_width=10
    context.line_cap=Cairo::LineCap::BUTT
    context.move_to(30, 50)
    context.line_to(150, 50)
    context.stroke 
    context.line_cap=Cairo::LineCap::ROUND
    context.move_to(30, 90)
    context.line_to(150, 90)
    context.stroke
    context.line_cap=Cairo::LineCap::SQUARE
    context.move_to(30, 130)
    context.line_to(150, 130)
    context.stroke
    context.line_width=1.5
    context.move_to(30, 40)
    context.line_to(30, 140)
    context.stroke
    context.move_to(150, 40)
    context.line_to(150, 140)
    context.stroke
    context.move_to(155, 40)
    context.line_to(155, 140)
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

 









