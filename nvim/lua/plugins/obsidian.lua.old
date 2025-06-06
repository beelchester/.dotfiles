local workspace_path = '/Volumes/VERACRYPT/Obsidian/saaa/'
local workspaces = {}
--NOTE: random path to avoid error of atleast one workspace required
local decoy = '/Users/sahil/Documents/wallpapers_that_goes_hard_with_catppuccin/'

-- Check if the path exists
if vim.loop.fs_stat(workspace_path) then
  table.insert(workspaces, {
    name = 'personal',
    path = workspace_path,
  })
else
  table.insert(workspaces, {
    name = 'decoy',
    path = decoy,
  })
end

return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = workspaces,
    disable_frontmatter = true,
    daily_notes = {
      folder = 'Daily Notes/' .. os.date '%Y/%m-%B/',
      -- folder: "Daily Notes/ YYYY/MM-MMMM/"
      -- Date format: YYYY-MM-DD-dddd"
      date_format = '%Y-%m-%d-%A',
      default_tags = { 'daily-notes' },
      template = 'Templates/Daily note template.md',
    },
    templates = {
      folder = 'Templates/',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },
    note_path_func = function(spec)
      local path = spec.dir / tostring(spec.title)
      return path:with_suffix '.md'
    end,
  },
  mappings = {
    ['gd'] = {
      action = function()
        return require('obsidian').util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
  },
  wiki_link_func = 'use_alias_only',
  note_id_func = function(title)
    return title
  end,
  attachments = {
    img_folder = '02 Files', -- This is the default
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },
}
