-- Git diff and conflict resolution with side-by-side view

-- Helper function to open the PR for a given commit SHA
local function open_pr_for_commit(sha)
    if not sha or sha == '' then
        vim.notify('No commit SHA found', vim.log.levels.WARN)
        return
    end

    -- Use gh CLI to find the PR that introduced this commit
    local cmd = string.format(
        "gh pr list --search '%s' --state merged --json url --jq '.[0].url'",
        sha
    )

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        on_stdout = function(_, data)
            local url = data[1]
            if url and url ~= '' then
                vim.ui.open(url)
                vim.notify('Opening PR: ' .. url, vim.log.levels.INFO)
            else
                -- Try searching in all states (including open PRs)
                local fallback_cmd = string.format(
                    "gh pr list --search '%s' --state all --json url --jq '.[0].url'",
                    sha
                )
                vim.fn.jobstart(fallback_cmd, {
                    stdout_buffered = true,
                    on_stdout = function(_, fallback_data)
                        local fallback_url = fallback_data[1]
                        if fallback_url and fallback_url ~= '' then
                            vim.ui.open(fallback_url)
                            vim.notify('Opening PR: ' .. fallback_url, vim.log.levels.INFO)
                        else
                            vim.notify('No PR found for commit: ' .. sha, vim.log.levels.WARN)
                        end
                    end,
                    on_stderr = function(_, err_data)
                        if err_data and err_data[1] and err_data[1] ~= '' then
                            vim.notify('Error: ' .. table.concat(err_data, '\n'), vim.log.levels.ERROR)
                        end
                    end,
                })
            end
        end,
        on_stderr = function(_, data)
            if data and data[1] and data[1] ~= '' then
                vim.notify('Error: ' .. table.concat(data, '\n'), vim.log.levels.ERROR)
            end
        end,
    })
end

return {
    'sindrets/diffview.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = {
        'DiffviewOpen',
        'DiffviewClose',
        'DiffviewToggleFiles',
        'DiffviewFocusFiles',
        'DiffviewFileHistory',
    },
    keys = {
        { '<leader>gd', '<cmd>DiffviewOpen<cr>',          desc = 'Open Diffview' },
        { '<leader>gD', '<cmd>DiffviewClose<cr>',         desc = 'Close Diffview' },
        { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git file history (current file)' },
        { '<leader>gH', '<cmd>DiffviewFileHistory<cr>',   desc = 'Git file history (all)' },
    },
    opts = {
        enhanced_diff_hl = true,
        use_icons = true,
        view = {
            default = {
                layout = 'diff2_horizontal',
            },
            merge_tool = {
                -- Layout for resolving merge conflicts
                -- diff3_mixed: LOCAL | BASE | REMOTE with merged result below
                layout = 'diff3_mixed',
                disable_diagnostics = true,
            },
            file_history = {
                layout = 'diff2_horizontal',
            },
        },
        file_panel = {
            listing_style = 'tree',
            win_config = {
                position = 'left',
                width = 35,
            },
        },
        keymaps = {
            view = {
                { 'n', '<tab>', '<cmd>DiffviewToggleFiles<cr>', { desc = 'Toggle file panel' } },
                { 'n', 'q',     '<cmd>DiffviewClose<cr>',       { desc = 'Close Diffview' } },
            },
            file_panel = {
                { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
            },
            file_history_panel = {
                { 'n', 'q', '<cmd>DiffviewClose<cr>', { desc = 'Close Diffview' } },
                {
                    'n',
                    '<leader>gp',
                    function()
                        local actions = require('diffview.actions')
                        -- Get the current file history view
                        local view = require('diffview.lib').get_current_view()
                        if not view then
                            vim.notify('No diffview found', vim.log.levels.WARN)
                            return
                        end

                        -- Get the file history panel
                        local panel = view.panel
                        if not panel then
                            vim.notify('No panel found', vim.log.levels.WARN)
                            return
                        end

                        -- Get the current entry (selected commit)
                        local entry = panel:get_item_at_cursor()
                        if not entry then
                            vim.notify('No entry selected', vim.log.levels.WARN)
                            return
                        end

                        -- Extract the commit SHA
                        local sha = entry.commit and entry.commit.hash
                        if not sha then
                            vim.notify('Could not get commit SHA', vim.log.levels.WARN)
                            return
                        end

                        open_pr_for_commit(sha)
                    end,
                    { desc = 'Open PR for this commit' },
                },
            },
        },
    },
}
