require "user.options"
require "user.keymaps"

local status_ok, _ = pcall(require, "impatient")
if not status_ok then
  vim.notify("impatient failed to load!")
  return
end

-- if (not vim.g.vscode) then -- vscode neovim
require "user.packer"
require "user.cmp"
require "user.colorscheme"
require "user.lsp"
