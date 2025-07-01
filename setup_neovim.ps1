# English: Stop script execution on errors.
# 中文: 在遇到错误时停止脚本执行。
$ErrorActionPreference = "Stop"

# English: Start of the script.
# 中文: 脚本开始执行。
Write-Host "Starting Neovim and LazyVim setup... (开始 Neovim 与 LazyVim 的安装过程...)" -ForegroundColor Green

# --- Step 1: Check and install Git ---
# --- 步骤 1: 检查并安装 Git ---
Write-Host "Step 1: Checking for Git... (检查 Git...)"
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "  Git not found. Installing via winget... (未找到 Git，正在通过 winget 安装...)"
    try {
        winget install --id Git.Git -e --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "  Git installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "  Git installation failed. Please install it manually from https://git-scm.com/download/win and run this script again." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "  Git is already installed. (Git 已安装。)"
}

# --- Step 2: Check and install Neovim ---
# --- 步骤 2: 检查并安装 Neovim ---
Write-Host "Step 2: Checking for Neovim... (检查 Neovim...)"
if (-not (Get-Command nvim -ErrorAction SilentlyContinue)) {
    Write-Host "  Neovim not found. Installing via winget... (未找到 Neovim，正在通过 winget 安装...)"
    try {
        winget install --id Neovim.Neovim -e --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "  Neovim installed successfully." -ForegroundColor Green
    } catch {
        Write-Host "  Neovim installation failed. Please install it manually and run this script again." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "  Neovim is already installed. (Neovim 已安装。)"
}

# --- Step 3: Check and install a C Compiler (GCC via WinLibs) ---
# --- 步骤 3: 检查并安装 C 编译器 (通过 WinLibs 安装 GCC) ---
Write-Host "Step 3: Checking for a C Compiler (gcc)... (检查 C 编译器...)"
if (-not (Get-Command gcc -ErrorAction SilentlyContinue)) {
    Write-Host "  GCC not found. Installing via winget... (未找到 GCC，正在通过 winget 安装...)"
    try {
        winget install --id BrechtSanders.WinLibs.POSIX.UCRT -e --source winget --accept-package-agreements --accept-source-agreements
        Write-Host "  GCC (WinLibs) installed successfully. A terminal restart will be required." -ForegroundColor Green
    } catch {
        Write-Host "  GCC installation failed. Please try to install it manually." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "  A C compiler (gcc) is already installed. (C 编译器已安装。)"
}

# --- Step 4: Backup existing Neovim configuration ---
# --- 步骤 4: 备份已有的 Neovim 配置 ---
Write-Host "Step 4: Backing up existing Neovim configuration... (备份已有 Neovim 配置...)"
$nvimConfigPath = "$env:LOCALAPPDATA\nvim"
$nvimDataPath = "$env:LOCALAPPDATA\nvim-data"
$timestamp = Get-Date -Format "yyyyMMddHHmmss"

if (Test-Path $nvimConfigPath) {
    $backupPath = "$nvimConfigPath.bak.$timestamp"
    Write-Host "  - Found existing nvim config. Backing up to $backupPath"
    Rename-Item -Path $nvimConfigPath -NewName $backupPath -ErrorAction SilentlyContinue
}

if (Test-Path $nvimDataPath) {
    $backupPath = "$nvimDataPath.bak.$timestamp"
    Write-Host "  - Found existing nvim-data. Backing up to $backupPath"
    Rename-Item -Path $nvimDataPath -NewName $backupPath -ErrorAction SilentlyContinue
}

# --- Step 5: Clone LazyVim Starter ---
# --- 步骤 5: 克隆 LazyVim 初始配置 ---
Write-Host "Step 5: Cloning LazyVim starter from GitHub... (从 GitHub 克隆 LazyVim...)"
try {
    git clone https://github.com/LazyVim/starter $nvimConfigPath
    Write-Host "  LazyVim starter cloned successfully." -ForegroundColor Green
} catch {
    Write-Host "  Failed to clone LazyVim. Check your internet connection and if Git is installed correctly." -ForegroundColor Red
    exit 1
}

# --- Done ---
# --- 完成 ---
Write-Host ""
Write-Host "**************************************************" -ForegroundColor Cyan
Write-Host "      Setup script finished!" -ForegroundColor Cyan
Write-Host "**************************************************" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next Steps (重要：下一步操作):"
Write-Host "1. CLOSE AND REOPEN this terminal to apply PATH changes for the compiler."
Write-Host "   (请务必关闭并重新打开此终端，以使编译器的环境变量生效。)"
Write-Host "2. Run the 'nvim' command in the new terminal."
Write-Host "   (在新终端中，运行 'nvim' 命令。)"
Write-Host "3. On first launch, LazyVim will install all plugins. Please wait for it to complete."
Write-Host "   (首次启动时，LazyVim 会自动安装所有插件，请耐心等待。)"
Write-Host "4. If you still see a 'No C compiler' error, follow the instructions in the README.md file."
Write-Host "   (如果仍然看到“找不到 C 编译器”的错误，请遵循 README.md 文件中的指示操作。)"
