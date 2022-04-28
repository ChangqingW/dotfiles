local opts = { noremap = true, silent = true }

-- map s p to black hole register
vim.api.nvim_set_keymap("n", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "s", '"_s', opts)
vim.api.nvim_set_keymap("v", "p", '"_dP', opts)

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

vim.api.nvim_set_keymap("v", "<C-s>", ":ToggleTermSendVisualSelectionNoTrim<CR>", opts)

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
