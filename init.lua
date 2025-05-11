vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('plugins.lazy')

require('lazy').setup({
    require('plugins/telescope'),
    require('plugins/mason'),
    require('plugins/lspconfig'),
    require('plugins/conform'),
    require('plugins/treesitter'),
})

require('config.options')
require('config.keymaps')
