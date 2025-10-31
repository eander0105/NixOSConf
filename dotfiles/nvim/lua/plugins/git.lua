return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add          = { text = "+" },
          change       = { text = "/" },
          delete       = { text = "_" },
          topdelete    = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },
        signcolumn = true,  -- show icons in the sign column
        numhl = false,
        linehl = false,
        word_diff = false,

        on_attach = function()
          -- Gruvbox / VSCode-inspired colors
          vim.api.nvim_set_hl(0, "GitSignsAdd",    { fg = "#b8bb26" }) -- green
          vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#fabd2f" }) -- yellow
          vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#fb4934" }) -- red
        end,
      })
    end,
  },
}
