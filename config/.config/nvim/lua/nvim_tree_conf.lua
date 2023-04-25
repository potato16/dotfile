local lib = require("nvim-tree.lib")
local view = require("nvim-tree.view")

local config = {
    view = {
        adaptive_size = true,
        side = "right",
    },
    actions = {
        open_file = {
            quit_on_open = false
        }
    }
}

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<cr>" ,{silent = true, noremap = true})
require('nvim-tree').setup(config)
