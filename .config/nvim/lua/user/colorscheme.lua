local status_ok, onedark = pcall(require, "onedark")
if status_ok then
  onedark.setup({
    term_colors = true,
    transparent = true, -- onedark:282c34 catppuccin:1e1e2e
    style = 'cool',
    code_style = { comments = 'italic,bold' },
    highlights = { Visual = {bg = "#000001"}}
  })
  onedark.load()
  require('lualine').setup { -- assumed lualine exists
    options = {theme = "onedark"}
  }
else
  vim.notify("colorscheme not found!")
end

-- catppuccin:
-- local status_ok, catppuccin = pcall(require, "catppuccin")
-- if status_ok then
--   catppuccin.setup({
--     term_colors = true,
--     transparent_background = true -- onedark:282c34 catppuccin:1e1e2e
--   })
--   local cp_colors = require'catppuccin.api.colors'.get_colors()
--   -- colors: https://github.com/catppuccin/catppuccin
--   catppuccin.remap({
--     Comment = { fg = cp_colors.gray1, style = "italic" }, -- #988BA2
--     LineNr = { fg = cp_colors.gray2 } -- #C3BAC6
--   })
--   require('lualine').setup { -- assumed lualine exists
--     options = {theme = "onedark"}
--   }
--   vim.cmd[[colorscheme catppuccin]]
-- else
--   vim.notify("colorscheme not found!")
-- end

