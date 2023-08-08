local present, blankline = pcall(require, "indent_blankline")

if not present then
  return
end

blankline.setup {
  buftype_exclude = { "terminal" },
  filetype_exclude = { "help", "terminal", "dashboard", "packer", "alpha" },
}
