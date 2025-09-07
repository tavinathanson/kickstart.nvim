return {
  'github/copilot.vim',
  event = 'VeryLazy',  -- Load earlier to ensure statusline can detect it
  config = function()
    -- Enable Tab keybinding for accepting suggestions
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_assume_mapped = true
    
    -- Optional: Additional keybindings
    vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
    
    -- Force Copilot to initialize and check auth status
    vim.defer_fn(function()
      -- Initialize Copilot agent
      vim.cmd('silent! Copilot status')
      
      -- Force statusline refresh
      vim.cmd('redrawstatus')
      
      -- Check if authenticated
      vim.schedule(function()
        local ok, is_authed = pcall(vim.fn['copilot#Enabled'])
        if not ok or is_authed ~= 1 then
          vim.notify(
            'GitHub Copilot is not authenticated.\nRun :Copilot setup to sign in.',
            vim.log.levels.WARN,
            { title = 'Copilot Setup Required' }
          )
        end
      end)
    end, 100) -- Small delay to let plugin load
  end,
}