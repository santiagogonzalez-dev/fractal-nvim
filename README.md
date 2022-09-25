# csj-neovim 🏴

This is my personal config, it reads from a json file to enable some modules
that I wrote and it covers all my basic needs.

If you want a deferred startup of neovim you can start it using the provided
`csjneovim.lua` instead of the default `init.lua` like so:

```bash
nvim -u ${XDG_CONFIG_HOME}/nvim/csjneovim.lua <a_random_file>
```

And that's how we get this [startup times](./time.txt), but beware using this
alternative will lead to spellsitter not working at all and netrw not starting
if you try to open a directory with neovim:

```bash
nvim -u ${XDG_CONFIG_HOME}/nvim/csjneovim.lua lua/ # For example
```

So you'll have to `:e` for netrw to show up.

## Config

Most of your configs should go under `./user`, and if you want to make use of
the modules that this config provides you could open `./user/settings.json` and
figure out what things are useful to you.
