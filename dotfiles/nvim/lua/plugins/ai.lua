-- Unsure about this, need some tweaking to be nice
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = false,
        keymap = {
          accept = "<C-l>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-h>",
        },
      },
      panel = { enabled = false },
    })
  end,
}
