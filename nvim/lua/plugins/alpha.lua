return {
  -- disable snacks dashboard
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = { enabled = false },
    },
  },
  -- add alpha dashboard
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                     ",
      }

      local c = vim.fn.nr2char
      local icons = {
        find_file = c(0xF002),  -- fa-search
        new_file  = c(0xF15B),  -- fa-file
        find_word = c(0xF0B0),  -- fa-filter
        recent    = c(0xF017),  -- fa-clock-o
        project   = c(0xF187),  -- fa-archive
        restore   = c(0xF0E2),  -- fa-undo
        git       = c(0xE725),  -- dev-git_branch
        config    = c(0xF013),  -- fa-cog
        update    = c(0xF019),  -- fa-download
        quit      = c(0xF011),  -- fa-power-off
      }

      dashboard.section.buttons.val = {
        dashboard.button("LDR ff", icons.find_file .. "  Find file",          "<cmd>Telescope find_files<CR>"),
        dashboard.button("e",      icons.new_file  .. "  New file",           "<cmd>ene<CR>"),
        dashboard.button("LDR fw", icons.find_word .. "  Find word",          "<cmd>Telescope live_grep<CR>"),
        dashboard.button("LDR fr", icons.recent    .. "  Recent files",       "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("LDR fp", icons.project   .. "  Switch project",     "<cmd>AutoSession search<CR>"),
        dashboard.button("LDR wr", icons.restore   .. "  Restore session",    "<cmd>AutoSession restore<CR>"),
        dashboard.button("LDR gg", icons.git       .. "  Lazygit",            "<cmd>LazyGit<CR>"),
        dashboard.button("c",      icons.config    .. "  Configuration",      "<cmd>e $MYVIMRC<CR><cmd>cd %:p:h<CR>"),
        dashboard.button("u",      icons.update    .. "  Update plugins",     "<cmd>Lazy update<CR>"),
        dashboard.button("q",      icons.quit      .. "  Quit",               "<cmd>qa<CR>"),
      }

      alpha.setup(dashboard.opts)
      vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
    end,
  },
}
