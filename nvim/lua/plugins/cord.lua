return {
  'vyfor/cord.nvim',
  build = './build',
  -- event = 'VeryLazy',
  opts = {
    usercmds = true, -- Enable user commands
    timer = {
      enable = true, -- Enable automatically updating presence
      interval = 1500, -- Interval between presence updates in milliseconds (min 500)
      reset_on_idle = true, -- Reset start timestamp on idle
      reset_on_change = false, -- Reset start timestamp on presence change
    },
    editor = {
      image = nil, -- Image ID or URL in case a custom client id is provided
      client = 'neovim', -- vim, neovim, lunarvim, nvchad, astronvim or your application's client id
      tooltip = 'Chad Editor', -- Text to display when hovering over the editor's image
    },
    display = {
      show_time = false, -- Display start timestamp
      show_repository = false, -- Display 'View repository' button linked to repository url, if any
      show_cursor_position = true, -- Display line and column number of cursor's position
      swap_fields = true, -- If enabled, workspace is displayed first
      workspace_blacklist = {}, -- List of workspace names to hide
    },
    lsp = {
      show_problem_count = true, -- Display number of diagnostics problems
      severity = 1, -- 1 = Error, 2 = Warning, 3 = Info, 4 = Hint
      scope = 'buffer', -- buffer or workspace
    },
    idle = {
      enable = true, -- Enable idle status
      show_status = false, -- Display idle status, disable to hide the rich presence on idle
      timeout = 2000, -- Timeout in milliseconds after which the idle status is set, 0 to display immediately
      disable_on_focus = false, -- Do not display idle status when neovim is focused
      text = 'Idle', -- Text to display when idle
      tooltip = '💤', -- Text to display when hovering over the idle image
    },
    text = {
      viewing = '🌊', -- Text to display when viewing a readonly file
      editing = '🌊', -- Text to display when editing a file
      file_browser = '🌊', -- Text to display when browsing files (Empty string to disable)
      plugin_manager = '🌊', -- Text to display when managing plugins (Empty string to disable)
      lsp_manager = '🌊', -- Text to display when managing LSP servers (Empty string to disable)
      workspace = '', -- Text to display when in a workspace (Empty string to disable)
    },
    buttons = {
      {
        label = 'View Repository', -- Text displayed on the button
        url = 'git', -- URL where the button leads to ('git' = Git repository URL)
      },
    },
  },
}
