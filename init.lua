-- Neovim config
-- Shared between Arch Linux and Windows.

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
    }, true, {})
  end
end
vim.opt.rtp:prepend(lazypath)
if vim.fn.has("win32") == 1 then
  local user_profile = vim.fn.expand("$USERPROFILE")
  local winget_links = user_profile .. "\\AppData\\Local\\Microsoft\\WinGet\\Links"
  if vim.fn.isdirectory(winget_links) == 1 and not string.find(vim.env.PATH, winget_links, 1, true) then
    vim.env.PATH = winget_links .. ";" .. vim.env.PATH
  end
end

vim.opt.fileformats = "unix,dos"   -- ưu tiên unix khi đọc file
vim.opt.fileformat = "unix"        -- file mới mặc định LF
vim.opt.rtp:prepend(lazypath)
vim.opt.clipboard = "unnamedplus"
require("lazy").setup("plugins", {
  change_detection = {
    notify = false,
  },
})
