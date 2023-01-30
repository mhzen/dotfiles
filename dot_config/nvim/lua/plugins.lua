return {
  -- Eye Candy
  --[[ {
    'catppuccin/nvim',
    name = 'catppuccin',
    config = function() require('config.catppuccin') end,
    build = ':CatppuccinCompile',
    lazy = false
  }, ]]
  {
    'folke/tokyonight.nvim',
    config = function() vim.cmd[[colorscheme tokyonight-night]] end,
    lazy = false
  },
  {
    'kyazdani42/nvim-web-devicons',
    event = 'BufRead'
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.lualine') end
  },
  {
    'akinsho/bufferline.nvim',
    event = 'BufReadPre',
    config = function() require('config.bufferline') end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPre',
    config = function() require('config.blankline') end
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
    config = function() require('config.telescope') end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    cmd = 'Neotree',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim'
    },
    config = true
    -- config = function() require('config.neotree') end,
  },
  {
    'goolord/alpha-nvim',
    lazy = false,
    dependencies = { 'kyazdani42/nvim-web-devicons' },
    config = function() require('config.alpha') end
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
    keys = { 'gc' },
    config = true,
  },
  {
    'kylechui/nvim-surround',
    keys = { 'ys', 'ds', 'cs' },
    config = true,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = true
  }
}
