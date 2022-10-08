-- nvim: plugin-settings.lua

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local o = vim.opt

-- Dracula theme
if fn.has('termguicolors') == 1 then
    o.termguicolors = true
end
g.dracula_colorterm = 0
cmd('colorscheme dracula')
require('lualine').setup{
    options = {
        theme = 'dracula'
    }
}

-- Telescope
require('telescope').setup{
    pickers = {
        builtin = {
            theme = "ivy",
        },
        find_files = {
            theme = "ivy",
        },
        live_grep = {
            theme = "ivy",
        },
        help_tags = {
            theme = "ivy",
        },
    }
}

-- COQ
g.coq_settings = { 
    auto_start = "shut-up",
    display = { 
        pum = { 
            source_context = { "[", "]" } 
        }
    }
}
local coq = require('coq')

