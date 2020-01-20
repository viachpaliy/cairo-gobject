# cairo-gobject

Cairo binding for use with Gdk and Gtk widgets.
It is extension for compile-time generated bindings to "libcairo-gobject2" library.
This bindings is generated "gobject" shard (https://github.com/jhass/crystal-gobject).
I used mainly code from "cairo-cr" shard ,
so it is a fork "cairo-cr" shard (https://github.com/TamasSzekeres/cairo-cr)

## Installation

First install cairo:
```bash
sudo apt-get install libgirepository1.0-dev libgtk-3-dev libcairo-gobject2 
```

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     cairo-gobject:
       github: viachpaliy/cairo-gobject
   ```

2. Run `shards install`

## Usage

```crystal
require "gobject/gtk"
require "cairo"
```
For more details see the sample in [/samples](/samples) folder.

## Samples

Run sample :
```shell
  cd cairo-gobject
  shards install
  crystal run samples/sample_name.cr
```

## Development

TODO: Write development instructions here

## Contributing

1. Fork it (<https://github.com/your-github-user/cairo-gobject/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [viachpaliy](https://github.com/viachpaliy) - creator and maintainer

## Introduction
Cairo-gobject is a Crystal shard for working with the Cairo library.
It is a set of Crystal bindings to the Cairo C library.
It closely matches the C API with the exception of cases, where more Crystal way is desirable.

###Cairo
Cairo is a library for creating 2D vector graphics. It is written in the C programming language.  
Bindings for other computer languages exist, including Python, Perl, C++, C#, or Java.  
Cairo is a multiplatform library; it works on Linux, BSDs, Windows, and OSX.   
Cairo supports various backends. Backends are output devices for displaying the created graphics.   
* X Window System
* Win32 GDI
* Mac OS X Quartz
* PNG
* PDF
* PostScript
* SVG
This means that we can use the library to draw on Windows, Linux, Windows, OSX  
and we can use the library to create PNG images, PDF files, PostScript files, and SVG files.   
We can compare the Cairo library to the GDI+ library on Windows OS and the Quartz 2D on Mac OS.  
Cairo is an open source software library. From version 2.8, Cairo is part of the GTK system.  

###Definitions
Here we provide some useful definitions. To do some drawing in Cairo, we must first create a drawing *context*.  
The drawing *context* holds all of the graphics state parameters that describe how drawing is to be done.  
This includes information such as line width, color, the surface to draw to, and many other things.  
It allows the actual drawing functions to take fewer arguments to simplify the interface. 

A *path* is a collection of points used to create primitive shapes such as lines, arcs, and curves.
There are two kinds of *paths*: open and closed *paths*. In a closed *path*, starting and ending points meet.  
In an open *path*, starting and ending point do not meet. In Cairo, we start with an empty *path*.  
First, we define a *path* and then we make them visible by stroking and/or filling them.  
After each `stroke` or `fill` method call, the *path* is emptied. We have to define a new *path*.  
If we want to keep the existing *path* for later drawing, we can use the `stroke_preserve` and `fill_preserve` methods.  
A *path* is made of subpaths. 

A *source* is the paint we use in drawing. We can compare the source to a pen or ink that we use to draw the outlines  
and fill the shapes. There are four kinds of basic *sources*: colors, gradients, patterns, and images. 

A *surface* is a destination that we are drawing to. We can render documents using the PDF or PostScript surfaces,  
directly draw to a platform via the Xlib and Win32 surfaces. 

Before the source is applied to the surface, it is filtered first. The *mask* is used as a filter.  
It determines where the *source* is applied and where not. Opaque parts of the *mask* allow to copy the *source*.
Transparent parts do not let to copy the *source* to the *surface*. 

A *pattern* represents a *source* when drawing onto a *surface*. In Cairo, a *pattern* is something  
that you can read from and that is used as the *source* or *mask* of a drawing operation.  
*Patterns* can be solid, surface-based, or gradients.

