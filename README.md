# cairo-gobject

Cairo binding for use with Gdk and Gtk widgets.
Works with "gobject" shard (https://github.com/jhass/crystal-gobject).
It is a fork "cairo-cr" shard (https://github.com/TamasSzekeres/cairo-cr)

## Installation

First install cairo:
```bash
sudo apt-get install libcairo2 libcairo2-dev
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

- [viachpaliy](https://github.com/your-github-user) - creator and maintainer
