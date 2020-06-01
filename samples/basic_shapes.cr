require "gobject/gdk"
require "../src/cairo"
class CairoApp
  
  @window : Gdk::Window
  @main_loop : GLib::MainLoop
 
  def initialize
    Gdk.init

    @window = Gdk::Window.new(nil,
      Gdk::WindowAttr.new(
      title: "Cairo basic shapes",
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
    context.set_source_rgb( 0.6, 0.6, 0.6) 
    context.line_width=1
    context.rectangle(20, 20, 120, 80)
    context.rectangle(180, 20, 80, 80)
    context.stroke_preserve
    context.fill
    context.arc(330, 60, 40, 0, 6.283)
    context.stroke_preserve
    context.fill
    context.arc(90, 160, 40, 3.1415, 6.283)
    context.close_path
    context.stroke_preserve
    context.fill
    context.move_to(400, 40)
    context.line_to(400,160)
    context.line_to(470,160)
    context.curve_to(460, 155, 400, 145, 400, 40)
    context.stroke_preserve
    context.fill
    context.translate(220, 180)
    context.scale(1, 0.7)
    context.arc(0, 0, 50, 0, 6.283)
    context.stroke_preserve
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

 









