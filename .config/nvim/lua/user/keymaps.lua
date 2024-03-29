local opts = { noremap = true, silent = true }

-- map s p to black hole register
vim.api.nvim_set_keymap("n", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

-- navigate buffers
vim.api.nvim_set_keymap("n", "<A-p>", ":bp<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-n>", ":bn<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-x>", ":BufDel<CR>", opts)

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

vim.api.nvim_set_keymap("n", "<A-b>", ":NvimTreeToggle<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-f>", ":Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-g>", ":Telescope live_grep<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-s>", ":SymbolsOutline<CR>", opts)

vim.api.nvim_set_keymap("v", "<C-s>", ":ToggleTermSendVisualSelectionNoTrim<CR>", opts)

-- lsp fomratting
vim.cmd [[ command! -range Format if <range> | exec 'lua vim.lsp.buf.format({async = true, range={["start"]={<line1>,0},["end"]={<line2>,0}}})' | else | exec 'lua vim.lsp.buf.format({ async = true})' | endif ]]

-- swith vim/tmux panes
function TmuxMove(direction, tmuxParam)
  local windowid = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. direction)
  if windowid == vim.api.nvim_get_current_win() then
    os.execute("tmux select-pane -" .. string.upper(tmuxParam))
  end
end
vim.api.nvim_set_keymap("n", "<C-w>h", ":lua TmuxMove('h','L')<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-w>j", ":lua TmuxMove('j','D')<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-w>k", ":lua TmuxMove('k','U')<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-w>l", ":lua TmuxMove('l','R')<CR>", opts)

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Next()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-k>", 'copilot#Previous()', { silent = true, expr = true })

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
