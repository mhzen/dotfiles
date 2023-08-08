local present, bufferline = pcall(require, "bufferline")

if not present then
  return
end

bufferline.setup {
  options = {
    offsets = {
      filetype = "neo-tree",
      text = "",
      padding = 1,
    },
    indicator = {
      style = 'none'
    }
  }
}
