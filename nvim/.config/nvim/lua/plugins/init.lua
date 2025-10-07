return {
  -- 格式化插件
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- 可解鎖自動格式化
    config = function ()
      require("configs.conform")
    end
  },

  -- LSP 設定
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Go 語言支持
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("go").setup()
    end,
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
  },

  -- Leetcode.nvim
  {
    "kawre/leetcode.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "muniftanjim/nui.nvim",
    },
    lazy = false,
    opts = {},
  },

  --Markdown 支持（MDX）
  {
    "davidmh/mdx.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = true,
    lazy = false,
  },

  -- Rustaceanvim
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
  },

  -- LazyDocker
  {
    "mgierada/lazydocker.nvim",
    dependencies = { "akinsho/toggleterm.nvim" },
    config = function()
      require("lazydocker").setup { border = "curved" }
    end,
    event = "BufRead",
    keys = {
      {
        "<leader>ld",
        function()
          require("lazydocker").open()
        end,
        desc = "開啟 LazyDocker",
      },
    },
    lazy = false,
  },

  -- 圖片預覽
  {
    "adelarsq/image_preview.nvim",
    lazy = false,
    config = function()
      require("image_preview").setup()
    end,
  },

  -- LSP 進度指示
  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {},
  },

  -- 問題檢視
  {
    "folke/trouble.nvim",
    dependencies = { "echasnovski/mini.icons" },
    lazy = false,
    opts = {},
  },

  -- Markdown 預覽
--  {
--    "iamcco/markdown-preview.nvim",
--    lazy = false,
--    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--    build = "cd app && yarn install",
--    init = function()
--      vim.g.mkdp_filetypes = { "markdown" }
--    end,
--    ft = { "markdown" },
--  },
--
  -- 調試支持
  {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
  },

  -- dab ui
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, lazy = false },

  {
    "nvimtools/none-ls.nvim",
    lazy = false,
    ft = { "python" },
    opts = function()
      return require "configs.null-ls"
    end,
  },
  {
    "pteroctopus/faster.nvim",
    lazy = false,
  },
  { "nvzone/volt", lazy = false },
  { "nvzone/menu", lazy = false },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    -- optional for icon support
    -- dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    dependencies = { "echasnovski/mini.icons" },
    opts = {},
  },
}
