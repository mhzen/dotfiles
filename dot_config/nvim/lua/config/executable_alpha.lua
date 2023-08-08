local present, alpha = pcall(require, "alpha")
local dashboard = require("alpha.themes.dashboard")

if not present then
  return
end
-- Set header
dashboard.section.header.val = {
      "           ▄ ▄                   ",
      "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
      "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
      "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
      "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
      "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
      "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
      "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
      "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
}

-- Set menu
dashboard.section.buttons.val = {
    dashboard.button( "e", "  new", ":enew <BAR> startinsert <CR>"),
    dashboard.button( "f", "  find", ":Telescope find_files <CR>"),
    dashboard.button( "r", "  recent", ":Telescope oldfiles<CR>"),
    dashboard.button( "u", "  update", ":Lazy sync<CR>"),
    dashboard.button( "q", "  quit", ":qa<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- hide tabline and statusline on startup screen
vim.cmd(string.format(
  [[
  augroup alpha_tabline
    au!
    au FileType alpha set showtabline=0 laststatus=0 noruler | au BufUnload <buffer> set showtabline=2 ruler laststatus=%d
  augroup END
  ]],
  vim.fn.has "nvim-0.7" == 1 and 3 or 2
))
