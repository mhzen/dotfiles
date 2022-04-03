call plug#begin(stdpath('data') . '/plugged')

" Information
Plug 'nvim-lualine/lualine.nvim'
Plug 'akinsho/bufferline.nvim'

Plug 'tomasiser/vim-code-dark'

" Functionalities
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'karb94/neoscroll.nvim'
Plug 'windwp/nvim-autopairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'neovim/nvim-lspconfig'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Styling
Plug 'kyazdani42/nvim-web-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

