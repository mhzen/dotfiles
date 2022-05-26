local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- set options
local opt = vim.opt
opt.tabstop = 2
opt.shiftwidth = 0
opt.expandtab = true
opt.smartindent = true
opt.nu = true
opt.wrap = false
opt.smartcase = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true
opt.incsearch = true
opt.ignorecase = true
opt.mouse = "a"
opt.hidden = true
opt.updatetime= 300
opt.signcolumn = "number"
opt.relativenumber = true
opt.winblend = 10
opt.termguicolors = true

-- set keybinds
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
map("n", "<leader>ff", ":Telescope find_files<CR>", {silent = true, noremap = true})
map("n", "m<Down>", ":m .+1<CR>", {silent = true, noremap = true})
map("n", "m<Up>", ":m .-2<CR>", {silent = true, noremap = true})
map("n", "<leader><esc>", ":noh<CR>", {silent = true, noremap = true})
map("n", "<leader>w", ":w<CR>", {silent = true, noremap = true})
map("n", "<leader><Right>", ":BufferLineCycleNext<CR>", {silent = true, noremap = true})
map("n", "<leader><Left>", ":BufferLineCyclePrev<CR>", {silent = true, noremap = true})
map("n", "<leader>x", ":bd<CR>", {silent = true, noremap = true})
map("n", "<leader>e", ":NvimTreeFocus<CR>", {silent = true, noremap = true})
map("n", "<leader>q", ":NvimTreeClose<CR>", {silent = true, noremap = true})

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
      local lspconfig = require('lspconfig')
      -- Enable some language servers with the additional completion capabilities offered by nvim-cmp
      local servers = { 'pyright', 'sumneko_lua' }
      for _, lsp in ipairs(servers) do
        lspconfig[lsp].setup {
          -- on_attach = my_custom_on_attach,
          capabilities = capabilities,
        }
      end
      -- luasnip setup
      local luasnip = require 'luasnip'
      -- nvim-cmp setup
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
    end
  }
  use {
    'Shatur/neovim-ayu',
    config = function()
      vim.cmd([[colorscheme ayu-dark]])
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'ayu_dark',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        extensions = { 'nvim-tree' }
      }
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'akinsho/bufferline.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    tag = "*",
    config = function ()
      require("bufferline").setup {
        options = {{ filetype = "NvimTree", text = "File Explorer", padding = 0 }},
      }
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true
  	    }
      }
    end
  }
  use {
    'b3nj5m1n/kommentary',
    config = function ()
      require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
      })
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function ()
      require('nvim-autopairs').setup({
        disable_filetype = { "TelescopePrompt", "vim" }
      })
    end
  }
  use {
    'ur4ltz/surround.nvim',
    config = function ()
      require("surround").setup {
        mappings_style = "sandwich",
      }
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require'nvim-tree'.setup {
        hijack_cursor = true,
      }
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {'nvim-lua/plenary.nvim'}
  }
  use {
    'goolord/alpha-nvim',
    config = function ()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- Set header
      dashboard.section.header.val = {
          " ⡆⣐⢕⢕⢕⢕⢕⢕⢕⢕⠅⢗⢕⢕⢕⢕⢕⢕⢕⠕⠕⢕⢕⢕⢕⢕⢕⢕⢕⢕ ",
          " ⢐⢕⢕⢕⢕⢕⣕⢕⢕⠕⠁⢕⢕⢕⢕⢕⢕⢕⢕⠅⡄⢕⢕⢕⢕⢕⢕⢕⢕⢕ ",
          " ⢕⢕⢕⢕⢕⠅⢗⢕⠕⣠⠄⣗⢕⢕⠕⢕⢕⢕⠕⢠⣿⠐⢕⢕⢕⠑⢕⢕⠵⢕ ",
          " ⢕⢕⢕⢕⠁⢜⠕⢁⣴⣿⡇⢓⢕⢵⢐⢕⢕⠕⢁⣾⢿⣧⠑⢕⢕⠄⢑⢕⠅⢕ ",
          " ⢕⢕⠵⢁⠔⢁⣤⣤⣶⣶⣶⡐⣕⢽⠐⢕⠕⣡⣾⣶⣶⣶⣤⡁⢓⢕⠄⢑⢅⢑ ",
          " ⠍⣧⠄⣶⣾⣿⣿⣿⣿⣿⣿⣷⣔⢕⢄⢡⣾⣿⣿⣿⣿⣿⣿⣿⣦⡑⢕⢤⠱⢐ ",
          " ⢠⢕⠅⣾⣿⠋⢿⣿⣿⣿⠉⣿⣿⣷⣦⣶⣽⣿⣿⠈⣿⣿⣿⣿⠏⢹⣷⣷⡅⢐ ",
          " ⣔⢕⢥⢻⣿⡀⠈⠛⠛⠁⢠⣿⣿⣿⣿⣿⣿⣿⣿⡀⠈⠛⠛⠁⠄⣼⣿⣿⡇⢔ ",
          " ⢕⢕⢽⢸⢟⢟⢖⢖⢤⣶⡟⢻⣿⡿⠻⣿⣿⡟⢀⣿⣦⢤⢤⢔⢞⢿⢿⣿⠁⢕ ",
          " ⢕⢕⠅⣐⢕⢕⢕⢕⢕⣿⣿⡄⠛⢀⣦⠈⠛⢁⣼⣿⢗⢕⢕⢕⢕⢕⢕⡏⣘⢕ ",
          " ⢕⢕⠅⢓⣕⣕⣕⣕⣵⣿⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣷⣕⢕⢕⢕⢕⡵⢀⢕⢕ ",
          " ⢑⢕⠃⡈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⢃⢕⢕⢕ ",
          " ⣆⢕⠄⢱⣄⠛⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⢁⢕⢕⠕⢁ ",
          " ⣿⣦⡀⣿⣿⣷⣶⣬⣍⣛⣛⣛⡛⠿⠿⠿⠛⠛⢛⣛⣉⣭⣤⣂⢜⠕⢑⣡⣴⣿ ",
      }

      -- Set menu
      dashboard.section.buttons.val = {
          dashboard.button( "e", "  new" , ":enew <BAR> startinsert <CR>"),
          dashboard.button( "f", "  find", ":cd $HOME/dev | Telescope find_files<CR>"),
          dashboard.button( "r", "  recent"   , ":Telescope oldfiles<CR>"),
          -- dashboard.button( "s", "  init.lua" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
          dashboard.button( "s", "  init.lua" , ":e $MYVIMRC<CR>"),
          dashboard.button( "u", "  update" , ":PackerSync<CR>"),
          dashboard.button( "q", "  quit", ":qa<CR>"),
      }

      -- Send config to alpha
      alpha.setup(dashboard.opts)

      -- Disable folding on alpha buffer
      vim.cmd([[
          autocmd FileType alpha setlocal nofoldenable
      ]])
    end
  }
  use {"ellisonleao/glow.nvim", branch = 'main'}
  if packer_bootstrap then
    require('packer').sync()
  end
end)
