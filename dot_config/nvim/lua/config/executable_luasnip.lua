local present, luasnip = pcall(require, "luasnip")

if not present then
  return
end

luasnip.config.set_config {
  history = true,
}

require("luasnip/loaders/from_vscode").lazy_load()
