require "gobject"
require "./lib_cairo"
require "./surface.cr"
require "./font_face.cr"
require "./font_options.cr"
require "./device.cr"
require "./matrix.cr"
require "./region.cr"
require "./context.cr"
require "./scaled_font.cr"
require "./path.cr"
require "./module_functions.cr"
require "./pattern.cr"
require "./status_exception.cr"
require "./rectangle_int.cr"
require "./rectangle.cr"
require "./font_extents.cr"
require "./text_extents.cr"

# enum Content is defined "crystal-gobject" in compile time.
# Content is used to describe the content that a surface will contain, whether color information, alpha information (translucence vs. opacity), or both.
#   ZERO_NONE = 0 
#   COLOR = 4096   The surface will hold color content only. 
#   ALPHA = 8192   The surface will hold alpha content only. 
#   COLOR_ALPHA = 12288  The surface will hold color and alpha content.

# enum Status  is defined "crystal-gobject" in compile time.
# Status is used to indicate errors that can occur when using Cairo.
# In some cases it is returned directly by functions. But when using `Context`, the last error, if any, is stored in the context and can be retrieved with `Context#status()`. 
#    ZERO_NONE = 0
#    SUCCESS = 0                     no error has occurred
#    NO_MEMORY = 1                   out of memory 
#    INVALID_RESTORE = 2             `Context#restore()` called without matching `Context#save()` 
#    INVALID_POP_GROUP = 3           no saved group to pop, i.e. `Context#pop_group()` without matching `Context#push_group()`
#    NO_CURRENT_POINT = 4            no current point defined     
#    INVALID_MATRIX = 5              invalid matrix (not invertible)
#    INVALID_STATUS = 6              invalid value for an input Cairo::Status
#    NULL_POINTER = 7                nil pointer
#    INVALID_STRING = 8              input string not valid UTF-8
#    INVALID_PATH_DATA = 9           input path data not valid 
#    READ_ERROR = 10                 error while reading from input stream 
#    WRITE_ERROR = 11                error while writing to output stream
#    SURFACE_FINISHED = 12           target surface has been finished
#    SURFACE_TYPE_MISMATCH = 13      the surface type is not appropriate for the operation
#    PATTERN_TYPE_MISMATCH = 14      the pattern type is not appropriate for the operation 
#    INVALID_CONTENT = 15            invalid value for an input Cairo::`Content`
#    INVALID_FORMAT = 16             invalid value for an input Cairo::`Format`
#    INVALID_VISUAL = 17             invalid value for an input Gdk::Visual
#    FILE_NOT_FOUND = 18             file not found 
#    INVALID_DASH = 19               invalid value for a dash setting  
#    INVALID_DSC_COMMENT = 20        invalid value for a DSC comment (Since 1.2)  
#    INVALID_INDEX = 21              invalid index passed to getter (Since 1.4) 
#    CLIP_NOT_REPRESENTABLE = 22     clip region not representable in desired format (Since 1.4) 
#    TEMP_FILE_ERROR = 23            error creating or writing to a temporary file (Since 1.6) 
#    INVALID_STRIDE = 24             invalid value for stride (Since 1.6) 
#    FONT_TYPE_MISMATCH = 25         the font type is not appropriate for the operation (Since 1.8) 
#    USER_FONT_IMMUTABLE = 26        the user-font is immutable (Since 1.8) 
#    USER_FONT_ERROR = 27            error occurred in a user-font callback function (Since 1.8) 
#    NEGATIVE_COUNT = 28             negative number used where it is not allowed (Since 1.8) 
#    INVALID_CLUSTERS = 29           input clusters do not represent the accompanying text and glyph array (Since 1.8)    
#    INVALID_SLANT = 30              invalid value for an input Cairo::`FontSlant`
#    INVALID_WEIGHT = 31             invalid value for an input Cairo::`FontWeight`
#    INVALID_SIZE = 32               invalid value (typically too big) for the size of the input (surface, pattern, etc.) (Since 1.10) 
#    USER_FONT_NOT_IMPLEMENTED = 33  user-font method not implemented (Since 1.10) 
#    DEVICE_TYPE_MISMATCH = 34       the device type is not appropriate for the operation (Since 1.10) 
#    DEVICE_ERROR = 35               an operation to the device caused an unspecified error (Since 1.10)
#    INVALID_MESH_CONSTRUCTION = 36
#    DEVICE_FINISHED = 37
#    JBIG2_GLOBAL_MISSING = 38

