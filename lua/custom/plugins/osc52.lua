-- OSC52 clipboard integration for SSH/mosh sessions
-- Enables yanking from remote Neovim to local system clipboard
return {
  'ojroques/nvim-osc52',
  config = function()
    local osc52 = require('osc52')
    
    osc52.setup({
      -- Maximum length of selection to copy (0 = no limit)
      max_length = 0,
      
      -- Disable silent mode to see copy confirmations
      silent = false,
      
      -- Trim trailing newline characters from text
      trim = false,
    })

    -- Helper function to copy using OSC52
    local function copy()
      if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
        require('osc52').copy_register('')
      end
    end

    -- Auto-copy to system clipboard on yank when connected via SSH/mosh
    if vim.env.SSH_TTY or vim.env.MOSH or vim.env.SSH_CLIENT or vim.env.SSH_CONNECTION then
      -- Auto-copy ALL yanks to system clipboard via OSC52
      vim.api.nvim_create_autocmd('TextYankPost', {
        callback = function()
          if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
            require('osc52').copy_register('')
          end
        end,
        desc = 'Auto-copy yanks to system clipboard via OSC52',
      })
      
      -- Notify user that OSC52 is active
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          vim.defer_fn(function()
            vim.notify("OSC52 clipboard enabled for remote session", vim.log.levels.INFO, { title = "OSC52" })
          end, 100)
        end,
        once = true,
      })
    end

    -- Visual mode mapping to copy selection
    vim.keymap.set('v', '<leader>y', require('osc52').copy_visual, { desc = 'Copy to system clipboard via OSC52' })
    
    -- Normal mode operator-pending mapping
    vim.keymap.set('n', '<leader>y', require('osc52').copy_operator, { expr = true, desc = 'Copy motion to system clipboard via OSC52' })
    
    -- Copy current line
    vim.keymap.set('n', '<leader>yy', '<leader>y_', { remap = true, desc = 'Copy line to system clipboard via OSC52' })
  end,
}