local present, autosave = pcall(require, "autosave")
if not present then return end

autosave.setup {
    enabled = vim.g.auto_save, -- takes boolean value from init.lua
    debounce_delay = 500,
    execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
    events = { "InsertLeave" },
    conditions = {
        exists = true, 
        filetype_is_not = {},
        filename_is_not = { "packer_init.lua" }, 
        modifiable = true
    },
    write_all_buffers = false,
    on_off_commands = true,
    clean_command_line_interval = 2500,
}

