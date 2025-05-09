return {
  'saghen/blink.cmp',

  opts = {
    keymap = {
      preset = 'default',
      ['<C-n>'] = { 'show', 'select_next' },
      ['<C-p>'] = { 'show', 'select_prev' },
    },

    cmdline = {
      keymap = {
        preset = 'inherit',
        ['<Tab>'] = { 'show', 'select_next' },
        ['<S-Tab>'] = { 'show', 'select_prev' },
      },
      completion = {
        list = { selection = { preselect = false } },
        menu = { auto_show = true },
      },
    },

    appearance = {
      nerd_font_variant = 'mono',
      kind_icons = {
        Folder = "",
        File = "",
      }
    },

    completion = {
      list = { selection = { preselect = false } },
      documentation = { auto_show = true },
    },

    signature = { enabled = true },

    sources = {
      default = { 'lsp', 'path', 'buffer' },

      providers = {
        path = {
          opts = {
            show_hidden_files_by_default = true,
          }
        },
      },
    },

    fuzzy = { implementation = "lua" }
  },
  opts_extend = { "sources.default" }
}
