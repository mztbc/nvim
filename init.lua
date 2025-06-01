vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('plugins.lazy')

require('lazy').setup({
    require('plugins/telescope'),
    require('plugins/mason'),
    require('plugins/lspconfig'),
    require('plugins/conform'),
    require('plugins/treesitter'),
    require('plugins/mini'),
    require('plugins/autopairs'),
    require('plugins/gitsigns'),
    require('plugins/colors')
})

MiniMisc.setup_termbg_sync()
require('config.options')
require('config.keymaps')
