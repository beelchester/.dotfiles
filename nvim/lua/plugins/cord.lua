-- FIXME: blacklist not working
local blacklist = {
  '/Volumes/VERACRYPT/Obsidian/saaa/',
  'saaa',
}

local is_blacklisted = function(opts)
  --TODO: Try to log this workspace_name
  return vim.tbl_contains(blacklist, opts.workspace_name)
end


return {
  'vyfor/cord.nvim',
  branch = 'client-server',
  build = ':Cord fetch',
  -- event = 'VeryLazy',

  opts = {
    editor = {
      client = 'neovim',
      tooltip = 'Chad editor',
      icon = nil,
    },
    display = {
      theme = 'onyx',
      swap_fields = false,
      swap_icons = false,
    },
    timestamp = {
      enabled = false,
      reset_on_idle = true,
      reset_on_change = false,
    },
    idle = {
      enabled = true,
      timeout = 300000,
      show_status = false,
      ignore_focus = true,
      smart_idle = true,
      details = 'Idling',
      state = nil,
      tooltip = '💤',
      icon = nil,
    },
    text = {
      viewing = function(opts) return string.format('🌊 %s:%s', opts.cursor_line, opts.cursor_char) end,
      editing = function(opts) return string.format('🌊 %s:%s', opts.cursor_line, opts.cursor_char) end,
      file_browser = function() return 'Browsing files' end,
      plugin_manager = function() return 'Managing plugins' end,
      lsp_manager = function() return 'Configuring LSP' end,
      docs = function() return 'Reading doc 🤓' end,
      vcs = function() return 'Committing changes' end,
      workspace = function()
        local hour = tonumber(os.date('%H'))
        local status =
        hour >= 22 and '🌙 Late night coding' or
        hour >= 18 and '🌆 Evening session' or
        hour >= 12 and '☀️ Afternoon coding' or
        hour >= 5 and '🌅 Morning productivity' or
        '🌙 Midnight hacking'
        return string.format('%s', status) end,
      dashboard = 'Home',
    },
    buttons = nil,
    assets = nil,
    variables = nil,
    hooks = {
      on_ready = nil,
      on_update = nil,
      on_activity = nil,
      on_idle = nil,
      on_workspace_change = function(opts)
        if is_blacklisted(opts) then
          opts.manager:skip_update() -- preferably skip updating the current activity
          opts.manager:hide()
        else
          opts.manager:resume()
        end
      end,
      on_disconnect = nil,
    },
    advanced = {
      plugin = {
        log_level = vim.log.levels.INFO,
        autocmds = true,
      },
      server = {
        pipe_path = nil,
        executable_path = nil,
        timeout = 60000,
      },
      cursor_update_mode = 'on_move',
      variables_in_functions = false,
    },
  },
}