# enum SurfaceType is defined "crystal-gobject" in compile time.
# SurfaceType is used to describe the type of a given surface.
# The surface types are also known as "backends" or "surface backends" within cairo.
#   ZERO_NONE = 0
#   IMAGE = 0             The surface is of type image 
#   PDF = 1               The surface is of type pdf 
#   PS = 2                The surface is of type ps 
#   XLIB = 3              The surface is of type xlib
#   XCB = 4               The surface is of type xcb   
#   GLITZ = 5             The surface is of type glitz
#   QUARTZ = 6            The surface is of type quartz   
#   WIN32 = 7             The surface is of type win32 
#   BEOS = 8              The surface is of type beos 
#   DIRECTFB = 9          The surface is of type directfb
#   SVG = 10              The surface is of type svg
#   OS2 = 11              The surface is of type os2
#   WIN32_PRINTING = 12   The surface is a win32 printing surface 
#   QUARTZ_IMAGE = 13     The surface is of type quartz_image 
#   SCRIPT = 14           The surface is of type script, since 1.10 
#   QT = 15               The surface is of type Qt, since 1.10 
#   RECORDING = 16        The surface is of type recording, since 1.10 
#   VG = 17               The surface is a OpenVG surface, since 1.10
#   GL = 18               The surface is of type OpenGL, since 1.10 
#   DRM = 19              The surface is of type Direct Render Manager, since 1.10 
#   TEE = 20              The surface is of type 'tee' (a multiplexing surface), since 1.10
#   XML = 21              The surface is of type XML (for debugging), since 1.10 
#   SKIA = 22             The surface is of type Skia, since 1.10 
#   SUBSURFACE = 23       The surface is a subsurface created with `Surface#create_for_rectangle()`, since 1.10
#   COGL = 24             The surface is of type COGL

# enum DeviceType is defined "crystal-gobject" in compile time.
# DeviceType is used to describe the type of a given device. The devices types are also known as "backends" within cairo.
#   ZERO_NONE = 0
#   DRM = 0         The device is of type Direct Render Manager
#   GL = 1          The device is of type OpenGL
#   SCRIPT = 2      The device is of type script
#   XCB = 3         The device is of type xcb 
#   XLIB = 4        The device is of type xlib
#   XML = 5         The device is of type xml
#   COGL = 6   
#   WIN32 = 7
#   INVALID = -1

# enum FontType is defined "crystal-gobject" in compile time.
# FontType is used to describe the type of a given font face or scaled font.
# The font types are also known as "font backends" within cairo.
#   ZERO_NONE = 0
#   TOY = 0        The font was created using cairo's toy font api 
#   FT = 1         The font is of type FreeType 
#   WIN32 = 2      The font is of type Win32 
#   QUARTZ = 3     The font is of type Quartz (Since: 1.6) 
#   USER = 4       The font was create using cairo's user font api (Since: 1.8)

# enum Antialias is defined "crystal-gobject" in compile time.
# Specifies the type of antialiasing to do when rendering text or shapes.
#   ZERO_NONE = 0
#   DEFAULT = 0     Use the default antialiasing for the subsystem and target device 
#   NONE = 1        Use a bilevel alpha mask
#   GRAY = 2        Perform single-color antialiasing (using shades of gray for black text on a white background, for example). 
#   SUBPIXEL = 3    Perform antialiasing by taking advantage of the order of subpixel elements on devices such as LCD panels 
#   FAST = 4
#   GOOD = 5
#   BEST = 6

# enum SubpixelOrder is defined "crystal-gobject" in compile time.
# The subpixel order specifies the order of color elements within each pixel on the display device
# when rendering with an antialiasing mode of Cairo::Antialias::SUBPIXEL.
#   ZERO_NONE = 0
#   DEFAULT = 0    Use the default subpixel order for for the target device 
#   RGB = 1        Subpixel elements are arranged horizontally with red at the left 
#   BGR = 2        Subpixel elements are arranged horizontally with blue at the left 
#   VRGB = 3       Subpixel elements are arranged vertically with red at the top
#   VBGR = 4       Subpixel elements are arranged vertically with blue at the top

