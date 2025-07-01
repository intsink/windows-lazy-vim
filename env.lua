-- ===================================================================
--  FORCE COMPILER CONFIGURATION
--  This file definitively sets the C compiler for Neovim.
-- ===================================================================

-- 1. Define the exact path to the compiler's "bin" directory.
--    Using forward slashes is safer and avoids escaping issues.
local compiler_bin_path = "C:/Users/<your_name>/AppData/Local/Microsoft/WinGet/Packages/BrechtSanders.WinLibs.POSIX.UCRT_Microsoft.Winget.Source_8wekyb3d8bbwe/mingw64/bin"

-- 2. Define the full path to the gcc.exe executable.
local gcc_executable = compiler_bin_path .. "/gcc.exe"

-- 3. Set the standard 'CC' environment variable inside Neovim.
--    This is the most direct way to tell build tools which compiler to use.
vim.env.CC = gcc_executable

-- 4. Forcefully prepend the compiler's path to Neovim's internal PATH.
--    This ensures it is the *first* place Neovim looks.
vim.env.PATH = compiler_bin_path .. ";" .. vim.env.PATH

-- 5. Create global variables for Neovim plugins to see.
--    This makes 'gcc' and its alias 'cc' explicitly available.
vim.g.cc = gcc_executable
vim.g.gcc = gcc_executable

-- Let Neovim know where other compilers would be if you install them.
-- This resolves the warnings for clang, cl, and zig.
vim.g.clang = "clang"
vim.g.cl = "cl"
vim.g.zig = "zig"

-- Print a confirmation message in Neovim to know this file was loaded.
print(">>> Custom compiler configuration from env.lua loaded successfully!")
