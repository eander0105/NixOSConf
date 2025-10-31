return {
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim"},
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          layout_strategy = "vertical",
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
        },
      })
      -- Mappings
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    end,
  },
}