# enum HintStyle is defined "crystal-gobject" in compile time.
# Specifies the type of hinting to do on font outlines.
# Hinting is the process of fitting outlines to the pixel grid in order to improve the appearance of the result.
# Since hinting outlines involves distorting them, it also reduces the faithfulness to the original outline shapes.
# Not all of the outline hinting styles are supported by all font backends.
#   ZERO_NONE = 0
#   DEFAULT = 0      Use the default hint style for font backend and target device 
#   NONE = 1         Do not hint outlines
#   SLIGHT = 2       Hint outlines slightly to improve contrast while retaining good fidelity to the original shapes.  
#   MEDIUM = 3       Hint outlines with medium strength giving a compromise between fidelity to the original shapes and contrast
#   FULL = 4         Hint outlines to maximize contrast

# enum HintMetrics is defined "crystal-gobject" in compile time.
# Specifies whether to hint font metrics; hinting font metrics means quantizing them so that they are integer values in device space.
# Doing this improves the consistency of letter and line spacing,
# however it also means that text will be laid out differently at different zoom factors.
#   ZERO_NONE = 0
#   DEFAULT = 0      Hint metrics in the default manner for the font backend and target device
#   OFF = 1          Do not hint font metrics  
#   ON = 2           Hint font metrics

# enum PatternType is defined "crystal-gobject" in compile time.
# PatternType is used to describe the type of a given pattern.
#   ZERO_NONE = 0
#   SOLID = 0    -  The pattern is a solid (uniform) color. It may be opaque or translucent.
#   SURFACE = 1  -  The pattern is a based on a surface (an image).
#   LINEAR = 2   -  The pattern is a linear gradient. 
#   RADIAL = 3   -  The pattern is a radial gradient.
#   MESH = 4
#   RASTER_SOURCE = 5

# enum Filter is defined "crystal-gobject" in compile time.
# Filter is used to indicate what filtering should be applied when reading pixel values from patterns.
#    ZERO_NONE = 0
#    FAST = 0       - a high-performance filter, with quality similar to Cairo::Filter::NEAREST 
#    GOOD = 1       - a reasonable-performance filter, with quality similar to Cairo::Filter::BILINEAR
#    BEST = 2       - the highest-quality available, performance may not be suitable for interactive use. 
#    NEAREST = 3    - nearest-neighbor filtering. 
#    BILINEAR = 4   - linear interpolation in two dimensions. 
#    GAUSSIAN = 5   - this filter value is currently unimplemented, and should not be used in current code. 

# enum Extend is defined "crystal-gobject" in compile time.
# Extend is used to describe how pattern color/alpha will be determined for areas "outside" the pattern's natural area,
# (for example, outside the surface bounds or outside the gradient geometry). 
# The default extend mode is Cairo::Extend::NONE for surface patterns and Cairo::Extend::PAD for gradient patterns.
#    ZERO_NONE = 0
#    NONE = 0     -  pixels outside of the source pattern are fully transparent
#    REPEAT = 1   -  the pattern is tiled by repeating
#    REFLECT = 2  -  the pattern is tiled by reflecting at the edges (Implemented for surface patterns since 1.6) 
#    PAD = 3      -  pixels outside of the pattern copy the closest pixel from the source (Since 1.2; but only implemented for surface patterns since 1.6)

# enum RegionOverlap is defined "crystal-gobject" in compile time.
# RegionOverlap is used as the return value for `Cairo::Region#contains?(rectangle : RectangleInt)`.
#    ZERO_NONE = 0
#    IN = 0    -  The contents are entirely inside the region.  
#    OUT = 1   -  The contents are entirely outside the region.  
#    PART = 2  -  The contents are partially inside and partially outside the region.  

