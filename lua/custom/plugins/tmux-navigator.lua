-- Tmux Navigator plugin for seamless navigation between vim splits and tmux panes
-- Provides consistent <C-hjkl> navigation across both environments
return {
  'christoomey/vim-tmux-navigator',
  lazy = false,  -- Load immediately for navigation to work properly
  config = function()
    -- Disable default mappings so we can customize them
    vim.g.tmux_navigator_no_mappings = 1
    
    -- Save on switch - automatically save modified buffers when leaving vim
    vim.g.tmux_navigator_save_on_switch = 2
    
    -- Disable tmux navigator when zooming the Vim pane
    vim.g.tmux_navigator_disable_when_zoomed = 1
    
    -- Preserve zoom when navigating
    vim.g.tmux_navigator_preserve_zoom = 1
    
    -- Set up our custom keymaps that match the init.lua style
    -- These will work seamlessly with tmux if it's configured properly
    vim.keymap.set('n', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate left (tmux-aware)', silent = true })
    vim.keymap.set('n', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate down (tmux-aware)', silent = true })
    vim.keymap.set('n', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate up (tmux-aware)', silent = true })
    vim.keymap.set('n', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate right (tmux-aware)', silent = true })
    
    -- Also map in insert and visual modes for consistency
    vim.keymap.set('i', '<C-h>', '<C-\\><C-n><cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate left (tmux-aware)', silent = true })
    vim.keymap.set('i', '<C-j>', '<C-\\><C-n><cmd>TmuxNavigateDown<cr>', { desc = 'Navigate down (tmux-aware)', silent = true })
    vim.keymap.set('i', '<C-k>', '<C-\\><C-n><cmd>TmuxNavigateUp<cr>', { desc = 'Navigate up (tmux-aware)', silent = true })
    vim.keymap.set('i', '<C-l>', '<C-\\><C-n><cmd>TmuxNavigateRight<cr>', { desc = 'Navigate right (tmux-aware)', silent = true })
    
    vim.keymap.set('v', '<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate left (tmux-aware)', silent = true })
    vim.keymap.set('v', '<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Navigate down (tmux-aware)', silent = true })
    vim.keymap.set('v', '<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Navigate up (tmux-aware)', silent = true })
    vim.keymap.set('v', '<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Navigate right (tmux-aware)', silent = true })
    
    -- Terminal mode mappings - these allow navigation from terminal buffers
    vim.keymap.set('t', '<C-h>', '<C-\\><C-n><cmd>TmuxNavigateLeft<cr>', { desc = 'Navigate left from terminal (tmux-aware)', silent = true })
    vim.keymap.set('t', '<C-j>', '<C-\\><C-n><cmd>TmuxNavigateDown<cr>', { desc = 'Navigate down from terminal (tmux-aware)', silent = true })
    vim.keymap.set('t', '<C-k>', '<C-\\><C-n><cmd>TmuxNavigateUp<cr>', { desc = 'Navigate up from terminal (tmux-aware)', silent = true })
    vim.keymap.set('t', '<C-l>', '<C-\\><C-n><cmd>TmuxNavigateRight<cr>', { desc = 'Navigate right from terminal (tmux-aware)', silent = true })
    
    -- Optional: Add a keymap to navigate to the previous pane
    vim.keymap.set('n', '<C-\\>', '<cmd>TmuxNavigatePrevious<cr>', { desc = 'Navigate to previous pane (tmux-aware)', silent = true })
    
    -- Helper function to check if we're in tmux
    function _G.is_in_tmux()
      return vim.env.TMUX ~= nil
    end
    
    -- Show tmux status in statusline when in tmux
    if vim.env.TMUX then
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function()
          vim.defer_fn(function()
            vim.notify("Tmux navigation enabled - use <C-hjkl> to move between panes", vim.log.levels.INFO, { title = "Tmux Navigator" })
          end, 100)
        end,
        once = true,
      })
    end
  end,
}