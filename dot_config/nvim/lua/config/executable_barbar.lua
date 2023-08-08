local present, barbar = pcall(require, "barbar")

if not present then
  return
end

vim.g.barbar_auto_setup = false

barbar.setup {
  icons = {
    button = '',
    separator = {left = '', right = ''},
    inactive = {separator = {left = '', right = ''}},
  },
  sidebar_filetypes = {
    -- ['neo-tree'] = {event = 'BufWipeout'},
    NvimTree = true,
  },
}
