# ==============================================================================
# Script cài đặt Neovim & môi trường cho Windows
# Tương thích cấu hình Neovim dùng Lazy.nvim, Treesitter, Mason, FZF, Tokyonight
# ==============================================================================

#Requires -Version 5.1
[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

function Write-Info($msg) { Write-Host "[INFO] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "[OK]   $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "[WARN] $msg" -ForegroundColor Yellow }
function Write-Err($msg) { Write-Host "[ERR]  $msg" -ForegroundColor Red }

Write-Host "=============================================" -ForegroundColor Blue
Write-Host "   Neovim Config Installer for Windows       " -ForegroundColor Blue
Write-Host "=============================================" -ForegroundColor Blue

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$nvimTargetDir = "$env:LOCALAPPDATA\nvim"

# 1. Kiểm tra trình quản lý gói Winget
$hasWinget = (Get-Command winget -ErrorAction SilentlyContinue) -ne $null

if ($hasWinget) {
    Write-Info "Đang kiểm tra và cài đặt công cụ cần thiết qua winget..."

    $packages = @(
        @{ id = "Neovim.Neovim"; name = "Neovim" },
        @{ id = "Git.Git"; name = "Git" },
        @{ id = "BurntSushi.ripgrep.MSVC"; name = "Ripgrep" },
        @{ id = "sharkdp.fd"; name = "fd" },
        @{ id = "OpenJS.NodeJS"; name = "Node.js (cho Mason LSP)" },
        @{ id = "LLVM.LLVM"; name = "LLVM / Clang (cho C/C++ LSP)" }
    )

    foreach ($pkg in $packages) {
        Write-Info "Đang kiểm tra $($pkg.name)..."
        try {
            winget install --id $pkg.id -e --accept-source-agreements --accept-package-agreements --silent
            Write-Success "Đã kiểm tra/cài đặt $($pkg.name)"
        } catch {
            Write-Warn "Không thể cài đặt tự động $($pkg.name), bỏ qua hoặc đã cài."
        }
    }
} else {
    Write-Warn "Không tìm thấy winget. Vui lòng đảm bảo bạn đã cài đặt Neovim, Git, Ripgrep và Node.js thủ công."
}

# 2. Cài đặt JetBrainsMono Nerd Font nếu chưa có
function Install-NerdFont {
    $fontName = "JetBrainsMono Nerd Font"
    $regKey = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    $installed = (Get-ItemProperty $regKey -ErrorAction SilentlyContinue | Get-Member -MemberType NoteProperty | Where-Object { $_.Name -like "*JetBrainsMono*Nerd*" })

    if (-not $installed) {
        Write-Info "Đang tải và cài đặt JetBrainsMono Nerd Font..."
        $tempZip = "$env:TEMP\JetBrainsMono.zip"
        $tempExtract = "$env:TEMP\JetBrainsMonoFont"
        $fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

        $fontsDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
        if (-not (Test-Path $fontsDir)) { New-Item -ItemType Directory -Path $fontsDir -Force | Out-Null }

        Invoke-WebRequest -Uri $fontUrl -OutFile $tempZip -UseBasicParsing
        Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

        Get-ChildItem -Path $tempExtract -Filter "*.ttf" | ForEach-Object {
            $dest = Join-Path $fontsDir $_.Name
            Copy-Item $_.FullName $dest -Force
            New-ItemProperty -Path $regKey -Name "$($_.BaseName) (TrueType)" -Value $dest -PropertyType String -Force | Out-Null
        }

        Remove-Item $tempZip -Force -ErrorAction SilentlyContinue
        Remove-Item $tempExtract -Recurse -Force -ErrorAction SilentlyContinue
        Write-Success "Đã cài đặt xong JetBrainsMono Nerd Font."
    } else {
        Write-Info "JetBrainsMono Nerd Font đã được cài đặt trên hệ thống."
    }
}
Install-NerdFont

# 3. Cập nhật Windows Terminal settings để dùng font Nerd Font
function Configure-WindowsTerminal {
    $wtPkg = Get-ChildItem "$env:LOCALAPPDATA\Packages" -Filter "*WindowsTerminal*" -ErrorAction SilentlyContinue | Select-Object -First 1
    if ($wtPkg) {
        $settingsPath = "$($wtPkg.FullName)\LocalState\settings.json"
        if (Test-Path $settingsPath) {
            try {
                $json = Get-Content $settingsPath -Raw | ConvertFrom-Json
                if (-not $json.profiles.defaults.font) {
                    $json.profiles.defaults | Add-Member -MemberType NoteProperty -Name "font" -Value ([PSCustomObject]@{})
                }
                $json.profiles.defaults.font | Add-Member -MemberType NoteProperty -Name "face" -Value "JetBrainsMono Nerd Font" -Force
                $json | ConvertTo-Json -Depth 10 | Set-Content $settingsPath -Encoding utf8
                Write-Success "Đã cấu hình font 'JetBrainsMono Nerd Font' cho Windows Terminal."
            } catch {
                Write-Warn "Không thể cập nhật cấu hình Windows Terminal tự động: $_"
            }
        }
    }
}
Configure-WindowsTerminal

# 4. Thiết lập thư mục config $env:LOCALAPPDATA\nvim
if ($scriptDir -ne $nvimTargetDir) {
    Write-Info "Đang sao chép cấu hình vào $nvimTargetDir..."
    if (Test-Path $nvimTargetDir) {
        $backupDir = "$nvimTargetDir.bak.$(Get-Date -Format 'yyyyMMddHHmmss')"
        Write-Warn "Đã sao lưu cấu hình cũ tại $backupDir"
        Move-Item $nvimTargetDir $backupDir -Force
    }
    Copy-Item $scriptDir $nvimTargetDir -Recurse -Force
    Write-Success "Đã sao chép cấu hình thành công."
} else {
    Write-Info "Script đang chạy trực tiếp tại $nvimTargetDir"
}

# 5. Cài đặt Lazy.nvim & đồng bộ plugin
$lazyDir = "$env:LOCALAPPDATA\nvim-data\lazy\lazy.nvim"
if (-not (Test-Path $lazyDir)) {
    Write-Info "Đang tải Lazy.nvim từ GitHub..."
    $lazyParent = Split-Path -Parent $lazyDir
    if (-not (Test-Path $lazyParent)) { New-Item -ItemType Directory -Path $lazyParent -Force | Out-Null }
    git clone --filter=blob:none https://github.com/folke/lazy.nvim.git --branch=stable "$lazyDir"
    Write-Success "Đã tải xong Lazy.nvim."
}

Write-Info "Đang đồng bộ plugin qua Lazy.nvim..."
try {
    nvim --headless "+Lazy! sync" "+qa"
    Write-Success "Đồng bộ plugin thành công!"
} catch {
    Write-Warn "Chạy nvim headless gặp sự cố, bạn có thể mở nvim để Lazy tự động cài đặt."
}

Write-Host "`n=============================================" -ForegroundColor Green
Write-Host "   CÀI ĐẶT HOÀN TẤT THÀNH CÔNG!" -ForegroundColor Green
Write-Host "   Mở tab Terminal mới và gõ: nvim" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Green
