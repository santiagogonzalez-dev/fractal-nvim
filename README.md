# csj-neovim 🏴

This is my personal config, it reads from a json file to enable some modules
that I wrote and it covers all my basic needs.

If you want a deferred startup of neovim you can start it using the provided
`csjneovim.lua` instead of the default `init.lua` like so:

```bash
nvim -u ${XDG_CONFIG_HOME}/nvim/csjneovim.lua
```

And that's how we get this [startup times](./time.txt)

## Config

Most of your configs should go under `./user`, and if you want to make use of
the modules that this config provides you could open `./user/settings.json` and
figure out what things are useful to you.
