# Favi

This is a simple Neovim plugin to store your favourites files and directories.

## Usage
Plugin stores all of your favourite files in file `favi`. In order to go to one of your favourite files
You can use `FaviEdit` command 
```viml
:FaviEdit <You can type only part of the query. Command will try to expand query on its own>
```
In order to add a file to your favourites, you can use `FavAdd` command.
```viml
:FaviAdd
```
By default `.config/nvim/init.vim` and `favi` are inserted by favi into the favourites.

## Installation

### vim-plug

An example of how to load this plugin using vim-plug:

```VimL
Plug 'kuator/favi'
```

After running `:PlugInstall`, the files should appear in your `~/.config/nvim/plugged` directory (or whatever path you have configured for plugins).
