-- ~/.config/nvim/init.lua
vim.g.mapleader = " "  -- space is leader
vim.o.timeoutlen = 300    -- faster leader key detection
vim.wo.relativenumber = true   -- relative line numbers
vim.wo.number = true           -- show current line as absolute
-- Add Homebrew to PATH (needed for tree-sitter CLI, must be before lazy loads plugins)
vim.fn.setenv("PATH", "/opt/homebrew/bin:" .. (vim.fn.getenv("PATH") or ""))
require("config.keymaps")  -- physical keyboard layout remap
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
