-- Harpoon2 - Quick file navigation
return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        local harpoon = require('harpoon')

        harpoon:setup({})

        -- Telescope integration
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                if item and item.value and item.value ~= '' then
                    table.insert(file_paths, item.value)
                end
            end

            require('telescope.pickers')
                .new({}, {
                    prompt_title = 'Harpoon',
                    finder = require('telescope.finders').new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        -- Keymaps
        vim.keymap.set('n', '<leader>fh', function()
            harpoon:list():add()
        end, { desc = 'Harpoon: [F]ire [H]arpoon (add)' })

        vim.keymap.set('n', '<leader>H', function()
            toggle_telescope(harpoon:list())
        end, { desc = '[H]arpoon menu (Telescope)' })

        vim.keymap.set('n', '<leader>rh', function()
            harpoon:list():remove()
        end, { desc = 'Harpoon: [R]emove [H]arpoon' })

        -- Quick select harpooned files
        vim.keymap.set('n', '<leader>1', function()
            harpoon:list():select(1)
        end, { desc = 'Harpoon file 1' })

        vim.keymap.set('n', '<leader>2', function()
            harpoon:list():select(2)
        end, { desc = 'Harpoon file 2' })

        vim.keymap.set('n', '<leader>3', function()
            harpoon:list():select(3)
        end, { desc = 'Harpoon file 3' })

        vim.keymap.set('n', '<leader>4', function()
            harpoon:list():select(4)
        end, { desc = 'Harpoon file 4' })
    end,
}
