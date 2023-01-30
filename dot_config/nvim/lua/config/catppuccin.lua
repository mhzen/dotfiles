local present, catpuccin = pcall(require, "catppuccin")

if not present then
  return
end

catpuccin.setup({
  compile_path = vim.fn.stdpath "cache" .. "/catppuccin"
})

vim.cmd [[colorscheme catppuccin]]
