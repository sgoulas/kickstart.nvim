-- Bluloco colorscheme (light)
return {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
        require('bluloco').setup {
            style = 'light',
            transparent = false,
            italics = false,
            terminal = vim.fn.has('gui_running') == 1,
            guicursor = true,
        }
        vim.cmd.colorscheme 'bluloco'
    end,
}
