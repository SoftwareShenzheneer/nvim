return {
    "lewis6991/gitsigns.nvim",

    opts = {
        signs = {
            add          = { text = "┃" },
            change       = { text = "┃" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        },

        signs_staged = {
            add          = { text = "┃" },
            change       = { text = "┃" },
            delete       = { text = "_" },
            topdelete    = { text = "‾" },
            changedelete = { text = "~" },
            untracked    = { text = "┆" },
        },

        signs_staged_enable = true,

        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,

        watch_gitdir = {
            follow_files = true,
        },

        auto_attach = true,
        attach_to_untracked = false,

        current_line_blame = false,

        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = "eol",
            delay = 1000,
            ignore_whitespace = false,
            virt_text_priority = 100,
            use_focus = true,
        },

        current_line_blame_formatter =
            "<author>, <author_time:%R> - <summary>",

        blame_formatter = nil,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil,
        max_file_length = 40000,

        preview_config = {
            style = "minimal",
            relative = "cursor",
            row = 0,
            col = 1,
        },

        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local function map(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, {
                    buffer = bufnr,
                    silent = true,
                    desc = desc,
                })
            end

            -- Navigation
            map("n", "]c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "]c", bang = true })
                else
                    gitsigns.nav_hunk("next")
                end
            end, "Next hunk")

            map("n", "[c", function()
                if vim.wo.diff then
                    vim.cmd.normal({ "[c", bang = true })
                else
                    gitsigns.nav_hunk("prev")
                end
            end, "Previous hunk")

            -- Actions
            map("n", "<leader>hs", gitsigns.stage_hunk, "Stage hunk")
            map("n", "<leader>hr", gitsigns.reset_hunk, "Reset hunk")

            map("v", "<leader>hs", function()
                gitsigns.stage_hunk({
                    vim.fn.line("."),
                    vim.fn.line("v"),
                })
            end, "Stage selection")

            map("v", "<leader>hr", function()
                gitsigns.reset_hunk({
                    vim.fn.line("."),
                    vim.fn.line("v"),
                })
            end, "Reset selection")

            map("n", "<leader>hS", gitsigns.stage_buffer, "Stage buffer")
            map("n", "<leader>hR", gitsigns.reset_buffer, "Reset buffer")

            map("n", "<leader>hp", gitsigns.preview_hunk, "Preview hunk")
            map("n", "<leader>hi", gitsigns.preview_hunk_inline, "Preview hunk inline")

            map("n", "<leader>hb", function()
                gitsigns.blame_line({ full = true })
            end, "Blame line")

            map("n", "<leader>hd", gitsigns.diffthis, "Diff this")

            map("n", "<leader>hD", function()
                gitsigns.diffthis("~")
            end, "Diff against ~")

            map("n", "<leader>hq", gitsigns.setqflist, "Hunks to quickfix")

            map("n", "<leader>hQ", function()
                gitsigns.setqflist("all")
            end, "All hunks to quickfix")

            -- Toggles
            map("n", "<leader>tb", gitsigns.toggle_current_line_blame,
                "Toggle current line blame")

            map("n", "<leader>tw", gitsigns.toggle_word_diff,
                "Toggle word diff")

            -- Text object
            map({ "o", "x" }, "ih", gitsigns.select_hunk, "Select hunk")
        end,
    },
}
