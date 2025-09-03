return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "xzbdmw/colorful-menu.nvim",
      "rafamadriz/friendly-snippets",
    },
    main = "blink.cmp",
    opts = {
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
      completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 250 },
        menu = {
          auto_show = true,
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
      },
      keymap = {
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      },
      signature = { enabled = true },
      cmdline = { completion = { menu = { auto_show = true } } },
      -- 建議先把 snippets 的加權關掉，避免把 LSP 擠到下方看不到
      sources = { providers = { snippets = { score_offset = 0 } } },
    },
    config = function(_, opts)
      vim.opt.termguicolors = true
      require("colorful-menu").setup()
      require("blink.cmp").setup(opts)
      pcall(function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end)
    end,
  },
}
