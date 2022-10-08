-- nvim: base.lua

local cmd = vim.cmd
local g = vim.g
local o = vim.opt
local wo = vim.wo

-- leader key
g.mapleader = ','
g.maplocalleader = ','

-- general
cmd('syntax enable')                -- enable syntax highlighting
o.listchars:append({ space = '·' })
o.list = true
o.clipboard:append('unnamedplus')   -- use system clipboard
o.mouse = 'v'                       -- enable middle click paste
o.mouse = 'a'                       -- enable mouse click
o.tabstop = 4                       -- spaces used by tab
o.shiftwidth = 4                    -- width for auto indents
o.expandtab = true                  -- expand tab to spaces
o.smarttab = true
o.smartindent = true
o.number = true                     -- add line numbers in the left edge
o.numberwidth = 3                   -- spaces for line numbers
o.cursorline = true                 -- highlight current line
o.showmode = false                  -- hide --INSERT-- from status line
o.showcmd = true                    -- show leader key during timeout

-- window
wo.fillchars = 'eob: '              -- remove tildes from the end of buffer
 
