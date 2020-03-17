original_wildignore =  vim.api.nvim_get_option('wildignore')

local function clear_wildignore()
    vim.api.nvim_set_option('wildignore', '')
end

local function get_original_wildignore()
    return original_wildignore
end

local function restore_wildignore()
    vim.api.nvim_set_option('wildignore', get_original_wildignore())
end

local function get_favourites_location()
  clear_wildignore()
  local upath =  vim.api.nvim_get_option('path')
  local rtp = vim.api.nvim_get_option('runtimepath')
  vim.api.nvim_set_option('path', rtp)
  favourites = vim.api.nvim_call_function('findfile', {'favi'})
  vim.api.nvim_set_option('path', upath)
  restore_wildignore()
  return favourites
end

local function favourites_exist()
  return get_favourites_location() ~= ''
end

local function remove_duplicates()
  vim.api.nvim_command('sort u')
end

local function add(action)

  if not favourites_exist() then
    create_favourites_file()
  end

  local old_win = vim.api.nvim_call_function('winnr', {})

  if action == 1 then
    filename = vim.api.nvim_call_function('expand', {
      "%:p~"
    })
  elseif action == 2 then
    filename = vim.api.nvim_call_function('expand', {
      "%:p:~:h"
    })
  end

  favourites_window_id=vim.api.nvim_call_function('bufwinnr' ,{
    'favi'
  })

  if favourites_window_id ~= -1 then
    vim.api.nvim_command(favourites_window_id..'wincmd w')
    remove_duplicates()
  else
    vim.api.nvim_command('silent! botright 10 sp ' .. get_favourites_location())
    remove_duplicates()
  end

  -- vim.api.nvim_win_set_cursor(0, {1, 0})
  duplicate = vim.api.nvim_call_function('search', {
      vim.api.nvim_call_function('escape', {
        filename,
        '~\\',
      }),
      'w'
    }
  )

  if duplicate == 0 then
    filename = '\'' ..filename..'\''
    vim.api.nvim_command("0put="..filename)
    vim.api.nvim_command('silent! w')
  end

  if favourites_window_id == -1 then
    vim.api.nvim_command('silent! w')
    vim.api.nvim_command('silent! close')
    vim.api.nvim_command(old_win..'wincmd w')
  else 
    vim.api.nvim_command('silent! w')
    vim.api.nvim_command(old_win..'wincmd w')
  end
end

local function get_directory(str)
    return str:match("(.*[/\\])")
end

local function create_favourites_file()

  clear_wildignore()
  local favi = vim.api.nvim_call_function('findfile', {'favi/plugin/favi.vim'})
  restore_wildignore()
  local favourites = vim.api.nvim_call_function('substitute', {
    get_directory(favi),
    'plugin/$',
    'favi',
    ''
  })

  vim.api.nvim_command('silent! botright 10 sp ' .. favourites)

  local vimrc = vim.api.nvim_call_function('expand', {
    vim.api.nvim_call_function('getenv', {'MYVIMRC'})
  })

  favourites = vim.api.nvim_call_function('expand', {'%:p'}) 

  vimrc = '\'' ..vimrc..'\''
  favourites = '\'' ..favourites..'\''
  vim.api.nvim_command('0put='..vimrc)
  vim.api.nvim_command('0put=' .. favourites)
  vim.api.nvim_command('g/^$/d')
  vim.api.nvim_command('silent! write')
  vim.api.nvim_command('silent! close')
end

local function init_favi()
  if not favourites_exist() then
    create_favourites_file()
  end
end

local function list_favourite_files(arglead)
  local result = {}
  favourites = vim.api.nvim_call_function('systemlist', { 
    "cat " .. get_favourites_location() 
  })
  for i,v in ipairs(favourites) do
      if string.match(string.lower(v), string.lower(arglead)) then
        table.insert(result, v)
      end
    end
  return result
end

local function edit_file(command, arg)
  if command == 'tabedit' then
    vim.api.nvim_command(command .. arg .. "\\|lcd %:p:h")
  else
    vim.api.nvim_command(command .. arg)
  end
end

return {
    remove_duplicates =  remove_duplicates,
    add =  add,
    get_directory =  get_directory,
    clear_wildignore =  clear_wildignore,
    restore_wildignore =  restore_wildignore,
    create_favourites_file =  create_favourites_file,
    get_favourites_location =  get_favourites_location,
    list_favourite_files =  list_favourite_files,
    edit_file = edit_file,
    init_favi = init_favi,
}
