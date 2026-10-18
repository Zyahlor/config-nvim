local map = vim.keymap.set

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Xóa highlight tìm kiếm" })

-- Lưu file & thoát nhanh
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Lưu file nhanh" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Đóng cửa sổ" })

-- Xem danh sách lỗi toàn project
map("n", "<leader>xx", "<cmd>FzfLua diagnostics_workspace<CR>", { desc = "Xem danh sách lỗi dự án" })

-- Di chuyển dòng được bôi đen lên / xuống (giống Alt+Up/Down trong VS Code)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Chuyển khối chọn xuống" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Chuyển khối chọn lên" })

-- Thụt lề giữ nguyên vùng chọn trong Visual mode
map("v", "<", "<gv", { desc = "Thụt lề sang trái" })
map("v", ">", ">gv", { desc = "Thụt lề sang phải" })

-- Move between splits
map("n", "<C-h>", "<C-w>h", { desc = "Sang khung trái" })
map("n", "<C-j>", "<C-w>j", { desc = "Sang khung dưới" })
map("n", "<C-k>", "<C-w>k", { desc = "Sang khung trên" })
map("n", "<C-l>", "<C-w>l", { desc = "Sang khung phải" })

-- Better split navigation when using terminal
map("t", "<C-h>", [[<C-\><C-N><C-w>h]], { desc = "Sang khung trái" })
map("t", "<C-j>", [[<C-\><C-N><C-w>j]], { desc = "Sang khung dưới" })
map("t", "<C-k>", [[<C-\><C-N><C-w>k]], { desc = "Sang khung trên" })
map("t", "<C-l>", [[<C-\><C-N><C-w>l]], { desc = "Sang khung phải" })
