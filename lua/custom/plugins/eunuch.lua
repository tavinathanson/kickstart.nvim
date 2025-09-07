return {
  'tpope/vim-eunuch',
  event = 'VeryLazy',
  init = function()
    -- Only set up the keymaps, let vim-eunuch handle the behavior
    vim.keymap.set('n', '<leader>fr', ':Rename<Space>', { desc = '[F]ile [R]ename' })
    vim.keymap.set('n', '<leader>fm', ':Move<Space>', { desc = '[F]ile [M]ove' })
    vim.keymap.set('n', '<leader>fd', function()
      if vim.fn.confirm('Delete ' .. vim.fn.expand('%:t') .. '?', '&Yes\n&No', 2) == 1 then
        vim.cmd('Delete!')
      end
    end, { desc = '[F]ile [D]elete' })
    vim.keymap.set('n', '<leader>fc', ':Chmod<Space>', { desc = '[F]ile [C]hmod' })
    vim.keymap.set('n', '<leader>fD', ':Mkdir<Space>', { desc = '[F]ile Create [D]irectory' })
    
    -- Add file operations group to which-key
    vim.api.nvim_create_autocmd('User', {
      pattern = 'VeryLazy',
      callback = function()
        local wk_ok, wk = pcall(require, 'which-key')
        if wk_ok then
          wk.add({
            { '<leader>f', group = '[F]ile Operations' },
          })
        end
      end,
    })
  end,
}