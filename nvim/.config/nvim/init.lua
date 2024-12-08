vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.have_nerd_font = true
vim.opt.termguicolors = true

require("config.lazy")
require("config.keymaps")
require("config.options")
vim.cmd([[colorscheme tokyonight-night]])
