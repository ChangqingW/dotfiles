require "user.options"
require "user.keymaps"

local status_ok, _ = pcall(require, "impatient")
if not status_ok then
  vim.notify("impatient failed to load!")
end

if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
  require "user.packer"
  require "user.cmp"
  require "user.colorscheme"
  require "user.lsp"
end
