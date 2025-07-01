-- [FIX] Set custom environment variables BEFORE anything else.
-- This is crucial for finding the C compiler.
require("config.env")

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")