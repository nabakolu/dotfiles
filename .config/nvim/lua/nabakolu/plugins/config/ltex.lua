local set_ltex_lang = function(lang)
    local clients = vim.lsp.buf_get_clients(0)

    for _, client in ipairs(clients) do
        if client.name == "ltex" then
            if lang == "disabled" then
                -- Stop the LTeX client
                client.stop()
                vim.notify("LTeX LSP disabled", vim.log.levels.INFO)
            else
                -- Change the language
                client.config.settings.ltex.language = lang
                vim.lsp.buf_notify(0, "workspace/didChangeConfiguration", { settings = client.config.settings })
                vim.notify("LTeX language set to " .. lang, vim.log.levels.INFO)
            end
            return
        end
    end

    -- If we get here, no LTeX client was found
    if lang ~= "disabled" then
        vim.defer_fn(function()
            -- Start the language server
            local client_id = vim.lsp.start({
                name = "ltex",
                cmd = { "ltex-ls" },
                root_dir = vim.fn.getcwd(),
                settings = {
                    ltex = {
                        language = lang,
                        enabled = true,
                        checkFrequency = "save"
                    }
                },
            })

            -- Manually attach to current buffer if needed
            if client_id then
                vim.lsp.buf_attach_client(0, client_id)
            end
        vim.notify("Started LTeX LSP with language " .. lang, vim.log.levels.INFO)

        end, 150)
    end
end

local pick_ltex_lang = function()
    local options = {
        "en-US",
        "de-DE",
        "disabled"
    }

    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")
    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local conf = require("telescope.config").values

    pickers.new({}, {
        prompt_title = "Select LTeX Language",
        finder = finders.new_table({
            results = options
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                set_ltex_lang(selection[1])
            end)
            return true
        end,
    }):find()
end

-- Create a command for easy access
vim.api.nvim_create_user_command("LtexLang", pick_ltex_lang, {})
vim.keymap.set('n', '<leader>l', '<cmd>LtexLang<cr>', {desc="choose ltex language"})
