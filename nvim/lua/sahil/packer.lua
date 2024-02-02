vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	
  use({"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"})

	 use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
	  
  }
  use { "Shatur/neovim-ayu", as = "ayu",
	  config = function()
		  vim.cmd('colorscheme ayu-dark')
	  end
  }

  use 'nvim-treesitter/playground'

  use('theprimeagen/harpoon')
  use('mbbill/undotree')
  use('tpope/vim-fugitive')
  use 'andweeb/presence.nvim'
  use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  requires = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
 }
}

use 'folke/lsp-colors.nvim'
use 'neovim/nvim-lspconfig'
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
}
use {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
    panel = {
    enabled = true,
    auto_refresh = true,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "bottom", 
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-l>",
      accept_word = false,
      accept_line = false,
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>",
    },
  },
  filetypes = {
    yaml = false,
    markdown = false,
    help = false,
    gitcommit = false,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = 'node', 
  server_opts_overrides = {},
    })
  end,
}
use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}
use {
    "norcalli/nvim-colorizer.lua",
    config = function() require("colorizer").setup() end
}
use { 'mrshmllow/document-color.nvim', config = function()
  require("document-color").setup {
    mode = "background", 
  }
  end
}
use({
	"L3MON4D3/LuaSnip",
	tag = "v<CurrentMajor>.*",
	run = "make install_jsregexp"
})
use {'windwp/nvim-ts-autotag'}
use "rafamadriz/friendly-snippets"
use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
}
use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup({
          on_attach = function(bufnr)
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end
      }) end
    }

    use({
  "utilyre/barbecue.nvim",
  tag = "*",
  requires = {
    "SmiteshP/nvim-navic",
    "nvim-tree/nvim-web-devicons",   },
  after = "nvim-web-devicons", 
  config = function()
    require("barbecue").setup()
  end,
})

use 'wakatime/vim-wakatime'

use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
use {'APZelos/blamer.nvim'}
use 'princejoogie/tailwind-highlight.nvim'
use({
  "roobert/tailwindcss-colorizer-cmp.nvim",
  config = function()
    require("tailwindcss-colorizer-cmp").setup({
      color_square_width = 2,
    })
  end
})
use('MunifTanjim/prettier.nvim')

use('rust-lang/rust.vim')


use 'simrat39/rust-tools.nvim'

use 'nvim-lua/plenary.nvim'
use 'mfussenegger/nvim-dap'
use 'ThePrimeagen/vim-be-good'

use {"akinsho/toggleterm.nvim"}

use{"jose-elias-alvarez/null-ls.nvim"}

use{"lewis6991/gitsigns.nvim"}
  end)
