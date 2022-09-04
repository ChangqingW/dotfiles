local opts = { noremap = true, silent = true }

-- map s p to black hole register
vim.api.nvim_set_keymap("n", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

if vim.g.neovide or next(vim.api.nvim_list_uis()) ~= nil then
  --vim.api.nvim_set_keymap("v", "y", ':OSCYank<CR>', opts)
  vim.api.nvim_set_keymap("", "<D-v>", '+p<CR>', opts)
  vim.api.nvim_set_keymap("v", "<D-v>", '+p<CR>', opts)
  vim.api.nvim_set_keymap('!', '<D-v>', '<C-r>+', { noremap = true, silent = false })
  vim.api.nvim_set_keymap('t', '<D-v>', '<C-r>+', opts)
  vim.api.nvim_set_keymap("n", '<D-=>', ":set guifont=Iosevka\\ Nerd\\ Font:h", { noremap = true, silent = false })
  vim.api.nvim_set_keymap("n", "<D-->", ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>", opts)
  --https://github.com/neovide/neovide/issues/1046
  vim.api.nvim_set_keymap("n", "~", ":bp<CR>", opts)
  vim.api.nvim_set_keymap("n", "ñ", ":bp<CR>", opts)
  vim.api.nvim_set_keymap("n", "µ", ":bn<CR>", opts)
  vim.api.nvim_set_keymap("n", "∫", ":bd<CR>", opts)
end

-- navigate buffers
vim.api.nvim_set_keymap("n", "<A-n>", ":bp<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-m>", ":bn<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-b>", ":bd<CR>", opts)

-- Emacs keymaps
vim.api.nvim_set_keymap("i", "<C-e>", "<END>", opts)
vim.api.nvim_set_keymap("i", "<C-a>", "<HOME>", opts)
vim.api.nvim_set_keymap("n", "<C-e>", "<END>", opts)
vim.api.nvim_set_keymap("n", "<C-a>", "<HOME>", opts)
vim.api.nvim_set_keymap("v", "<C-e>", "<END>", opts)
vim.api.nvim_set_keymap("v", "<C-a>", "<HOME>", opts)

-- Move text up and down
vim.api.nvim_set_keymap("v", "<A-j>", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "<A-k>", ":m .-2<CR>==", opts)
vim.api.nvim_set_keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

vim.api.nvim_set_keymap("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-s>", ":SymbolsOutline<CR>", opts)

vim.api.nvim_set_keymap("v", "<C-s>", ":ToggleTermSendVisualSelectionNoTrim<CR>", opts)

vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
--local customNvimRMappings =function ()
--  vim.api.nvim_buf_set_keymap(0, "i", "<Leader>sr", "<Plug>RStart", opts)
--  vim.api.nvim_buf_set_keymap(0, "v", "<Leader>sr", "<Plug>RStart", opts)
--  vim.api.nvim_buf_set_keymap(0, "n", "<Leader>sr", "<Plug>RStart", opts)
--end
--vim.api.nvim_create_autocmd('filetype', {
--  pattern = 'R',
--  callback = function()
--    customNvimRMappings()
--  end
--})
