-- Neoscroll
require('neoscroll').setup()

-- lualine.nvim
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'codedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_c = {'filename'},
    lualine_x = {'location'}
  },
  tabline = {
      lualine_a = {'buffers'},
      lualine_z = {'tabs'}
  },
  extensions = {'nvim-tree'}
}

-- nvim-tree.lua
require'nvim-tree'.setup {
  hijack_cursor = true,
  view = {
    mappings = {
      list = {
        { key = "<C-Right>", action = "cd" },
        { key = "<C-Left>", action = "dir_up" },
      },
    },
  },
}

-- bufferline.nvim
require("bufferline").setup {
  options = {
    offsets = {{ filetype = "NvimTree", text = "File Explorer", padding = 0 }}
  }
}

-- nvim-autopairs
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
