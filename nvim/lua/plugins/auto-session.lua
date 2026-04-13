return {
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      auto_restore = false,
      suppressed_dirs = {
        "~/",
        "~/Dev/",
        "~/Documents/",
        "~/Documents/Development/",
        "~/Downloads/",
        "~/Desktop/",
      },
    },
    keys = {
      { "<leader>wr", "<cmd>AutoSession restore<CR>", desc = "Restore session for cwd" },
      { "<leader>ws", "<cmd>AutoSession save<CR>", desc = "Save session for cwd" },
    },
  },
}
