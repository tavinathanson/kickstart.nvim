return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      -- Oil will take over directory buffers (e.g. `vim .` or `:e src/`)
      default_file_explorer = true,
      -- Id's are automatically assigned when actions are performed
      -- Set to false to remove a border around the file preview
      delete_to_trash = true,
      -- Skip the confirmation popup for simple operations
      skip_confirm_for_simple_edits = true,
      -- Set to false to disable all of the above keymaps
      use_default_keymaps = true,
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = "rounded",
        win_options = {
          winblend = 0,
        },
      },
    }
  end,
}