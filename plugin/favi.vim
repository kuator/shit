" Maintainer:	kuator <kuatabylkasymov@gmail.com>
" Version:	0.0.1
" License:	MIT
" Location:	plugin/favi.vim
" Website:	https://github.com/kuator/favi

if exists("g:loaded_favi") || !has('nvim')
  finish
endif

let g:loaded_favi = 1
let s:save_cpo = &cpo
set cpo&vim

lua favi = require("favi")

lua require("favi").init_favi()

fun! s:ListFavourites(ArgLead, CmdLine, CursorPos)
   return luaeval('favi.list_favourite_files(_A[1])', [a:ArgLead])
endfun

com! -nargs=1 -complete=customlist,<sid>ListFavourites FaviEdit lua favi.edit_file('edit', <f-args>)
com! -nargs=1 -complete=customlist,<sid>ListFavourites FaviSplit lua favi.edit_file('split', <f-args>)
com! -nargs=1 -complete=customlist,<sid>ListFavourites FaviVertical lua favi.edit_file('vertical', <f-args>)
com! -nargs=1 -complete=customlist,<sid>ListFavourites FaviTabedit lua favi.edit_file('tabedit', <f-args>)
com! FaviAdd lua favi.add()<cr>

let &cpo = s:save_cpo
