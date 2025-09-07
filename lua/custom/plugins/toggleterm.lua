-- ToggleTerm plugin for quick pop-up terminals
-- Provides floating terminal functionality while keeping tmux for persistent sessions
return {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Size settings for different orientations
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,
      
      -- Default to floating terminal for quick access
      open_mapping = [[<c-\>]],
      
      -- Hide terminal numbers in terminal buffers
      hide_numbers = true,
      
      -- Shade terminals to distinguish from regular buffers
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      
      -- Start in insert mode when opening
      start_in_insert = true,
      
      -- Remember terminal sessions across vim restarts
      persist_size = true,
      persist_mode = true,
      
      -- Float terminal is the default - quick access without disrupting layout
      direction = 'float',
      
      -- Close terminal when process exits
      close_on_exit = true,
      
      -- Shell to use (will default to your $SHELL)
      shell = vim.o.shell,
      
      -- Floating terminal specific settings
      float_opts = {
        -- Border style: 'single', 'double', 'rounded', 'curved', etc.
        border = 'rounded',
        
        -- Size and position
        width = function()
          return math.floor(vim.o.columns * 0.8)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.8)
        end,
        
        -- Window transparency (if supported by terminal)
        winblend = 3,
        
        -- Highlight groups for border
        highlights = {
          border = "Normal",
          background = "Normal",
        }
      },
    })

    -- Terminal keymaps that work inside terminal mode
    function _G.set_terminal_keymaps()
      local opts = {buffer = 0}
      -- Use <Esc> to exit terminal mode (matches main config style)
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      
      -- Window navigation from terminal mode
      -- These mirror the normal mode <C-hjkl> mappings
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
      
      -- Quick toggle floating terminal
      vim.keymap.set('t', '<C-\\>', '<cmd>ToggleTerm<cr>', opts)
    end

    -- Apply terminal keymaps when terminal opens
    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

    -- Convenience commands for specific terminal types
    local Terminal = require('toggleterm.terminal').Terminal
    
    -- Lazygit terminal - for git operations
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- Function to run on opening
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    -- Python REPL terminal
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      float_opts = {
        border = "curved",
      },
    })

    function _python_toggle()
      python:toggle()
    end

    -- Node REPL terminal  
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
    })

    function _node_toggle()
      node:toggle()
    end

    -- Set up convenient keymaps for specialized terminals
    vim.api.nvim_set_keymap("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true, desc = "[T]erminal: Lazy[g]it"})
    vim.api.nvim_set_keymap("n", "<leader>tp", "<cmd>lua _python_toggle()<CR>", {noremap = true, silent = true, desc = "[T]erminal: [P]ython REPL"})
    vim.api.nvim_set_keymap("n", "<leader>tn", "<cmd>lua _node_toggle()<CR>", {noremap = true, silent = true, desc = "[T]erminal: [N]ode REPL"})
    
    -- Quick access to different terminal directions
    vim.api.nvim_set_keymap("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", {noremap = true, silent = true, desc = "[T]erminal: [F]loating"})
    vim.api.nvim_set_keymap("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", {noremap = true, silent = true, desc = "[T]erminal: [H]orizontal"})
    vim.api.nvim_set_keymap("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", {noremap = true, silent = true, desc = "[T]erminal: [V]ertical"})
  end,
}