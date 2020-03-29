# This programme save "cairo" binding,
# which "crystal-gobject" create in runtime.
 
require "gobject/g_i_repository"
require "gobject/generator/namespace"

namespace = Namespace.new("cairo")

namespace.dependencies.each do |dependency, version|
  puts "require_gobject(\"#{dependency}\")"
end

filename = Dir.current + "//samples//cairo_binding.cr"
file = File.open(filename,"w")
namespace.lib_definition(file)
namespace.wrapper_definitions(file, namespace.typelib_path)
