return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = {
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "inside function" },
            ["ac"] = { query = "@class.outer", desc = "around class" },
            ["ic"] = { query = "@class.inner", desc = "inside class" },
            ["aa"] = { query = "@parameter.outer", desc = "around parameter" },
            ["ia"] = { query = "@parameter.inner", desc = "inside parameter" },
            ["ai"] = { query = "@conditional.outer", desc = "around conditional" },
            ["ii"] = { query = "@conditional.inner", desc = "inside conditional" },
            ["al"] = { query = "@loop.outer", desc = "around loop" },
            ["il"] = { query = "@loop.inner", desc = "inside loop" },
            ["a="] = { query = "@assignment.outer", desc = "around assignment" },
            ["i="] = { query = "@assignment.inner", desc = "inside assignment" },
            ["l="] = { query = "@assignment.lhs", desc = "assignment left side" },
            ["r="] = { query = "@assignment.rhs", desc = "assignment right side" },
            ["a@"] = { query = "@annotation.outer", desc = "around annotation/decorator" },
            ["i@"] = { query = "@annotation.inner", desc = "inside annotation/decorator" },
            ["at"] = { query = "@trycatch.outer", desc = "around try/catch block" },
            ["it"] = { query = "@trycatch.inner", desc = "inside try/catch block" },
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            ["]m"] = { query = "@function.outer", desc = "Next method/function start" },
            ["]c"] = { query = "@class.outer", desc = "Next class start" },
            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
          },
          goto_next_end = {
            ["]M"] = { query = "@function.outer", desc = "Next method/function end" },
            ["]C"] = { query = "@class.outer", desc = "Next class end" },
          },
          goto_previous_start = {
            ["[m"] = { query = "@function.outer", desc = "Prev method/function start" },
            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
          },
          goto_previous_end = {
            ["[M"] = { query = "@function.outer", desc = "Prev method/function end" },
            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
          },
        },
      },
    },
  },
}
