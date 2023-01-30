local present, lualine = pcall(require, "lualine")

if not present then
  return
end

lualine.setup {
  options = {
    globalstatus = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha' },
  },
  extensions = { 'neo-tree' }
}
