-- Use telescope as the picker (prevents snacks_picker from loading)
vim.g.lazyvim_picker = "telescope"

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
