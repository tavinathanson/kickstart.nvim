return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = function()
    local autopairs = require('nvim-autopairs')
    
    autopairs.setup({
      check_ts = true, -- Enable treesitter integration
      ts_config = {
        lua = { 'string' }, -- Don't add pairs in lua string treesitter nodes
        javascript = { 'template_string' }, -- Don't add pairs in javascript template_string
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
      fast_wrap = {
        map = '<M-e>', -- Alt-e to trigger fast wrap
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        before_key = 'h',
        after_key = 'l',
        cursor_pos_before = true,
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        manual_position = true,
        highlight = 'Search',
        highlight_grey = 'Comment'
      },
    })
    
    -- Since you're using blink.cmp (not nvim-cmp), we skip the cmp integration
    -- Blink.cmp doesn't have the same API as nvim-cmp for autopairs
    -- The basic autopairs functionality will still work perfectly!
  end,
}