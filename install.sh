#!/usr/bin/env bash
# ==============================================================================
# Script cài đặt Neovim & môi trường cho Linux (Hỗ trợ: pamac/pacman, dnf, apt)
# Tương thích cấu hình Neovim dùng Lazy.nvim, Treesitter, Mason, FZF, Tokyonight
# ==============================================================================

set -e

# Màu sắc hiển thị
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

info() { echo -e "${CYAN}[INFO]${NC} $1"; }
success() { echo -e "${GREEN}[OK]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NVIM_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

echo -e "${BLUE}"
echo "============================================="
echo "   Neovim Config Installer for Linux        "
echo "============================================="
echo -e "${NC}"

# 1. Phát hiện Package Manager
detect_pm() {
    if command -v pamac &>/dev/null; then
        echo "pamac"
    elif command -v pacman &>/dev/null; then
        echo "pacman"
    elif command -v dnf &>/dev/null; then
        echo "dnf"
    elif command -v apt-get &>/dev/null; then
        echo "apt"
    else
        echo "unknown"
    fi
}

PM=$(detect_pm)
info "Phát hiện trình quản lý gói: ${GREEN}$PM${NC}"

# Cần quyền sudo nếu không phải pamac (pamac có thể tự xin quyền polkit)
SUDO=""
if [ "$EUID" -ne 0 ] && [ "$PM" != "pamac" ]; then
    if command -v sudo &>/dev/null; then
        SUDO="sudo"
    else
        error "Yêu cầu quyền root hoặc cài đặt sudo để tiếp tục."
    fi
fi

# 2. Cài đặt các gói phụ thuộc và Neovim
info "Đang cập nhật và cài đặt các gói cần thiết (neovim, git, build-essential/gcc, ripgrep, curl, nodejs, python)..."

case "$PM" in
    pamac)
        pamac install --no-confirm neovim git base-devel ripgrep fd curl wget unzip tar nodejs npm python python-pip clang ttf-jetbrains-mono-nerd
        ;;
    pacman)
        $SUDO pacman -Syu --noconfirm --needed neovim git base-devel ripgrep fd curl wget unzip tar nodejs npm python python-pip clang ttf-jetbrains-mono-nerd
        ;;
    dnf)
        $SUDO dnf check-update || true
        $SUDO dnf install -y neovim git @development-tools gcc-c++ ripgrep fd-find curl wget unzip tar nodejs npm python3 python3-pip clang
        ;;
    apt)
        $SUDO apt-get update
        $SUDO apt-get install -y git build-essential ripgrep fd-find curl wget unzip tar nodejs npm python3 python3-pip clang

        # Trên Ubuntu/Debian cũ, apt neovim thường bị cũ (< 0.10). Kiểm tra và lấy bản mới nếu cần.
        if ! command -v nvim &>/dev/null || [ "$(nvim -v | head -n 1 | grep -oE '[0-9]+\.[0-9]+' | head -n 1 | tr -d '.')" -lt 10 ]; then
            info "Đang cài đặt Neovim bản mới nhất (qua AppImage hoặc PPA)..."
            if command -v add-apt-repository &>/dev/null; then
                $SUDO add-apt-repository -y ppa:neovim-ppa/unstable
                $SUDO apt-get update
                $SUDO apt-get install -y neovim
            else
                wget -q --show-progress -O /tmp/nvim.appimage https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
                chmod u+x /tmp/nvim.appimage
                $SUDO mv /tmp/nvim.appimage /usr/local/bin/nvim
            fi
        fi
        ;;
    *)
        error "Không nhận diện được trình quản lý gói (hỗ trợ pamac, pacman, dnf, apt)."
        ;;
esac

success "Đã cài đặt xong các gói phụ thuộc."

# 3. Cài đặt JetBrainsMono Nerd Font (cho Debian/Fedora nếu chưa có gói font)
install_nerd_font() {
    FONT_DIR="$HOME/.local/share/fonts"
    if ! fc-list : family | grep -iq "JetBrainsMono Nerd Font"; then
        info "Đang tải và cài đặt JetBrainsMono Nerd Font cho Linux..."
        mkdir -p "$FONT_DIR"
        TMP_FONT_ZIP="/tmp/JetBrainsMono.zip"
        curl -fLo "$TMP_FONT_ZIP" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
        tar -xf "$TMP_FONT_ZIP" -C "$FONT_DIR"
        rm -f "$TMP_FONT_ZIP"
        if command -v fc-cache &>/dev/null; then
            fc-cache -f "$FONT_DIR"
        fi
        success "Đã cài đặt JetBrainsMono Nerd Font."
    else
        info "JetBrainsMono Nerd Font đã tồn tại trên hệ thống."
    fi
}
install_nerd_font

# 4. Thiết lập thư mục config ~/.config/nvim
if [ "$SCRIPT_DIR" != "$NVIM_CONFIG_DIR" ]; then
    info "Đang liên kết/sao chép cấu hình vào $NVIM_CONFIG_DIR..."
    if [ -d "$NVIM_CONFIG_DIR" ] && [ ! -L "$NVIM_CONFIG_DIR" ]; then
        BACKUP_DIR="${NVIM_CONFIG_DIR}.bak.$(date +%Y%m%d%H%M%S)"
        warn "Phát hiện config cũ, đang tạo bản sao lưu tại $BACKUP_DIR"
        mv "$NVIM_CONFIG_DIR" "$BACKUP_DIR"
    fi
    mkdir -p "$(dirname "$NVIM_CONFIG_DIR")"
    ln -sfn "$SCRIPT_DIR" "$NVIM_CONFIG_DIR"
    success "Đã tạo symlink từ $SCRIPT_DIR sang $NVIM_CONFIG_DIR"
else
    info "Script đang chạy trực tiếp từ $NVIM_CONFIG_DIR"
fi

# 5. Cài đặt Lazy.nvim & đồng bộ plugin
LAZY_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/lazy/lazy.nvim"
if [ ! -d "$LAZY_DIR" ]; then
    info "Đang tải Lazy.nvim từ GitHub..."
    mkdir -p "$(dirname "$LAZY_DIR")"
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$LAZY_DIR"
    success "Đã tải xong Lazy.nvim."
fi

info "Đang khởi tạo plugin qua Lazy.nvim..."
nvim --headless "+Lazy! sync" "+qa" || true

echo -e "\n${GREEN}============================================="
echo "   CÀI ĐẶT HOÀN TẤT THÀNH CÔNG!"
echo "   Khởi động Neovim bằng lệnh: nvim"
echo "   (Nhớ chọn font JetBrainsMono Nerd Font trong Terminal)"
echo "=============================================${NC}"
