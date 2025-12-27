return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",           -- source for text in buffer
        "hrsh7th/cmp-path",             -- source for file system paths
        "L3MON4D3/LuaSnip",             -- snippets engine
        "saadparwaiz1/cmp_luasnip",     -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim",         -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = { -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(-4)),
                ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(4)),
                ["<C-Space>"] = cmp.mapping(cmp.mapping.complete()),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
            }),
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                },
                documentation = {
                    winhighlight = "FloatBorder:Pmenu",
                    border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
                }
            },
            -- sources for autocompletion
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" }, -- snippets
                { name = "buffer" },  -- text within current buffer
                { name = "path" },    -- file system paths
            }),

            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })
        vim.api.nvim_set_hl(0, "Pmenu", { fg = "#21202e", bg = "NONE" })
    end,
}

