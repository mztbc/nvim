-- Clear highlights on search when pressing <Esc> in normal mode
-- See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Faster netrw mapping
-- See `:help netrw`
vim.keymap.set('n', '<leader>e', ':Ex<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- See `:help terminal`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>e', ':Ex<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "No Arrows!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "No Arrows!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "No Arrows!"<CR>')

-- Keybinds to make split navigation easier.
-- Use CTRL+<hjkl> to switch between windows
-- See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Telescope keymaps
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>sf', '<cmd>Telescope find_files<CR>', { desc = 'Find files' })
vim.keymap.set('n', '<leader>sg', '<cmd>Telescope live_grep<CR>', { desc = 'Search text in files' })
vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers<CR>', { desc = 'List open buffers' })
vim.keymap.set('n', '<leader>gf', '<cmd>Telescope git_files<CR>', { desc = 'Find Git-tracked files' })
vim.keymap.set('n', '<leader>sh', '<cmd>Telescope help_tags<CR>', { desc = 'Search help tags' })
vim.keymap.set('n', '<leader>sr', '<cmd>Telescope oldfiles<CR>', { desc = 'List recent files' })
vim.keymap.set(
    'n',
    '<leader>sz',
    '<cmd>Telescope current_buffer_fuzzy_find<CR>',
    { desc = 'Fuzzy find in current buffer' }
)

-- Conform
vim.keymap.set({ 'n', 'x' }, '<leader>f', function()
    require('conform').format({ async = true, lsp_fallback = true })
end, { desc = '[C]ode [F]ormat' })

-- LSP keymaps (set on LspAttach)
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(event)
        local lsp_map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Core navigation (single-key, no prefix)
        lsp_map('gd', require('telescope.builtin').lsp_definitions, 'Go to Definition')
        lsp_map('gD', vim.lsp.buf.declaration, 'Go to Declaration')
        lsp_map('gi', require('telescope.builtin').lsp_implementations, 'Go to Implementation')
        lsp_map('gr', require('telescope.builtin').lsp_references, 'Get References')
        lsp_map('K', vim.lsp.buf.hover, 'Show hover documentation')

        -- Leader-based LSP actions (under <leader>l for less frequent actions)
        lsp_map('<leader>lr', vim.lsp.buf.rename, 'Rename across multiple files', 'n')
        lsp_map('<leader>ca', vim.lsp.buf.code_action, 'Code actions', { 'n', 'x' })
        lsp_map('<leader>lt', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        lsp_map('<leader>le', function()
            require('telescope.builtin').diagnostics({
                severity = vim.diagnostic.severity.ERROR, -- Filter by ERROR severity
                bufnr = 0, -- Current buffer
                line = vim.api.nvim_win_get_cursor(0)[1], -- Current line
                prompt_title = 'Line Error Diagnostics',
                layout_config = {
                    width = 0.8, -- Max width (80% of screen)
                    height = 0.4,
                },
            })
        end, 'Show error diagnostics in Telescope', 'n')
    end,
})

-- Gitsigns
vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('GitSignsConfig', { clear = true }),
    callback = function(event)
        local gs_map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'GitSigns: ' .. desc })
        end

        local gitsigns = require('gitsigns')

        -- Navigation
        gs_map(']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end, 'Jump to next git change')

        gs_map('[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end, 'Jump to previous git change')

        -- Actions visual mode
        gs_map('hs', function()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'git stage hunk', 'v')

        gs_map('hr', function()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end, 'git reset hunk', 'v')

        gs_map('<leader>gb', gitsigns.blame_line, 'git blame line')
        gs_map('<leader>gd', gitsigns.diffthis, 'git diff against index')
        gs_map('<leader>gD', function()
            gitsigns.diffthis('@')
        end, 'git diff against last commit')

        -- Toggles
        gs_map('tb', gitsigns.toggle_current_line_blame, 'toggle git show blame line')
        gs_map('tD', gitsigns.toggle_deleted, 'Toggle git show deleted')
    end,
})
