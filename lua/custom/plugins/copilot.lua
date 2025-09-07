return {
  'github/copilot.vim',
  event = 'VeryLazy',
  config = function()
    -- Enable Tab keybinding for accepting suggestions
    vim.g.copilot_no_tab_map = false
    vim.g.copilot_assume_mapped = true
    
    -- Enable Copilot for all filetypes (including empty buffers)
    vim.g.copilot_filetypes = {
      ['*'] = true,
    }
    
    -- Optional: Additional keybindings
    vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
    
    -- Since we're loading after VimEnter, we need to manually initialize Copilot
    vim.defer_fn(function()
      pcall(vim.fn['copilot#Init'])
      vim.cmd('redrawstatus')
    end, 100)
  end,
}