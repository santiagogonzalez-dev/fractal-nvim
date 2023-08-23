# fractal-nvim 🏴

This is my personal config, I tried to modularize it, the `./fractal` reads from
the JSON config `./fractal.json` and it loads `./lua/user` for you, you just
need to load the library from your `init.lua`.

## Config

It behaves like any other library, you just need to have the `fractal`
directory in your repo and load the file after your user configs like so:

```lua
require("user")
dofile(vim.fn.stdpath("config") .. "/fractal/init.lua")
```

## fractal.json

The file `fractal.json` is an easy way of using the modules that I've
written, this is a basic example:

```json
{
  "colorscheme": "jetjbp",
  "modules": {
    "system-notifications": true,
    "status": "hide"
  }
}
```

## Modules

You can check them out under `./fractal/fractal/modules`. To use enable them
from your `fractal.json` you just need to use the same name of the module and
depending on the `setup()` you can either pass a `true` or a string for mapping
which make this modules available.

## Plugins
