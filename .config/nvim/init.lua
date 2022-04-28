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
map("n", "<leader>.", "<Plug>(coc-codeaction)", {silent = true, noremap = true})
map("n", "gd", "<Plug>(coc-definition)", {silent = true, noremap = true})
map("n", "<C-K>", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
map("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true, noremap = true})
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
map("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
map("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
map("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
map("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- set colorscheme
vim.cmd([[colorscheme catppuccin]])

-- plugin time
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use {
    'catppuccin/nvim',
    as = 'catppuccin',
    config = function()
      require("catppuccin").setup {}
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'catppuccin',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
        },
        extensions = { 'nvim-tree' }
      }
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
  use 'tpope/vim-commentary'
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
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }
  use 'andweeb/presence.nvim'
end)
