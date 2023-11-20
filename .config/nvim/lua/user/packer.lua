local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  require('packer').packadd = 'packer.nvim'
end

-- Autocommand that reloads neovim whenever you save the packer.lua file
local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
 vim.api.nvim_create_autocmd("BufWritePost", {
   command = "source <afile> | PackerSync",
   pattern = "packer.lua",
   group = group,
 })

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  vim.notify("Failed to load packer")
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- UI
  -- colorscheme
  -- use({"catppuccin/nvim", as = "catppuccin"})
  use 'kyazdani42/nvim-web-devicons'
  use 'navarasu/onedark.nvim'
  use {
  'nvim-lualine/lualine.nvim',
  } -- status line

  -- buffer tabs
  use {
    "akinsho/bufferline.nvim",
    config = function () require("user.plugin_confs.bufferline") end
  }

  use {
    "akinsho/toggleterm.nvim",
    config = function () require("user.plugin_confs.toggleterm") end
  }

  use {'ojroques/nvim-bufdel',
    config = function () require('bufdel').setup{ quit = false } end
  }

  -- cmp plugins: require snippet plugin (use LuaSnip)
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  -- use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use {"hrsh7th/cmp-omni"}

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use {
    "neovim/nvim-lspconfig", -- enable LSP
    config = function () vim.opt.signcolumn = "yes" end
    }
  use { "williamboman/mason.nvim" }
  use { "williamboman/mason-lspconfig.nvim" }

  use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use({
    "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
    requires = { "nvim-lua/plenary.nvim" },
  })

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function () require("user.plugin_confs.treesitter") end
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use {
    "windwp/nvim-autopairs",
    config = function () require('user.plugin_confs.autopairs') end
  }
  use "simrat39/symbols-outline.nvim"

  -- Markdown Preview
  if vim.fn.executable('npm') == 1 then
    use({
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install",
      setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
      ft = { "markdown" },
    })
  end

  -- R
  use {
    "jalvesaq/Nvim-R",
    branch = 'stable',
    ft = {'r', 'rmd'},
    config = function () require("user.plugin_confs.nvim-r") end
  }

  -- Telescope
  use "nvim-telescope/telescope.nvim"

  -- clipbard
  use {'ojroques/nvim-osc52'}

  -- Git
  use {
    "lewis6991/gitsigns.nvim",
    config = function () require('gitsigns').setup{yadm = {enable = true}} end
  }


  use "junegunn/vim-easy-align" -- :EasyAlign */\t/
  use {
    "kyazdani42/nvim-tree.lua",
    config = function () require("user.plugin_confs.nvim-tree") end
  }

  use("nathom/filetype.nvim")
  use 'lewis6991/impatient.nvim'
  use 'github/copilot.vim'

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
