require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Cairo pen dashes example",
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
    context.set_source_rgb( 0.69, 0.19, 0) 
    dashed1 = [4.0, 21.0, 2.0]
    dashed2 = [14.0, 6.0]
    dashed3 = [1.0]
    context.line_width=1.5
    context.set_dash(dashed1, 0)
    context.move_to(40, 30)
    context.line_to(200, 30)
    context.stroke 
    context.set_dash(dashed2, 0)
    context.move_to(40,50)
    context.line_to(200,50)
    context.stroke
    context.set_dash(dashed3, 0)
    context.move_to(40,70)
    context.line_to(200,70)
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

 









