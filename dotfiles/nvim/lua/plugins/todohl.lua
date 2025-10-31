return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("todo-comments").setup({
      signs = true,
      sign_priority = 8,

      keywords = {
        FIX   = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "ISSUE" } },
        TODO  = { icon = " ", color = "info" },
        HACK  = { icon = " ", color = "hack" },
        WARN  = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF  = { icon = " ", color = "perf" },
        NOTE  = { icon = " ", color = "note",    alt = { "INFO", "NB" } },
        TEST  = { icon = "⏲ ", color = "test" },
      },

      highlight = {
        multiline = false,
        before = "",
        keyword = "bg",
        after = "fg",
        pattern = [[.*<(KEYWORDS)\s*:]],
        comments_only = true,
      },

      colors = {
        error   = { "GruvboxRed",    "ErrorMsg", "DiagnosticError" },
        warning = { "GruvboxYellow", "WarningMsg", "DiagnosticWarn" },
        info    = { "GruvboxBlue",   "DiagnosticInfo" },
        hint    = { "GruvboxGreen",  "DiagnosticHint" },
        default = { "GruvboxPurple", "Identifier" },
        perf    = { "GruvboxOrange", "Type" },
        hack    = { "GruvboxOrange", "Statement" },
        note    = { "GruvboxAqua",   "Comment" },
        test    = { "GruvboxAqua",   "Function" },
      },
    })

    -- ========== Keymaps ==========
    local map = vim.keymap.set
    map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next TODO comment" })
    map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Previous TODO comment" })
    map("n", "<leader>st", "<cmd>TodoTelescope<CR>", { desc = "Search TODOs (Telescope)" })
    map("n", "<leader>tq", "<cmd>TodoQuickFix<CR>", { desc = "Send TODOs to quickfix" })
    map("n", "<leader>tl", "<cmd>TodoLocList<CR>",  { desc = "Send TODOs to loclist" })
  end,
}
