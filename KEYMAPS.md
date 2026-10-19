# 📖 CẨM NANG PHÍM TẮT NEOVIM (CHEATSHEET)

> 💡 **Quy ước phím chính:**
> - `<leader>` = Phím **Space (Dấu cách)**.
> - `<C-...>` = Phím **Ctrl**.
> - `<S-...>` = Phím **Shift** (Ví dụ `<S-Tab>` là **Shift + Tab**).

---

## ⚡ 1. Thao tác cơ bản & Quản lý File
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<leader>w` | Normal | Lưu file nhanh (`:w`) |
| `<leader>q` | Normal | Đóng cửa sổ hiện tại (`:q`) |
| `<Esc>` | Normal | Xóa viền màu đánh dấu sau khi tìm kiếm chữ (`nohlsearch`) |
| `J` | Visual | Kéo khối code bôi đen **xuống dưới** 1 dòng |
| `K` | Visual | Kéo khối code bôi đen **lên trên** 1 dòng |
| `<` | Visual | Thụt lề sang trái (vẫn giữ nguyên vùng bôi đen) |
| `>` | Visual | Thụt lề sang phải (vẫn giữ nguyên vùng bôi đen) |

---

## 📑 2. Quản lý Tab / Buffer (Thanh trên cùng)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<Tab>` | Normal | Chuyển sang **tab kế tiếp** bên phải |
| `<S-Tab>` *(Shift + Tab)* | Normal | Lùi về **tab trước đó** bên trái |
| `<leader>bd` | Normal | **Đóng tab hiện tại** (`:bdelete`) |

---

## 🚀 3. Biên dịch & Chạy Code 1 Chạm (F5)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<F5>` | Normal | **Biên dịch & Chạy code ngay lập tức** (C, C++, Python, Go, JS, TS, PHP, HTML, Bash) mở cửa sổ ngang ở đáy |
| `<leader>rr` | Normal | Phím tắt phụ thay cho F5 (chạy code) |

---

## 🖥️ 4. Terminal (Cửa sổ dòng lệnh dưới đáy)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<Ctrl + \>` | Normal / Terminal | **Bật / Tắt Terminal dưới đáy** |
| `<Esc><Esc>` | Terminal | Thoát chế độ gõ lệnh của terminal, về **Normal mode** (để cuộn trang, bôi đen copy chữ) |
| `q` hoặc `<Esc>` | Normal (trong Terminal) | **Đóng ngay** cửa sổ Terminal |

---

## 📂 5. Cây Thư Mục (Neo-tree)
| Phím tắt | Vị trí | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<leader>e` | Toàn cục | **Bật / Tắt cây thư mục** bên trái |
| `<CR>` *(Enter)* | Trong Neo-tree | Mở file hoặc đóng/mở thư mục |
| `a` | Trong Neo-tree | **Tạo file mới** (thêm dấu `/` ở đuôi để tạo thư mục, vd: `src/`) |
| `d` | Trong Neo-tree | **Xóa** file / thư mục được chọn |
| `r` | Trong Neo-tree | **Đổi tên** file / thư mục (Rename) |
| `c` | Trong Neo-tree | Sao chép (Copy) file |
| `m` | Trong Neo-tree | Cắt / Di chuyển (Move) file |
| `y` | Trong Neo-tree | Copy đường dẫn của file |
| `<Tab>` | Trong Neo-tree | **Đánh dấu chọn file (hiện chấm tròn ●)** để thao tác hàng loạt (vd bấm Tab chọn 3 file rồi bấm `d` để xóa cùng lúc) |
| `R` | Trong Neo-tree | Làm mới (Refresh) lại cây thư mục |
| `?` | Trong Neo-tree | Mở menu xem toàn bộ phím tắt của Neo-tree |
| `q` | Trong Neo-tree | Đóng cây thư mục |

---

## 🔍 6. Tìm kiếm Siêu Nhanh (FZF & Navigation)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<leader>ff` | Normal | **Tìm kiếm file** theo tên trong toàn bộ dự án |
| `<leader>fg` | Normal | **Tìm kiếm đoạn chữ** trong toàn bộ code dự án (Live Grep) |
| `<leader>ss` | Normal | Tìm kiếm nhanh hàm, biến, tiêu đề trong file hiện tại |
| `<leader>xx` | Normal | **Mở bảng danh sách toàn bộ lỗi/cảnh báo** trong dự án |
| `<leader>o` | Normal | Bật / tắt bảng mục lục hàm & biến bên phải (**Aerial Outline**) |
| `-` *(Dấu trừ)* | Normal | Mở trình quản lý file dạng buffer đơn giản (**Oil.nvim**) |

---

## 🪟 7. Điều hướng giữa các khung chia màn hình (Split Windows)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<Ctrl + h>` | Normal / Terminal | Nhảy sang khung bên **Trái** |
| `<Ctrl + j>` | Normal / Terminal | Nhảy sang khung bên **Dưới** |
| `<Ctrl + k>` | Normal / Terminal | Nhảy sang khung bên **Trên** |
| `<Ctrl + l>` | Normal / Terminal | Nhảy sang khung bên **Phải** |

---

## 💡 8. LSP & Hỗ trợ Viết Code Thông Minh
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `gd` | Normal | **Nhảy tới định nghĩa** của hàm / biến (Go to Definition) |
| `gr` | Normal | Tìm tất cả các nơi đang gọi hàm / biến đó (References) |
| `K` *(Shift + K)* | Normal | **Xem thông tin / tài liệu** giải thích hàm (Hover Doc) |
| `<leader>ca` | Normal | **Sửa lỗi nhanh** (Code Action) |
| `<leader>cr` | Normal | **Đổi tên thông minh** biến/hàm trên toàn dự án (Rename) |
| `[d` / `]d` | Normal | Nhảy tới **Lỗi trước đó / Lỗi tiếp theo** |
| `<leader>cf` | Normal | **Định dạng code chuẩn đẹp tự động** (Format Document) |

---

## ✍️ 9. Gợi ý Code (Auto-completion - Blink.cmp)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `<Ctrl + Space>` | Insert | Bật bảng gợi ý code / xem giải thích gợi ý |
| `<Tab>` | Insert | Chọn gợi ý tiếp theo xuống dưới |
| `<S-Tab>` *(Shift + Tab)* | Insert | Chọn gợi ý trước đó lên trên |
| `<CR>` *(Enter)* | Insert | **Chấp nhận gợi ý code** |
| `<Ctrl + e>` | Insert | Đóng bảng gợi ý |

---

## 💬 10. Ghi chú (Comment) & Cặp Ngoặc
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `gcc` | Normal | Bật / tắt ghi chú (comment) dòng hiện tại |
| `gc` | Visual | Bật / tắt ghi chú khối code đang bôi đen |
| *Tự động đóng ngoặc* | Insert | Gõ `(`, `{`, `[`, `"`, `'` sẽ tự động đóng ngoặc tương ứng |

---

## 🌿 11. Quản lý Git (Gitsigns)
| Phím tắt | Chế độ | Mô tả tác dụng |
| :--- | :---: | :--- |
| `]c` | Normal | Nhảy tới đoạn code Git thay đổi **tiếp theo** |
| `[c` | Normal | Nhảy lùi về đoạn code Git thay đổi **trước đó** |
| `<leader>gp` | Normal | Xem trước nội dung đoạn code vừa sửa (Preview Hunk) |
| `<leader>gr` | Normal | **Hoàn tác (Undo)** đoạn code vừa sửa về lại bản Git gốc |
| `<leader>gb` | Normal | Xem người đã sửa dòng này và thời gian sửa (Git Blame) |
