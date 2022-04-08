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

-- set mapleader
vim.g.mapleader = ","

-- set keybinds
vim.api.nvim_set_keymap("n", "<leader>.", "<Plug>(coc-codeaction)", {})
vim.api.nvim_set_keymap("n", "<leader>l", ":CocCommand eslint.executeAutofix<CR>", {})
vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {silent = true})
vim.api.nvim_set_keymap("n", "<C-K>", ":call CocActionAsync('doHover')<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {})
vim.api.nvim_set_keymap("n", "<leader>f", ":CocCommand prettier.formatFile<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", {noremap = true})
vim.api.nvim_set_keymap("n", "m<Down>", ":m .+1<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "m<Up>", ":m .-2<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader><Right>", ":BufferLineCycleNext<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader><Left>", ":BufferLineCyclePrev<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>x", ":bd<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle<CR>", {silent = true, noremap = true})
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", {noremap = true, silent = true, expr = true})
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", {noremap = true, expr = true})
vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'", {silent = true, expr = true, noremap = true})

-- set colorscheme
vim.cmd([[colorscheme codedark]])

-- plugin time
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'tomasiser/vim-code-dark'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function ()
      require('lualine').setup {
        options = {
          theme = 'codedark',
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
      options = {
        offsets = {{ filetype = "NvimTree", text = "File Explorer", padding = 0 }},
      }
    end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    config = function ()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true
        },
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
end)
