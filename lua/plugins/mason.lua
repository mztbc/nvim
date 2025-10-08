return {
    {
        'williamboman/mason.nvim',
        opts = {},
    },
    {
        'williamboman/mason-lspconfig.nvim',
        opts = {
            ensure_installed = { 'lua_ls' },
            automatic_installation = false,
        },
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = { 'stylua' },
        },
    },
}
