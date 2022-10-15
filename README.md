# fractal-nvim 🏴
This is my personal config, it reads from a json file to enable some modules
that I wrote and it covers all my basic needs.

# Why the name fractal-nvim?
I choose it randomly just like I did with csj-neovim, and I like how it sounds
🙂.

## Config
Most of your configs should go under `./user`, just treat it like the lua
directory, with the difference that you can clearly differentiate your user
configs from the modules written by me.  Also do note that your
`./user/init.lua` will be run after reading your `settings.json`.

## settings.json
The file `./user/settings.json` is an easy way of configuring neovim, this is a
basic example:

```json
{
  "colorscheme": "jetjbp",
  "modules": {
    "notifications": true,
    "status": "hide-completely",
  },
  "opts": {
    "clipboard": "unnamedplus",
    "cursorcolumn": true,
    "cursorline": true,
    "wrap": false
  }
}
```

## Modules
There's modules that change the behaviour of the config, for example `"status":
"hide-completely"` gets ride of the statusline at all, you can figure how
everything works by searching for `DESCRIPTION` and `setup` in the modules
located under `./lua/fractal/modules/*.lua`.
