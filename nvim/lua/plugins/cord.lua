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
      enabled = true,
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
      viewing = function(opts)
        return string.format('🌊 %s %s:%s', opts.filename, opts.cursor_line, opts.cursor_char)
      end,
      editing = function(opts)
        local now = os.date '*t'
        local work_time = (now.wday >= 2 and now.wday <= 6 and now.hour >= 12 and now.hour <= 20) or opts.workspace == 'helm' or opts.workspace == 'omni'
        local current_tag = ''
        -- if not work_time then
        --   current_tag = vim.fn['tagbar#currenttag']('%s', '', 'f')
        -- end

        local diagnostics = vim.diagnostic.get(0, { severity = { min = vim.diagnostic.severity.ERROR } })

        if #diagnostics > 0 then
          return string.format('💀 %s errors %s %s:%s', #diagnostics, opts.filename, opts.cursor_line, opts.cursor_char)
        end
        return string.format('🌊 %s %s:%s %s', opts.filename, opts.cursor_line, opts.cursor_char, current_tag)
      end,
      file_browser = function()
        return 'Browsing files'
      end,
      plugin_manager = function()
        return 'Managing plugins'
      end,
      lsp_manager = function()
        return 'Configuring LSP'
      end,
      docs = function()
        return 'Reading doc 🤓'
      end,
      vcs = function()
        return 'Committing changes'
      end,
      debug = function()
        return 'Debugging'
      end,
      test = function()
        return 'Testing'
      end,
      workspace = function(opts)
        local function get_status()
          local now = os.date '*t'
          return (now.wday >= 2 and now.wday <= 6 and now.hour >= 12 and now.hour <= 20) and 'At work dont ping 🦖' or nil
        end
        local status = get_status()
        if status then
          return string.format('%s', status)
        else
          if opts.workspace == 'kairos' or opts.workspace == 'kairos-cli' then
            -- return 'Side project time 🐼'
            -- return 'Cooking kairos 👨‍🍳'
            return ''
          elseif opts.workspace == '.config' then
            return 'Configuring workflow 🤡'
          end
          return ''
        end
      end,
      dashboard = 'Home',
    },
    buttons = nil,
    assets = nil,
    hooks = {
      on_ready = nil,
      on_update = nil,
      on_activity = nil,
      on_idle = nil,
      workspace_change = function(opts)
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
