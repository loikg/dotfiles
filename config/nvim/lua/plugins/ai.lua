return {
    {
        "olimorris/codecompanion.nvim",
        version = "^19.0.0",
        opts = {
            interactions = {
                chat = {
                    adapter = {
                        name = "opencode"
                    },
                    opts = {
                        completion_provider = "blink",
                    }
                }
            },
            display = {
                chat = {
                    show_context = true,
                    show_header_separator = true,
                    show_settings = false,
                    show_token_count = true,
                    show_tools_processing = true,
                    start_in_insert_mode = false,
                    window = {
                        width = 0.25,
                    }
                },
            },
        },
        init = function()
            vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>",
                { noremap = true, silent = true })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        enabled = false,
        opts = {
            provider = "copilot",
        },
        build = "make",
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "stevearc/dressing.nvim",
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            --- The below dependencies are optional,
            -- "echasnovski/mini.pick",     -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
            {
                "zbirenbaum/copilot.lua",
                config = function()
                    require('copilot').setup({
                        suggestion = { enabled = false },
                        panel = { enabled = false },
                    })
                end
            }, -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                'MeanderingProgrammer/render-markdown.nvim',
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    }
}
