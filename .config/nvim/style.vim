" Colors
syntax on
set termguicolors
colorscheme codedark
let g:codedark_italics=1

" Get background color from colorscheme
let nvim_tree_bg_color=synIDattr(hlID('Folded'), 'bg#')

" Nvim Tree
exe "hi NvimTreeNormal guibg=" . nvim_tree_bg_color
exe "hi Directory guibg=" . nvim_tree_bg_color
exe "hi NvimTreeEndOfBuffer guibg=" . nvim_tree_bg_color . " guifg=" . nvim_tree_bg_color

