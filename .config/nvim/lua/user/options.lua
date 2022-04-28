-- CJK settings
vim.opt.fileencodings = {"utf-8","ucs-bom","gb18030","gbk","gb2312","cp936"}
vim.opt.encoding = "utf-8"
vim.opt.spelllang = {"en","cjk"}

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- tab: 2 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2

vim.opt.compatible = false
vim.opt.fileformat = "unix"

vim.opt.shiftwidth = 2  -- Number of spaces for indentation
vim.opt.autoindent = true
vim.opt.smarttab = true

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.showmatch = false

--vim.opt.nrformats -= octal

--vim.opt.noerrorbells true
--vim.opt.visualbell = true
--vim.opt.t_vb =
--vim.opt.belloff = "all"

-- misc
if vim.env.TERM == 'xterm-256color' then
  vim.opt.termguicolors = true
elseif vim.env.TERM then
  vim.notify("$TERM: " .. vim.env.TERM .. ", disabling termguicolors")
  -- vim.notify("TERM: " .. env_term .. ", termguicolors disabled")
elseif (not vim.g.vscode) then
  vim.notify("Failed to get $TERM, disabling termguicolors")
end

vim.opt.history = 50
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.backspace = {"indent","eol","start"}
vim.opt.shortmess:append "Ic"
vim.opt.laststatus = 2 -- no ststus line when only one window
vim.opt.swapfile = false -- big files
vim.opt.splitbelow = true -- new split opens below
vim.opt.splitright = true -- new split opens to right
vim.opt.timeout = false -- key-combo timeout
vim.opt.showcmd = true
vim.opt.autoread = true -- reload changed file
vim.opt.startofline = true -- gg, G etc. move to start of line

--vim.opt.tags = ./.tags;
vim.opt.wildmenu = true -- command-line completion ?
vim.opt.complete = ".,w,b"
vim.opt.grepprg = "ag"
vim.opt.fillchars:append "vert: "
vim.opt.foldenable = false
vim.opt.pumheight = 8
vim.opt.joinspaces = false
--vim.opt.sessionoptions- = options
--vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 3
vim.opt.wildignorecase = true
vim.opt.wildignore = {".DS_Store",".localized",".tags*","tags",".keep",".gitkeep","*.pyc","*.class","*.swp","*.dump"}
vim.opt.diffopt = {"vertical","filler","foldcolumn:0"}
vim.opt.whichwrap = "b,s"
vim.opt.synmaxcol = 1000
vim.opt.showtabline = 2
vim.opt.regexpengine = 1
vim.opt.formatoptions:append "j"
vim.opt.langremap = false
--vim.opt.path = .,,
vim.opt.modeline = false
vim.opt.undodir = "~/.vim/tmp/undo"
vim.opt.scrollback = -1
