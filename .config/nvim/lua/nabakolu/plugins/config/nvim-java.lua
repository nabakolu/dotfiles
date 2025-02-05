require 'java'.setup()


local Path = require("plenary.path")
local scan = require("plenary.scandir")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function restart_jdtls()
    for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.name == "jdtls" then
            print("Restarting JDTLS...")
            vim.lsp.stop_client(client.id, true)
            vim.defer_fn(function()
                vim.cmd("edit") -- Reloads the buffer to trigger JDTLS restart
            end, 500)
            return
        end
    end
end


local function find_config_folders()
    local workspace_root = vim.fn.expand("~/.cache/nvim/jdtls/workspaces/")
    local workspace_dirs = scan.scan_dir(workspace_root, { hidden = true, only_dirs = true, depth = 1 })
    local valid_folders = {}

    for _, workspace in ipairs(workspace_dirs) do
        if not workspace:match("jdt.ls%-java%-project$") then -- Exclude unwanted workspace
            local config_dirs = scan.scan_dir(workspace, { hidden = true, only_dirs = true, depth = 1 })

            for _, config_folder in ipairs(config_dirs) do
                local project_file = config_folder .. "/.project"
                if Path:new(project_file):exists() then
                    local file_content = Path:new(project_file):read()
                    local location = file_content:match("<location>(.-)</location>")

                    if location then
                        table.insert(valid_folders, { folder = config_folder, location = location })
                    end
                end
            end
        end
    end

    return valid_folders
end

local function select_config_folder(callback)
    local folders = find_config_folders()

    if #folders == 0 then
        print("No JDTLS config folders found.")
        return
    elseif #folders == 1 then
        callback(folders[1])
        return
    end

    pickers.new({}, {
        prompt_title = "Select JDTLS Config Folder",
        finder = finders.new_table({
            results = folders,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.location .. " → " .. entry.folder,
                    ordinal = entry.location
                }
            end
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()
                callback(selection.value)
            end)
            return true
        end,
    }):find()
end

local function select_classpath_entry(config_folder_data)
    local classpath_file = config_folder_data.folder .. "/.classpath"
    local classpath_entries = {}

    if not Path:new(classpath_file):exists() then
        print(".classpath file not found in " .. config_folder_data.folder)
        return
    end

    local file_content = Path:new(classpath_file):read()
    for entry in file_content:gmatch('<classpathentry[^>]-kind="src"[^>]-path="([^"]+)"[^>]*/>') do
        table.insert(classpath_entries, { path = entry, location = config_folder_data.location })
    end

    if #classpath_entries == 0 then
        print("No classpath entries found.")
        return
    end

    pickers.new({}, {
        prompt_title = "Select Classpath Entry to Edit",
        finder = finders.new_table({
            results = classpath_entries,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.location .. " → " .. entry.path,
                    ordinal = entry.path
                }
            end
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                vim.ui.input({
                    prompt = "New path for " .. selection.value.path .. ": ",
                    default = selection.value.path
                }, function(new_path)
                    if new_path and new_path ~= "" then
                        local new_content = file_content:gsub(
                            '(<classpathentry[^>]-path=")' .. selection.value.path .. '(")',
                            "%1" .. new_path .. "%2"
                        )
                        Path:new(classpath_file):write(new_content, "w")
                        print("Updated .classpath entry!")
                        restart_jdtls()
                    end
                end)
            end)
            return true
        end,
    }):find()
end

local function select_project_location()
    local projects = find_config_folders()

    if #projects == 0 then
        print("No JDTLS projects found.")
        return
    end

    pickers.new({}, {
        prompt_title = "Select JDTLS Project to Edit Location",
        finder = finders.new_table({
            results = projects,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.location .. " → " .. entry.folder,
                    ordinal = entry.location
                }
            end
        }),
        sorter = conf.generic_sorter({}),
        attach_mappings = function(prompt_bufnr, _)
            actions.select_default:replace(function()
                actions.close(prompt_bufnr)
                local selection = action_state.get_selected_entry()

                local project_file = selection.value.folder .. "/.project"
                local file_content = Path:new(project_file):read()

                vim.ui.input({
                    prompt = "New project location for " .. selection.value.location .. ": ",
                    default = selection.value.location
                }, function(new_location)
                    if new_location and new_location ~= "" then
                        local new_content = file_content:gsub(
                            '(<location>).-</location>',
                            '%1' .. new_location .. '</location>'
                        )
                        Path:new(project_file):write(new_content, "w")
                        print("Updated project location in .project!")
                        restart_jdtls()
                    end
                end)
            end)
            return true
        end,
    }):find()
end

vim.api.nvim_create_user_command("EditJdtlsClasspath", function()
    select_config_folder(select_classpath_entry)
end, {})

vim.api.nvim_create_user_command("EditJdtlsProjectLocation", function()
    select_project_location()
end, {})
