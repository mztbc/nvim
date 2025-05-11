return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-ui-select.nvim' },
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
                return vim.fn.executable('make') == 1
            end,
        },
    },
    cmd = 'Telescope', -- Lazy-load on :Telescope command
    config = function()
        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')
        require('telescope').setup({
            defaults = {
                -- Minimal layout for speed
                layout_strategy = 'horizontal',
                layout_config = {
                    width = 0.8,
                    height = 0.8,
                    preview_width = 0.5,
                },
                -- Disable costly folders
                file_ignore_patterns = { 'node_modules' },
                -- Basic mappings for efficiency
                mappings = {
                    i = {
                        ['<C-j>'] = 'move_selection_next',
                        ['<C-k>'] = 'move_selection_previous',
                        ['<C-c>'] = 'close',
                    },
                    n = {
                        ['q'] = 'close',
                    },
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        })
    end,
}
