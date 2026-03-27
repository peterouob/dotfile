return {
  {
    "saghen/blink.cmp",
    version = "*", -- 建議使用最新版本，或鎖定 "v0.*" 視穩定性而定
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "xzbdmw/colorful-menu.nvim", -- 用於豐富的選單色彩
      "rafamadriz/friendly-snippets", -- 實用的程式碼片段集合
      -- 如果你需要 luasnip 引擎才加下面這個，否則 blink 原生已支持 snippets
      -- "L3MON4D3/LuaSnip", 
    },
    opts = {
      -- 1. 外觀設定
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono", -- 調整為 'mono' 通常能解決圖標裁切或對齊問題
      },

      -- 2. 來源設定
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        -- 調整權重：這裡降低 snippets 優先級，避免它蓋過 LSP 提示
        providers = {
          snippets = {
            score_offset = -3, -- 設定負分，讓它排在 LSP 後面但仍可見
          },
          lsp = {
            score_offset = 0,
          },
        },
      },

      -- 3. 補全行為與介面
      completion = {
        accept = { auto_brackets = { enabled = true } }, -- 自動補全括號 ()

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 250,
          window = { border = "rounded" }, -- 美化：文檔懸浮窗圓角
        },

        menu = {
          auto_show = true,
          border = "rounded", -- 美化：補全選單圓角
          
          -- Colorful-menu 的核心繪製設定
          draw = {
            -- 定義列的佈局：[圖標] [文字標籤 (含色彩)]
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                width = { fill = true, max = 60 }, -- 限制最大寬度，避免選單過寬
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
        
        -- 美化：幽靈文字 (Ghost Text)，像 Copilot 一樣預覽補全內容
        ghost_text = {
          enabled = true,
        },
      },

      -- 4. 按鍵映射 (Keymaps)
      -- 'default' 預設包含了 C-space, C-e, Enter 等
      -- 這裡我們針對你的習慣進行客製化
      keymap = {
        preset = "default",
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        
        -- 按 Enter 選擇並接受
        ["<CR>"] = { "select_and_accept", "fallback" },
        ["<Esc>"] = {"cancel", "fallback"}
        -- 若你習慣 Tab 鍵選下一個，可以取消註解下方這行：
        -- ["<Tab>"] = { "select_next", "fallback" },
        -- ["<S-Tab>"] = { "select_prev", "fallback" },
      },

      signature = { 
        enabled = true, 
        window = { border = "rounded" } -- 美化：函式簽名提示圓角
      },
      
      cmdline = {
        enabled = true,
        completion = { 
          menu = { auto_show = true } 
        } 
      },
    },
    -- 5. Config 設定
    config = function(_, opts)
      
      -- 初始化 blink.cmp
      require("blink.cmp").setup(opts)
    end,
  },
}
