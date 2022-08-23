local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/vim-vsnip"

  use { 
    'nvim-telescope/telescope.nvim', 
    requires = { { 'nvim-lua/plenary.nvim' }, {"kdheepak/lazygit.nvim" } },
    config = function()
      require('telescope').load_extension('lazygit')
    end,
  }

  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  use {
  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = { 
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }

  }

  use { 
    "nvim-treeshitter/nvim-treeshitter", 
    run = function() require('nvim-treeshitter.install').update({ with_sync = true}) end, 
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- mason
require('mason').setup()

-- mason-lspconfig
require('mason-lspconfig').setup()
require('mason-lspconfig').setup_handlers({ function(server)
  local opt = {
    capabilities = require('cmp_nvim_lsp').update_capabilities(
      vim.lsp.protocol.make_client_capabilities()
    )
  }
  require('lspconfig')[server].setup(opt)
end })

-- hrsh7th/nvim-cmp
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  sources = {
    { name = "nvim_lsp" },
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ['<C-l>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
  }),
  experimental = {
    ghost_text = true,
  },
})

-- nvim-lualine/lualine.nvim
require('lualine').setup()

-- nvim-neo-tree/neo-tree.nvim
require('neo-tree').setup()

-- common
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 1
vim.opt.showcmd = true
vim.opt.laststatus = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.number = true
vim.opt.ambiwidth = "single"
vim.g.mapleader = " "

vim.keymap.set('n', '<Leader>w', ':<C-u>w<CR>')
vim.keymap.set('n', '<Leader>.', '<Cmd>:new $MYVIMRC<cr>', {noremap = true, silent = true})

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', 'jj', '<ESC>')

-- telescope.nvim
local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<Leader>ff', telescope_builtin.find_files, {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>fg', telescope_builtin.live_grep, {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>fb', telescope_builtin.buffers, {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>fm', telescope_builtin.keymaps, {noremap = true, silent = true})


-- lsp key map
vim.keymap.set('n', 'K',  '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

-- kdheepak/lazygit.nvim
vim.keymap.set('n', '<Leader>gg', '<Cmd>LazyGit<cr>', {noremap = true, silent = true})
