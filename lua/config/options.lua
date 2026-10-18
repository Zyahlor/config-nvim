local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.wrap = false

-- Indentation
opt.autoindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- Clipboard
opt.clipboard = "unnamedplus"

-- Search / editing
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.undofile = true

-- Don't show mode twice because lualine handles it.
opt.showmode = false
