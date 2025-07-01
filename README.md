# 在 Windows 11 on ARM 上安装并配置 LazyVim (由 Gemini CLI 完成)

# Installing and Configuring LazyVim on Windows 11 on ARM (Completed by Gemini CLI)

---

### 关于此项目 / About This Project

这个文件夹包含了在 Windows 11 on ARM 环境下，通过 PowerShell 脚本和手动配置，成功安装 Neovim 并配置好 LazyVim 的所有必要文件和说明。整个过程由 Google Gemini CLI 辅助完成。

This folder contains all the necessary files and instructions to successfully install Neovim and configure LazyVim in a Windows 11 on ARM environment, using a combination of PowerShell scripts and manual configuration. The entire process was assisted by the Google Gemini CLI.

---
*   **原生 Arm64 GCC 项目**: [Windows-on-ARM-Experiments/gcc-woarm64](https://github.com/Windows-on-ARM-Experiments/gcc-woarm64)

**请注意**: 这是一个高级步骤，需要从源代码编译工具链。请遵循该代码仓库中的说明。本项目的自动化安装脚本**不会**为您处理此操作。

*   **Native Arm64 GCC Project**: [Windows-on-ARM-Experiments/gcc-woarm64](https://github.com/Windows-on-ARM-Experiments/gcc-woarm64)

**Note**: This is an advanced step and requires compiling the toolchain from source. Please follow the instructions in that repository. The automated setup script in this project does **not** handle this for you.




---
### 文件说明 / File Descriptions

*   `setup_neovim.ps1`:
    *   **EN**: A PowerShell script that automates the installation of Git, Neovim, and the GCC C compiler (via WinLibs). It also backs up any existing Neovim configuration and clones the LazyVim starter repository.
    *   **中**: 一个 PowerShell 脚本，用于自动化安装 Git、Neovim 和 GCC C 编译器（通过 WinLibs）。它还会备份任何已有的 Neovim 配置，并克隆 LazyVim 的初始仓库。

*   `env.lua`:
    *   **EN**: A crucial Lua configuration file that **forcefully** tells Neovim where to find the C compiler. This is the definitive fix for the "No C compiler found" error.
    *   **中**: 一个至关重要的 Lua 配置文件，它**强制性地**告诉 Neovim 在哪里可以找到 C 编译器。这是针对“找不到 C 编译器”错误的最终解决方案。

*   `init.lua`:
    *   **EN**: The modified main Neovim configuration file for LazyVim. Its most important job is to load our `env.lua` file **before** anything else, ensuring the compiler path is set correctly from the very start.
    *   **中**: 修改后的 LazyVim 主配置文件。它最重要的作用就是在加载任何其他东西**之前**，首先加载我们的 `env.lua` 文件，从而确保编译器路径从一开始就被正确设置。

---

### 致 Windows on Arm 用户 / For Windows on Arm Users

**EN**: The default C compiler (GCC) installed by the `setup_neovim.ps1` script is for the x86-64 architecture and runs on Arm64 devices through Windows' built-in emulation layer. While this works, advanced users seeking optimal performance may prefer to use a native Arm64 compiler.

If you have the technical skills, you can build and install a native GCC compiler from the following project. This can provide better performance for compiler-dependent tasks within Neovim.

*   **Native Arm64 GCC Project**: [Windows-on-ARM-Experiments/gcc-woarm64](https://github.com/Windows-on-ARM-Experiments/gcc-woarm64)

**Note**: This is an advanced step and requires compiling the toolchain from source. Please follow the instructions in that repository. The automated setup script in this project does **not** handle this for you.

**中**: `setup_neovim.ps1` 脚本默认安装的 C 编译器 (GCC) 是 x86-64 架构的，它通过 Windows 内置的模拟层在 Arm64 设备上运行。虽然这可以正常工作，但追求最佳性能的高级用户可能更希望使用原生的 Arm64 编译器。

如果你具备相应的技术能力，可以从以下项目构建并安装一个原生的 GCC 编译器。这可以为 Neovim 中依赖编译器的任务提供更好的性能。



---

### 安装与配置步骤 / Installation and Configuration Steps

**步骤 1: 运行自动化安装脚本 / Step 1: Run the Automated Installation Script**

1.  **EN**: Open a new PowerShell terminal as an Administrator.
    **中**: 以管理员身份打开一个新的 PowerShell 终端。

2.  **EN**: Navigate to this `windows-lazy-vim` directory.
    **中**: 导航到当前这个 `windows-lazy-vim` 文件夹内。

3.  **EN**: Execute the setup script by running the following command:
    **中**: 运行以下命令来执行安装脚本：
    ```powershell
powershell -ExecutionPolicy Bypass -File .\setup_neovim.ps1
    ```

4.  **EN**: After the script finishes, **it is critical that you close and reopen the PowerShell terminal** to ensure the new environment variables (especially for the C compiler) are loaded.
    **中**: 脚本执行完毕后，**务必关闭并重新打开 PowerShell 终端**，以确保新的环境变量（特别是 C 编译器的路径）被成功加载。

**步骤 2: 启动 Neovim 并检查 / Step 2: Launch Neovim and Check**

1.  **EN**: In the **new** terminal, type `nvim` and press Enter.
    **中**: 在**新**的终端中，输入 `nvim` 并按回车。

2.  **EN**: LazyVim will start its automatic plugin installation process. Wait for it to complete.
    **中**: LazyVim 会开始自动安装插件，请耐心等待其完成。

3.  **EN**: If you **do not** see the "No C compiler found" error, your setup is complete! Congratulations!
    **中**: 如果你**没有**看到“找不到 C 编译器”的错误，那么你的配置就完成了！恭喜！

**步骤 3: (如果错误依旧存在) 手动修复 / Step 3: (If the Error Persists) Manual Fix**

**EN**: If the compiler error still appears, it means Neovim did not correctly inherit the system's PATH. The following steps will fix it permanently.
**中**: 如果编译器的错误依旧出现，这说明 Neovim 未能正确继承系统的 PATH 环境变量。以下步骤将永久性地解决此问题。

1.  **EN**: Copy the `env.lua` file from this directory.
    **中**: 从当前文件夹复制 `env.lua` 文件。

2.  **EN**: Paste it into your Neovim config directory at: `C:\Users\<Your-Username>\AppData\Local\nvim\lua\config\`
    **中**: 将其粘贴到你的 Neovim 配置目录中：`C:\Users\<你的用户名>\AppData\Local\nvim\lua\config\`

3.  **EN**: Copy the `init.lua` file from this directory.
    **中**: 从当前文件夹复制 `init.lua` 文件。

4.  **EN**: Paste it into your main Neovim directory at: `C:\Users\<Your-Username>\AppData\Local\nvim\`, **replacing** the existing file.
    **中**: 将其粘贴到你的 Neovim 主目录中：`C:\Users\<你的用户名>\AppData\Local\nvim\`，并**覆盖**已有的文件。

5.  **EN**: Launch `nvim` again. The problem will now be solved.
    **中**: 再次启动 `nvim`。这次问题将彻底解决。
