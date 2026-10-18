# Neovim Configuration (Cross-Platform)

Cấu hình Neovim dùng chung giữa **Windows** và **Linux** (Arch Linux, Fedora, Ubuntu/Debian).

## 🚀 Hướng dẫn cài đặt tự động

### 🐧 Trên Linux (`Arch/Manjaro (pamac/pacman)`, `Fedora (dnf)`, `Ubuntu/Debian (apt)`)

Chạy lệnh:

```bash
chmod +x install.sh
./install.sh
```

**Script `install.sh` sẽ tự động:**
- Tự nhận diện trình quản lý gói: `pamac`, `pacman`, `dnf`, hoặc `apt`.
- Cài đặt Neovim mới nhất, Git, Build tools (gcc/g++/make/base-devel), Ripgrep, fd, Node.js, Python, Clang.
- Tự tải và cài đặt font **JetBrainsMono Nerd Font** vào hệ thống (để hiện đầy đủ icon ngôn ngữ, file, thư mục).
- Tự liên kết (symlink) thư mục cấu hình vào `~/.config/nvim`.
- Đồng bộ toàn bộ plugin qua Lazy.nvim (`:Lazy sync`).

---

### 🪟 Trên Windows (PowerShell)

Mở PowerShell và chạy:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned -Force
.\install.ps1
```

**Script `install.ps1` sẽ tự động:**
- Cài đặt các công cụ phụ thuộc qua `winget` (Neovim, Git, Ripgrep, fd, Node.js, LLVM/Clang).
- Tự tải và cài đặt font **JetBrainsMono Nerd Font** vào Windows Fonts và Registry nếu chưa có.
- Tự cấu hình font `JetBrainsMono Nerd Font` vào file cài đặt của **Windows Terminal**.
- Sao chép cấu hình vào `$env:LOCALAPPDATA\nvim`.
- Đồng bộ toàn bộ plugin qua Lazy.nvim (`:Lazy sync`).

---

## ⌨️ Bảng Phím Tắt Nhanh (Keybindings)

| Phím tắt | Tác dụng |
| :--- | :--- |
| `<F5>` | **Biên dịch & Chạy code 1 chạm** (hiện thanh ngang ở dưới đáy) |
| `<Ctrl + \>` | **Bật / Tắt Terminal ở dưới đáy** (gán cứng, bấm là mở/đóng) |
| `q` hoặc `<Esc>` (trong Terminal) | **Đóng ngay cửa sổ Terminal** khi ở Normal mode |
| `<leader>e` | Bật / tắt cây thư mục Neo-tree |
| `<leader>ff` | **Tìm kiếm file** (FZF siêu nhanh) |
| `<leader>fg` | **Tìm chữ trong toàn bộ project** (Live Grep) |
| `<Tab>` / `<S-Tab>` | Chuyển qua lại giữa các tab file (Bufferline) |
| `<leader>bd` | Đóng tab file hiện tại |
| `<leader>xx` | **Xem danh sách toàn bộ lỗi dự án** (FZF siêu nhanh) |
| `<leader>w` | Lưu file nhanh |
| `<leader>q` | Đóng cửa sổ |
| `J` / `K` (Visual mode) | Kéo khối code bôi đen di chuyển lên / xuống |

👉 **Xem bảng tra cứu toàn bộ phím tắt chi tiết tại:** [KEYMAPS.md](KEYMAPS.md)

