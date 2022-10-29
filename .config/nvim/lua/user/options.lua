-- CJK settings
vim.opt.fileencodings = { "utf-8", "ucs-bom", "gb18030", "gbk", "gb2312", "cp936" }
vim.opt.encoding = "utf-8"
vim.opt.spelllang = { "en", "cjk" }

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4

-- tab: 2 spaces
vim.opt.expandtab = true
vim.opt.tabstop = 2

vim.opt.compatible = false
vim.opt.fileformat = "unix"

vim.opt.shiftwidth = 2 -- Number of spaces for indentation
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
vim.opt.history = 50
vim.opt.mouse = "a"

-- clipboard
-- https://github.com/ojroques/vim-oscyank/issues/24
vim.opt.clipboard = "unnamedplus"


local copy
if vim.env.TMUX ~= nil then
  copy = function(lines, _)
    local xclip = io.popen("xclip -sel clip", "w")
    if xclip ~= nil then
      xclip:write(table.concat(lines, "\n"))
      xclip:close()
    end
  end
else
  copy = function(lines, _)
    vim.fn.OSCYankString(table.concat(lines, "\n"))
  end
end

local paste
paste = function()
  local xclip = io.popen("xclip -o -sel clip", "r")
  if xclip ~= nil then
    local result = xclip:read("a")
    xclip:close()
    return { vim.fn.split(result, '\n'), 'b' }
  end
end

if not vim.g.neovide and vim.env.SSH_CLIENT ~= nil then
  vim.g.clipboard = {
    name = "osc52",
    copy = {
      ["+"] = copy,
      ["*"] = copy
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste
    }
  }
end

vim.opt.backspace = { "indent", "eol", "start" }
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
vim.opt.wildignore = { ".DS_Store", ".localized", ".tags*", "tags", ".keep", ".gitkeep", "*.pyc", "*.class", "*.swp",
  "*.dump" }
vim.opt.diffopt = { "vertical", "filler", "foldcolumn:0", "followwrap" }
vim.opt.whichwrap = "b,s"
vim.opt.wrap = true
vim.opt.synmaxcol = 1000
vim.opt.showtabline = 2
vim.opt.regexpengine = 1
vim.opt.formatoptions:append "j"
vim.opt.langremap = false
--vim.opt.path = .,,
vim.opt.modeline = false
vim.opt.undodir = "~/.vim/tmp/undo"
vim.opt.scrollback = -1

-- GUI settings
vim.opt.guifont = "Iosevka Nerd Font:h20"
if vim.g.neovide then
  vim.g.neovide_fullscreen = false
  vim.g.neovide_transparency = 0.0
  vim.g.transparency = 0.95
  vim.g.neovide_background_color = '#282c34' .. string.format("%x", 255 * vim.g.transparency)
  vim.g.neovide_input_use_logo = true
  vim.g.neovide_input_macos_alt_is_meta = true
end
