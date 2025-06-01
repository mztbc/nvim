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
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    -- This handles overriding only values explicitly passed
                    -- by the server configuration above. Useful when disabling
                    -- certain features of an LSP (for example, turning off formatting for ts_ls)
                    server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                    require('lspconfig')[server_name].setup(server)
                end,
            },
        },
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = { 'stylua' },
        },
    },
}
