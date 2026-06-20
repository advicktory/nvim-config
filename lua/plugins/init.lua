-- ~/.config/nvim/lua/plugins/init.lua
-- All plugins in one file — easy to retool, easy to read
-- <leader> is space

return {
  ---------------------------------------------------------------------------
  -- COLORS: catppuccin
  ---------------------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = false,
      integrations = { treesitter = true, native_lsp = true, telescope = true, which_key = true },
    },
    config = function()
      vim.cmd.colorscheme("moss")
    end,
  },

  ---------------------------------------------------------------------------
  -- RAINBOW BRACKETS: alternating ({[]}) colors
  --------------------------------------------------------------------------
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  ---------------------------------------------------------------------------
  -- START SCREEN: alpha-nvim — moss minimal
  ---------------------------------------------------------------------------
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        [[                                   ]],
        [[              moss                 ]],
        [[              ~~~~                 ]],
        [[       leader: ]] .. vim.g.mapleader,
        [[                                   ]],
      }
      dashboard.section.header.opts.hl = "Function"
      dashboard.section.buttons.val = {
        dashboard.button("rr", "find file"),
        dashboard.button("rz", "live grep"),
        dashboard.button("fb", "buffers"),
        dashboard.button("p",  "explorer"),
        dashboard.button("c",  "config"),
      }
      dashboard.section.footer.val = {
        "new file  :e <name>",
      }
      dashboard.section.buttons.opts.spacing = 1
      alpha.setup(dashboard.opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        callback = function()
          vim.opt_local.cursorline = false
          vim.opt_local.wrap = false
          vim.opt_local.sidescroll = 0
          vim.opt_local.sidescrolloff = 999
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- MARKDOWN PREVIEW: live-updating browser preview (Mermaid, PlantUML, etc.)
  --   <leader>mp = toggle preview in browser
  --   :MarkdownPreview / :MarkdownPreviewStop / :MarkdownPreviewToggle
  ---------------------------------------------------------------------------
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    keys = {
      { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown preview (browser)" },
    },
  },

  ---------------------------------------------------------------------------
  -- TREESITTER
  ---------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "lua", "vim", "vimdoc", "javascript", "typescript", "tsx",
        "json", "yaml", "toml", "markdown", "markdown_inline",
        "bash", "diff", "gitignore", "nim",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
    config = function(_, opts)
      -- Register custom Nim parser before setup
      local parsers = require("nvim-treesitter.parsers")
      if not parsers.nim then
        parsers.nim = {
          install_info = {
            url = "https://github.com/alaviss/tree-sitter-nim",
            files = { "src/parser.c", "src/scanner.c" },
            branch = "main",
          },
          filetype = "nim",
        }
      end
      require("nvim-treesitter.config").setup(opts)
      -- Neovim 0.12: treesitter must be explicitly started per buffer
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- MASON
  ---------------------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        keymaps = {
          install_package = "I",     -- Shift+I installs, frees up 'i' for movement
          uninstall_package = "X",   -- Shift+X uninstalls
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = { "lua_ls", "ts_ls", "eslint", "jsonls", "bashls", "marksman", "nim_langserver" },
      automatic_installation = true,
    },
  },

  ---------------------------------------------------------------------------
  -- LSP
  ---------------------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local ok, lspconfig = pcall(require, "lspconfig")
      if not ok then return end
      local ok2, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = ok2 and cmp_lsp.default_capabilities() or {}

      local ok3, mason_lsp = pcall(require, "mason-lspconfig")
      if ok3 and mason_lsp.setup_handlers then
        mason_lsp.setup_handlers({
          function(server)
            pcall(function()
              lspconfig[server].setup({ capabilities = capabilities })
            end)
          end,
        })
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = ev.buf, desc = desc })
          end
          map("ze", vim.lsp.buf.definition, "Go to definition")
          map("zf", vim.lsp.buf.references, "References")
          map("I", vim.lsp.buf.hover, "Hover")
          map("<leader>fj", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("<leader>er", vim.diagnostic.open_float, "Diagnostic float")
          map("[e", vim.diagnostic.goto_prev, "Previous diagnostic")
          map("]e", vim.diagnostic.goto_next, "Next diagnostic")
        end,
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- AUTOCOMPLETE
  ---------------------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local ok, cmp = pcall(require, "cmp")
      if not ok then return end
      cmp.setup({
        snippet = {
          expand = function(args)
            pcall(function() require("luasnip").lsp_expand(args.body) end)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item() else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item() else fallback() end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  ---------------------------------------------------------------------------
  -- TELESCOPE
  ---------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader>rr", "<cmd>Telescope find_files<cr>",    desc = "Find files" },
      { "<leader>rz", "<cmd>Telescope live_grep<cr>",     desc = "Live grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>",       desc = "Buffers" },
      { "<leader>rh", "<cmd>Telescope help_tags<cr>",     desc = "Help" },
      { "<leader>re", "<cmd>Telescope diagnostics<cr>",   desc = "Diagnostics" },
    },
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        file_ignore_patterns = {},     -- show dotfiles and hidden files
        vimgrep_arguments = {
          "rg", "--hidden", "--color=never", "--no-heading",
          "--with-filename", "--line-number", "--column", "--smart-case",
        },
        mappings = {
          i = {
            ["n"]  = "move_selection_previous",  -- phys j → prev item
            ["i"]  = "move_selection_next",      -- phys k → next item
            ["l"]  = "select_default",          -- phys ; → open selected
          },
          n = {
            ["n"]  = "move_selection_previous",
            ["i"]  = "move_selection_next",
            ["l"]  = "select_default",
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- NEO-TREE
  ---------------------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = "Neotree",
    keys = {
      { "<leader>p", "<cmd>Neotree toggle<cr>", desc = "Toggle file explorer" },
    },
    opts = {
      close_if_last_window = true,
      window = {
        width = 35,
        mappings = {
          ["n"]  = "navigate_up",
          ["i"]  = function() vim.cmd("normal! j") end,
          ["o"]  = function() vim.cmd("normal! k") end,
          ["l"]  = "open",
          ["<space>"] = "none",
        },
      },
      filesystem = { filtered_items = { hide_dotfiles = false, hide_gitignored = true } },
    },
  },

  ---------------------------------------------------------------------------
  -- HARPOON: mark files, jump instantly
  --   <leader>ha = add file
  --   <leader>hm = menu
  --   <leader>h1-4 = jump to file 1-4
  ---------------------------------------------------------------------------
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end,               desc = "Add file" },
      { "<leader>h,", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end, desc = "Menu" },
      { "<leader>h1", function() require("harpoon"):list():select(1) end,           desc = "File 1" },
      { "<leader>h2", function() require("harpoon"):list():select(2) end,           desc = "File 2" },
      { "<leader>h3", function() require("harpoon"):list():select(3) end,           desc = "File 3" },
      { "<leader>h4", function() require("harpoon"):list():select(4) end,           desc = "File 4" },
    },
  },

  ---------------------------------------------------------------------------
  -- AI COMPLETION: ghost-text completions via Ollama (Copilot-style)
  -- Prereq: brew install ollama && ollama pull qwen3:1.7b
  ---------------------------------------------------------------------------
  {
    "milanglacier/minuet-ai.nvim",
    opts = {
      provider = "openai_fim_compatible",
      n_completions = 1,
      context_window = 512,
      throttle = 600,
      debounce = 300,
      provider_options = {
        openai_fim_compatible = {
          api_key = "TERM",
          name = "Ollama",
          end_point = "http://127.0.0.1:11434/v1/completions",
          model = "qwen2.5-coder:3b",
          optional = {
            max_tokens = 40,
            top_p = 0.9,
          },
        },
      },
      virtualtext = {
        auto_trigger_ft = { "*" },  -- enable for all filetypes
        keymap = {
          accept      = "<Tab>",
          accept_line = "<C-l>",
          next        = "<C-]>",
          dismiss     = "<C-e>",
        },
      },
      notify = false,
    },
  },

  ---------------------------------------------------------------------------
  -- AI CHAT: on-device via Ollama (codecompanion.nvim)
  ---------------------------------------------------------------------------
  {
    "olimorris/codecompanion.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
    keys = {
      { "<leader>ac", "<cmd>CodeCompanionChat<cr>",                      desc = "AI chat" },
      { "<leader>ak", ":CodeCompanion ",             mode = { "n", "x" }, desc = "AI inline" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>",                      desc = "AI actions" },
    },
    opts = {
      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = { model = { default = "qwen2.5-coder:3b" } },
          })
        end,
      },
    },
  },

  ---------------------------------------------------------------------------
  -- WHICH-KEY
  ---------------------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {},
  },

  ---------------------------------------------------------------------------
  -- LUALINE
  ---------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin",
        component_separators = "|",
        section_separators = "",
      },
    },
  },

  ---------------------------------------------------------------------------
  -- GITSIGNS
  ---------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      on_attach = function(bufnr)
        local ok, gs = pcall(require, "gitsigns")
        if not ok then return end
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        map("]h", gs.next_hunk, "Next hunk")
        map("[h", gs.prev_hunk, "Prev hunk")
        map("<leader>hs", gs.stage_hunk, "Stage hunk")
        map("<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("<leader>hf", gs.reset_hunk, "Reset hunk")
        map("<leader>hp", gs.preview_hunk, "Preview hunk")
        map("<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
      end,
    },
  },

  ---------------------------------------------------------------------------
  -- CSV VIEW: tabular display for CSV/TSV files
  --   <leader>cv = toggle view
  --   :CsvViewToggle / :CsvViewEnable / :CsvViewDisable
  --   if/af = text objects for fields
  ---------------------------------------------------------------------------
  {
    "hat0uma/csvview.nvim",
    ft = { "csv", "tsv" },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    keys = {
      { "<leader>cv", "<cmd>CsvViewToggle<cr>", desc = "Toggle CSV view" },
    },
    opts = {
      parser = { comments = { "#", "//" } },
      view = { display_mode = "border" },
      keymaps = {
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        jump_next_field_end = { "k",  mode = { "n", "v" } },
        jump_prev_field_end = { "K",  mode = { "n", "v" } },
        jump_next_row =       { "u",  mode = { "n", "v" } },
        jump_prev_row =       { "U",  mode = { "n", "v" } },
      },
    },
  },

  ---------------------------------------------------------------------------
  -- AUTO-PAIRS
  ---------------------------------------------------------------------------
  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },

  ---------------------------------------------------------------------------
  -- COMMENT: gcc = toggle line, gc = toggle visual selection
  ---------------------------------------------------------------------------
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = {} },

  ---------------------------------------------------------------------------
  -- INDENT GUIDES
  ---------------------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "VeryLazy",
    opts = { scope = { enabled = false } },
  },

  ---------------------------------------------------------------------------
  -- TODO COMMENTS: highlight TODO/FIXME/HACK + <leader>st to search
  ---------------------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {},
    keys = { { "<leader>sz", "<cmd>TodoTelescope<cr>", desc = "Search TODOs" } },
  },
}
