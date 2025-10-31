return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  config = function()
    local npairs = require("nvim-autopairs")
    npairs.setup({
      check_ts = true,          -- smarter pairs with treesitter if you use it
      fast_wrap = {},           -- enables fast wrap (see mapping below)
      disable_filetype = { "TelescopePrompt" },
    })

    -- OPTIONAL: if you use nvim-cmp, integrate Enter/confirm with pairs
    local ok, cmp = pcall(require, "cmp")
    if ok then
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end

    -- OPTIONAL: fast wrap existing text with brackets/quotes
    -- Default mapping is <M-e> (Alt+e). Change if you like:
    -- require("nvim-autopairs.fastwrap").setup({ map = "<C-e>" })
  end,
}
