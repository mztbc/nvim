local M = {}

local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

function M.git_bcommits_with_preview()
    local opts = {
        git_log_args = {
            '--pretty=format:%h %s (%cr) <%an>',
            '--graph',
        },
    }

    opts.previewer = {
        previewers.git_commit_diff_to_parent.new(opts),
        previewers.git_commit_message.new(opts),
    }

    builtin.git_bcommits(opts)
end

return M
