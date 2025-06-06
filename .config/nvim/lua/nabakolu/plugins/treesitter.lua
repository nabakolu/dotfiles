return {
  'nvim-treesitter/nvim-treesitter',
  config = function()
    local parsers = require 'nvim-treesitter.parsers'
    function _G.ensure_treesitter_language_installed()
      local lang = parsers.get_buf_lang()
      if parsers.get_parser_configs()[lang] and not parsers.has_parser(lang) then
        vim.schedule_wrap(function()
          vim.cmd("TSInstallSync " .. lang)
          vim.cmd [[e!]]
        end)()
      end
    end

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "*",
      callback = function()
        ensure_treesitter_language_installed()
      end,
    })

    local configs = require("nvim-treesitter.configs")
    configs.setup {
      highlight = {
        enable = true,    -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = true,

      },
      indent = { enable = true, disable = { "yaml" } },
    }
  end,
}
