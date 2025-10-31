return {
  -- UI, theme etc
  -- TODO: split plugins.ui into their own files
  { import = "plugins.ui" },
  { import = "plugins.todohl" }, -- Todo highlight

  -- Tools
  { import = "plugins.git" },
  { import = "plugins.ai" }, -- Collection of AI features

  -- Files and navigation management
  -- TODO: split plugins.files into their own files
  { import = "plugins.files" },
  { import = "plugins.harpoon" },
  { import = "plugins.persistence" },

  -- Coding, LSP, autocomplete etc
  -- TODO: split plugins.coding into thier own files
  { import = "plugins.coding" },
  { import = "plugins.autopairs" },
}
