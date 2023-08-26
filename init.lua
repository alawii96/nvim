if vim.fn.has('nvim-0.9') == 0 then
  error('Need Neovim v0.9+ in order to run Cosmic!')
end

local ok, err = pcall(require, 'cosmic')

if not ok then
  error(('Error loading core...\n\n%s'):format(err))
end

local rt = require('rust-tools')

rt.setup({
  assist = {
    importEnforceGranularity = true,
    importPrefix = 'crate',
  },
  cargo = {
    allFeatures = true,
  },
  checkOnSave = {
    command = 'clippy',
  },
  inlayHints = { locationLinks = false },
  diagnostics = {
    enable = true,
    experimental = {
      enable = true,
    },
  },
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
