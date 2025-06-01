return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-ui-select.nvim' },
        {
            -- Builds fzf-native if make is avaliable.
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',

            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
    },
    cmd = 'Telescope',
    config = function()
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        require('telescope').setup({
            defaults = {
                layout_strategy = 'horizontal',
                file_ignore_patterns = { 'node_modules', '^package%-lock%.json$' },
                mappings = {
                    i = {
                        ['<C-j>'] = 'move_selection_next',
                        ['<C-k>'] = 'move_selection_previous',
                        ['<C-q>'] = 'close',
                    },
                    n = {
                        ['q'] = 'close',
                    },
                },
            },
            pickers = {
                find_files = {
                    theme = "ivy"
                }
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        })
    end,
}
