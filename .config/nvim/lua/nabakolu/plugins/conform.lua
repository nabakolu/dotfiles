return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        json = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        vue = { "prettier" },
        markdown = { "prettier" },
        python = { "isort", "black" },
        bibtex = { "bibtex-tidy" },
        tex = { "latexindent" },
        sh = { "shfmt" },
      }

    })

    vim.api.nvim_create_user_command("Format", function(args)
      local range = nil
      if args.count ~= -1 then
        local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ["end"] = { args.line2, end_line:len() },
        }
      end
      require("conform").format({ async = true, lsp_fallback = true, range = range })
    end, { range = true })

    vim.keymap.set({ "n", "v" }, "<leader>F", "<cmd>Format<CR>", { desc = "Format file or range" })
  end
}
