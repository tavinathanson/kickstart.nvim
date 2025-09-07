return {
  'github/copilot.vim',
  event = 'VeryLazy',
  config = function()
    -- Disable default Tab mapping to avoid conflicts
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = false
    
    -- Enable Copilot for all filetypes (including empty buffers)
    vim.g.copilot_filetypes = {
      ['*'] = true,
    }
    
    -- Accept suggestion with Ctrl-Enter (works in insert mode)
    vim.keymap.set('i', '<C-CR>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = 'Accept Copilot suggestion'
    })
    
    -- Alternative: Accept with Ctrl-J (common in other editors)
    vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', {
      expr = true,
      replace_keycodes = false,
      desc = 'Accept Copilot suggestion'
    })
    
    -- Navigate suggestions with Alt-] and Alt-[
    vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'Next Copilot suggestion' })
    vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'Previous Copilot suggestion' })
    
    -- Dismiss suggestions with Ctrl-E (Vim's default for cancel)
    vim.keymap.set('i', '<C-e>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss Copilot suggestion' })
    
    -- Open Copilot panel with <leader>cp in both normal and insert mode
    vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', { desc = '[C]opilot [P]anel' })
    vim.keymap.set('i', '<C-\\><C-p>', '<Esc>:Copilot panel<CR>', { desc = 'Open Copilot panel' })
    
    -- Quick access to Copilot commands
    vim.keymap.set('n', '<leader>cs', ':Copilot suggestion<CR>', { desc = '[C]opilot [S]uggestion' })
    vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[C]opilot [D]isable' })
    vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[C]opilot [E]nable' })
    vim.keymap.set('n', '<leader>cr', ':Copilot restart<CR>', { desc = '[C]opilot [R]estart' })
    vim.keymap.set('n', '<leader>ch', ':help copilot-keybindings<CR>', { desc = '[C]opilot [H]elp' })
    vim.keymap.set('n', '<leader>c?', ':help copilot-keybindings<CR>', { desc = '[C]opilot keybindings [?]' })
    
    -- Set up which-key group
    local ok, wk = pcall(require, 'which-key')
    if ok then
      wk.add({
        { '<leader>c', group = '[C]opilot' },
      })
    end
    
    -- Since we're loading after VimEnter, we need to manually initialize Copilot
    vim.defer_fn(function()
      pcall(vim.fn['copilot#Init'])
      vim.cmd('redrawstatus')
    end, 100)
  end,
}