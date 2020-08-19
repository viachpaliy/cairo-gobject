# This programme save "cairo" binding,
# which "crystal-gobject" create in runtime.
 
require "gobject/g_i_repository"
require "gobject/generator/namespace"
require "gobject/crout"

namespace = Namespace.new("cairo")

namespace.dependencies.each do |dependency, version|
  puts "require_gobject(\"#{dependency}\")"
end

filename = Dir.current + "//cairo_binding.cr"

file = File.open(filename,"w")

Crout.build(file) do |builder|
  namespace.lib_definition(builder)
  namespace.wrapper_definitions(builder)
end
