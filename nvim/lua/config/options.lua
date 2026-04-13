-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.relativenumber = true
opt.number = true

opt.wrap = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true

opt.clipboard = "unnamedplus"

opt.swapfile = false

opt.splitright = true
opt.splitbelow = true

opt.backspace = "indent,eol,start"

vim.diagnostic.config({
  underline = true,
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})
