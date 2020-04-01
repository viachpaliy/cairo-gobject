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

# enum Content is generated "crystal-gobject" in compile time.
# Content is used to describe the content that a surface will contain, whether color information, alpha information (translucence vs. opacity), or both.
#   ZERO_NONE = 0 
#   COLOR = 4096   The surface will hold color content only. 
#   ALPHA = 8192   The surface will hold alpha content only. 
#   COLOR_ALPHA = 12288  The surface will hold color and alpha content.

# enum Status  is generated "crystal-gobject" in compile time.
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

# enum SurfaceType is generated "crystal-gobject" in compile time.
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

# enum DeviceType is generated "crystal-gobject" in compile time.
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

# enum FontType is generated "crystal-gobject" in compile time.
# FontType is used to describe the type of a given font face or scaled font.
# The font types are also known as "font backends" within cairo.
#   ZERO_NONE = 0
#   TOY = 0        The font was created using cairo's toy font api 
#   FT = 1         The font is of type FreeType 
#   WIN32 = 2      The font is of type Win32 
#   QUARTZ = 3     The font is of type Quartz (Since: 1.6) 
#   USER = 4       The font was create using cairo's user font api (Since: 1.8)

# enum Antialias is generated "crystal-gobject" in compile time.
# Specifies the type of antialiasing to do when rendering text or shapes.
#   ZERO_NONE = 0
#   DEFAULT = 0     Use the default antialiasing for the subsystem and target device 
#   NONE = 1        Use a bilevel alpha mask
#   GRAY = 2        Perform single-color antialiasing (using shades of gray for black text on a white background, for example). 
#   SUBPIXEL = 3    Perform antialiasing by taking advantage of the order of subpixel elements on devices such as LCD panels 
#   FAST = 4
#   GOOD = 5
#   BEST = 6

# enum SubpixelOrder is generated "crystal-gobject" in compile time.
# The subpixel order specifies the order of color elements within each pixel on the display device
# when rendering with an antialiasing mode of Cairo::Antialias::SUBPIXEL.
#   ZERO_NONE = 0
#   DEFAULT = 0    Use the default subpixel order for for the target device 
#   RGB = 1        Subpixel elements are arranged horizontally with red at the left 
#   BGR = 2        Subpixel elements are arranged horizontally with blue at the left 
#   VRGB = 3       Subpixel elements are arranged vertically with red at the top
#   VBGR = 4       Subpixel elements are arranged vertically with blue at the top

# enum HintStyle is generated "crystal-gobject" in compile time.
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

# enum HintMetrics is generated "crystal-gobject" in compile time.
# Specifies whether to hint font metrics; hinting font metrics means quantizing them so that they are integer values in device space.
# Doing this improves the consistency of letter and line spacing,
# however it also means that text will be laid out differently at different zoom factors.
#   ZERO_NONE = 0
#   DEFAULT = 0      Hint metrics in the default manner for the font backend and target device
#   OFF = 1          Do not hint font metrics  
#   ON = 2           Hint font metrics

# enum PatternType is generated "crystal-gobject" in compile time.
# PatternType is used to describe the type of a given pattern.
#   SOLID    -  The pattern is a solid (uniform) color. It may be opaque or translucent.
#   SURFACE  -  The pattern is a based on a surface (an image).
#   LINEAR   -  The pattern is a linear gradient. 
#   RADIAL   -  The pattern is a radial gradient. 

# enum Filter is generated "crystal-gobject" in compile time.
# Filter is used to indicate what filtering should be applied when reading pixel values from patterns.
#    FAST      - a high-performance filter, with quality similar to Cairo::Filter::NEAREST 
#    GOOD       - a reasonable-performance filter, with quality similar to Cairo::Filter::BILINEAR
#    BEST       - the highest-quality available, performance may not be suitable for interactive use. 
#    NEAREST    - nearest-neighbor filtering. 
#    BILINEAR   - linear interpolation in two dimensions. 
#    GAUSSIAN   - this filter value is currently unimplemented, and should not be used in current code. 

# enum Extend is generated "crystal-gobject" in compile time.
# Extend is used to describe how pattern color/alpha will be determined for areas "outside" the pattern's natural area,
# (for example, outside the surface bounds or outside the gradient geometry). 
# The default extend mode is Cairo::Extend::NONE for surface patterns and Cairo::Extend::PAD for gradient patterns. 
#    NONE      -  pixels outside of the source pattern are fully transparent
#    REPEAT    -  the pattern is tiled by repeating
#    REFLECT   -  the pattern is tiled by reflecting at the edges (Implemented for surface patterns since 1.6) 
#    PAD       -  pixels outside of the pattern copy the closest pixel from the source (Since 1.2; but only implemented for surface patterns since 1.6) 
