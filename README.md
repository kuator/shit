# Favi

This is a simple Neovim plugin to store your favourites files and directories.

## Demo
Here, I have blank_note folder in my favourites, I can switch to it just by typing bl.
Favi will try to find a file/folder that contains bl in its path.
Or you can tab through files if you want to be sure about the target folder/file
-![](https://user-images.githubusercontent.com/25168308/76953657-45018000-6939-11ea-8e07-dac71107cbe2.gif)

## Usage
Plugin stores all of your favourite files in file `favi`. In order to go to one of your favourite files
You can use `FaviEdit` command 
```viml
:FaviEdit <You can type only part of the query. Command will try to expand query on its own>
```
In order to add a file to your favourites, you can use `FaviAddFile` command.
```viml
:FaviAddFile
```
If, instead, you want to bookmark a directory, use the following command.
```viml
:FaviAddDirectory
```
By default `.config/nvim/init.vim` and `favi` are inserted by favi into the favourites.

## Installation

### vim-plug

An example of how to load this plugin using vim-plug:

```VimL
Plug 'kuator/favi'
```

After running `:PlugInstall`, the files should appear in your `~/.config/nvim/plugged` directory (or whatever path you have configured for plugins).