# enum Operator is defined "crystal-gobject" in compile time.
# enum Operator  is used to set the compositing operator for all cairo drawing operations. 
# The default operator is Cairo::Operator::OVER. 
# The operators marked as unbounded modify their destination even outside of the mask layer (that is, their effect is not bound by the mask layer).
# However, their effect can still be limited by way of clipping. 
# To keep things simple, the operator descriptions here document the behavior for when both source and destination are either fully transparent or fully opaque.
# The actual implementation works for translucent layers too.
# For a more detailed explanation of the effects of each operator, including the mathematical definitions, see http://cairographics.org/operators/. 
#    ZERO_NONE = 0
#    CLEAR = 0            clear destination layer (bounded)  
#    SOURCE = 1           replace destination layer (bounded)  
#    OVER = 2             draw source layer on top of destination layer (bounded)  
#    IN = 3               draw source where there was destination content (unbounded)  
#    OUT = 4              draw source where there was no destination content (unbounded)  
#    ATOP = 5             draw source on top of destination content and only there  
#    DEST = 6             ignore the source  
#    DEST_OVER = 7        draw destination on top of source  
#    DEST_IN = 8          leave destination only where there was source content (unbounded)  
#    DEST_OUT = 9         leave destination only where there was no source content  
#    DEST_ATOP = 10       leave destination on top of source content and only there (unbounded)  
#    XOR = 11             source and destination are shown where there is only one of them  
#    ADD = 12             source and destination layers are accumulated  
#    SATURATE = 13        like over, but assuming source and dest are disjoint geometries  
#    MULTIPLY = 14        source and destination layers are multiplied. This causes the result to be at least as dark as the darker inputs.  
#    SCREEN = 15          source and destination are complemented and multiplied. This causes the result to be at least as light as the lighter inputs.  
#    OVERLAY = 16         multiplies or screens, depending on the lightness of the destination color.  
#    DARKEN = 17          replaces the destination with the source if it is darker, otherwise keeps the source.  
#    LIGHTEN = 18         replaces the destination with the source if it is lighter, otherwise keeps the source.  
#    COLOR_DODGE = 19     brightens the destination color to reflect the source color.  
#    COLOR_BURN = 20      darkens the destination color to reflect the source color.  
#    HARD_LIGHT = 21      multiplies or screens, dependant on source color.  
#    SOFT_LIGHT = 22      darkens or lightens, dependant on source color.  
#    DIFFERENCE = 23      takes the difference of the source and destination color.  
#    EXCLUSION = 24       produces an effect similar to difference, but with lower contrast.  
#    HSL_HUE = 25         creates a color with the hue of the source and the saturation and luminosity of the target.  
#    HSL_SATURATION = 26  creates a color with the saturation of the source and the hue and luminosity of the target. Painting with this mode onto a gray area prduces no change.  
#    HSL_COLOR = 27       creates a color with the hue and saturation of the source and the luminosity of the target.
#                         This preserves the gray levels of the target and is useful for coloring monochrome images or tinting color images.  
#    HSL_LUMINOSITY = 28  creates a color with the luminosity of the source and the hue and saturation of the target. This produces an inverse effect to CAIRO_OPERATOR_HSL_COLOR.  

# enum FillRule is defined "crystal-gobject" in compile time.
# FillRule is used to select how paths are filled.
# For both fill rules, whether or not a point is included in the fill is determined by taking a ray from that point to infinity and looking at intersections with the path.
# The ray can be in any direction, as long as it doesn't pass through the end point of a segment or have a tricky intersection such as intersecting tangent to the path.
# (Note that filling is not actually implemented in this way. This is just a description of the rule that is applied.) 
# The default fill rule is Cairo::FillRule::WINDING. 
#    ZERO_NONE = 0
#    WINDING = 0    If the path crosses the ray from left-to-right, counts +1. If the path crosses the ray from right to left, counts -1.
#                   (Left and right are determined from the perspective of looking along the ray from the starting point.)
#                   If the total count is non-zero, the point will be filled.  
#    EVEN_ODD =1    Counts the total number of intersections, without regard to the orientation of the contour. If the total number of intersections is odd, the point will be filled.  

# enum LineCap is defined "crystal-gobject" in compile time.
# LineCap Specifies how to render the endpoints of the path when stroking. 
# The default line cap style is Cairo::LineCap::BUTT. 
#   ZERO_NONE = 0
#   BUTT = 0       start(stop) the line exactly at the start(end) point
#   ROUND = 1      use a round ending, the center of the circle is the end point 
#   SQUARE = 2     use squared ending, the center of the square is the end point 

# enum LineJoin is defined "crystal-gobject" in compile time.
# Specifies how to render the junction of two lines when stroking. 
# The default line join style is Cairo::LineJoin::MITER. 
#   ZERO_NONE = 0
#   MITER = 0      use a sharp (angled) corner, see `Context#miter_limit=()` 
#   ROUND = 1      use a rounded join, the center of the circle is the joint point
#   BEVEL = 2      use a cut-off join, the join is cut off at half the line width from the joint point 
