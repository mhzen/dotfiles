return {
  -- Eye Candy
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      disable_background = true,
    },
    config = function ()
      vim.cmd.colorscheme "rose-pine"
    end,
    lazy = false
  },
  {
    'nvim-tree/nvim-web-devicons',
    event = 'BufRead'
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        globalstatus = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'starter' },
      },
      extensions = { 'nvim-tree', 'lazy' }
    },
    config = true
  },
  {
    'romgrk/barbar.nvim',
    event = 'BufReadPre',
    opts = {
      icons = {
        button = '',
        separator = {left = '', right = ''},
        inactive = {separator = {left = '', right = ''}},
      },
      sidebar_filetypes = {
        -- ['neo-tree'] = {event = 'BufWipeout'},
        NvimTree = true,
      },
    },
    config = true
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPre',
    config = true
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = 'BufReadPost',
    config = function() require('config.treesitter') end
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    cmd = 'Telescope',
    config = {
      function() require('config.telescope') end
    }
  },
  {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    cmd = { 'NvimTreeFocus', 'NvimTreeToggle' },
    -- lazy = false,
    config = function () require('config.nvimtree') end,
  },
  {
    'echasnovski/mini.starter',
    lazy = false,
    version = false,
    config = true
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets'
    },
    config = function() require('config.luasnip') end
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lsp-signature-help' },
      { 'saadparwaiz1/cmp_luasnip' }
    },
    config = function() require('config.cmp') end
  },
  {
    'williamboman/mason.nvim',
    cmd = {
      'Mason',
      'MasonInstall',
      'MasonUninstall',
      'MasonUninstallAll',
      'MasonLog'
    },
    config = true
  },
  {
    'neovim/nvim-lspconfig',
    event = "BufReadPre",
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'williamboman/mason-lspconfig.nvim'
    },
    config = function() require('config.lsp') end,
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { "gcc", mode = "n" },
      { "gc", mode = "v" },
      { "gbc", mode = "n" },
      { "gb", mode = "v" },
    },
    config = true,
  },
  -- {
  --   'kylechui/nvim-surround',
  --   keys = { 'ys', 'ds', 'cs' },
  --   config = true,
  -- },
  {
    "echasnovski/mini.surround",
    version = false,
    event = "VeryLazy",
    config = true,
  },
  {
    'phaazon/hop.nvim',
    event = 'BufReadPre',
    config = true
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    cmd = { 'ToggleTerm' },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
     -- your configuration comes here
     -- or leave it empty to use the default settings
     -- refer to the configuration section below
    },
  }
}
