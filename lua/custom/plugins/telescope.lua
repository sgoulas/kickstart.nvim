-- Telescope fuzzy finder
return {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
        { 'nvim-telescope/telescope-ui-select.nvim' },
        { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
    },
    config = function()
        local actions = require 'telescope.actions'
        require('telescope').setup {
            defaults = {
                layout_config = {
                    width = 0.9,
                    height = 0.8,
                    horizontal = {
                        preview_width = 0.5,
                    },
                    vertical = {
                        preview_width = 0.5,
                    },
                },
                mappings = {
                    i = {
                        ['<C-h>'] = actions.preview_scrolling_left,
                        ['<C-l>'] = actions.preview_scrolling_right,
                        ['<C-k>'] = actions.preview_scrolling_up,
                        ['<C-j>'] = actions.preview_scrolling_down,
                        -- Option + h/l (in mac: bind option to esc+ in terminal emulator settings)
                        ['<M-h>'] = actions.results_scrolling_left,
                        ['<M-l>'] = actions.results_scrolling_right,
                    },
                    n = {
                        ['<C-h>'] = actions.preview_scrolling_left,
                        ['<C-l>'] = actions.preview_scrolling_right,
                        ['<C-k>'] = actions.preview_scrolling_up,
                        ['<C-j>'] = actions.preview_scrolling_down,
                        ['<M-h>'] = actions.results_scrolling_left,
                        ['<M-l>'] = actions.results_scrolling_right,
                    },
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_dropdown(),
                },
            },
        }

        pcall(require('telescope').load_extension, 'fzf')
        pcall(require('telescope').load_extension, 'ui-select')

        local builtin = require 'telescope.builtin'
        vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
        vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sG', builtin.live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sg', function()
            builtin.live_grep {
                additional_args = { '--fixed-strings' },
            }
        end, { desc = '[S]earch by [G]rep (literal)' })
        vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
        vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
        vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
        vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
        vim.keymap.set('n', '<leader>ui', function()
            require('telescope.builtin').colorscheme { enable_preview = true }
        end, { desc = 'preview installed themes' })
        vim.keymap.set('n', '<leader>gs', '<cmd>Telescope git_status<cr>', { desc = 'Git status (Telescope)' })
        vim.keymap.set('n', '<leader>gc', '<cmd>Telescope git_bcommits<cr>', { desc = 'Git commits for current file' })

        -- Fuzzily search in current buffer
        vim.keymap.set('n', '<leader>/', function()
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        -- Live grep in open files
        vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        -- Search Neovim configuration files
        vim.keymap.set('n', '<leader>sn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
        end, { desc = '[S]earch [N]eovim files' })
    end,
}
